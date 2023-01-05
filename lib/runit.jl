function runit(info)
  #println(stderr,info)


  prob_home=info["prob_home"]
  solve=info["solve"]
  io_cases=info["io_cases"]
  

  res=[]
  tic,toc=mktictoc()
  for case in io_cases
    tic()
    open("testdir/$(case).out","w") do fout
      solve("$(prob_home)/io/$(case).in",fout)
    end
    got=open("testdir/$(case).out","r") do fout
      read(fout,String)
    end
    elapsed=toc()

    push!(res,(case=case,got=got,elapsed=elapsed))
  end
  info["res"]=res
end
