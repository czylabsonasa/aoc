using PrettyTables

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


  prob_id=info["prob_id"]
  io_cases=info["io_cases"]
  res=info["res"]
  status=info["status"]


  # fake header (by hand)
  header=[
    "" prob_id "" "";
    "case" "got" "status" "elapsed(sec)"
  ]
  data=fill("",length(io_cases),4)
  for i in 1:length(io_cases)
    data[i,1]=res[i].case*".in"
    data[i,2]=res[i].got
    data[i,3]=status[i]
    data[i,4]=@sprintf "%.2e" res[i].elapsed
  end

  data=vcat(header,data)
  pretty_table(
    data;
    highlighters=(h1,h2,hOK,hWA,hNA),
    show_header=false,
    linebreaks=true,hlines=1:length(io_cases)+size(header,1),
    limit_printing=false,
  )
end
