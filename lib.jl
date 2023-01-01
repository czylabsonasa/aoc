using Printf: @sprintf
using PrettyTables
using TOML

function configit(prob_name)
  # default
  config=TOML.parse(
    read("config.toml",String)
  )
  # override the default if necessary
  if isfile("$(prob_name)/config.toml")
    prob_config=TOML.parse(
      read("$(prob_name)/config.toml",String)
    )
    for (k,v) in prob_config
      config[k]=v
    end
  end
  config
end

function runit(info)
  #println(stderr,info)

  dir_name=info["dir_name"]
  part_name=info["part_name"]
  in_cases=info[part_name]["in"]
  part=info["part"]

  res=[]
  tic,toc=mktictoc()
  for case in in_cases
    tic()
    got=string(part("$(dir_name)/$(case)"))
    elapsed=toc()

    push!(res,(case=case,got=got,elapsed=elapsed))
  end
  info["res"]=res
end

function evalit(info)
  dir_name=info["dir_name"]
  part_name=info["part_name"]
  out_cases=info[part_name]["out"]
  res=info["res"]

  status=fill("",length(out_cases))
  for (i,case) in enumerate(out_cases)
    if !isfile("$(dir_name)/$(case)")
      status[i]="N/A"
      continue
    end
    expected=read(
      "$(dir_name)/$(case)",String
    )|>strip
    #printstyled("$(expected) vs $(res[i].got)\n" ,color=:red)
    if expected==res[i].got
      status[i]="OK"
    else
      status[i]="WA"
    end
  end
  info["status"]=status
end

function printit(info)
  h1 = Highlighter(f=(data, i, j)->(i==1),
                          crayon = crayon"yellow bold" )
  h2 = Highlighter(f=(data, i, j)->(i==2),
                          crayon = crayon"blue bold" )


  h3crayon(data,i,j)=if x=="OK"
      crayon"green"
    elseif x=="WA"
      crayon"red"
    else
      crayon"yellow"
    end

  # is it possible to Highlight by content?
  # a very ugly approach:
  hOK = Highlighter(f=(data, i, j)->(i>2) && (j==3) && data[i,j]=="OK",
                          crayon = crayon"green" )

  hWA = Highlighter(f=(data, i, j)->(i>2) && (j==3) && data[i,j]=="WA",
                          crayon = crayon"red" )

  hNA = Highlighter(f=(data, i, j)->(i>2) && (j==3) && data[i,j]=="N/A",
                          crayon = crayon"yellow" )


  dir_name=info["dir_name"]
  part_name=info["part_name"]
  in_cases=info[part_name]["in"]
  res=info["res"]
  status=info["status"]


  # fake header (by hand)
  header=[
    "" dir_name part_name "";
    "case" "got" "status" "elapsed(sec)"
  ]
  data=fill("",length(in_cases),4)
  for i in 1:length(in_cases)
    data[i,1]=res[i].case
    data[i,2]=res[i].got
    data[i,3]=status[i]
    data[i,4]=@sprintf "%.2e" res[i].elapsed
  end

  data=vcat(header,data)
  pretty_table(
    data;
    highlighters=(h1,h2,hOK,hWA,hNA),
    show_header=false,
    linebreaks=true,hlines=1:length(in_cases)+size(header,1),
    limit_printing=false,
  )
end
