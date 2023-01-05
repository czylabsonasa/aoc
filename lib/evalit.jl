function evalit(info)
  prob_home=info["prob_home"]
  io_cases=info["io_cases"]
  res=info["res"]

  status=fill("",length(io_cases))
  for (i,case) in enumerate(io_cases)
    if !isfile("$(prob_home)/io/$(case).out")
      status[i]="N/A"
      continue
    end
    expected=read(
      "$(prob_home)/io/$(case).out",String
    )|>strip
    #printstyled("$(expected) vs $(res[i].got)\n" ,color=:red)
    if expected==res[i].got|>strip
      status[i]="OK"
    else
      status[i]="WA"
    end
  end
  info["status"]=status
end
