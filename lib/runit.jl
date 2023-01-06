function runit(info)
  #println(stderr,info)


  prob_home=info["prob_home"]
  solve=info["solve"]
  io_cases=info["io_cases"]
  test_dir=info["test_dir"]
  

  res=[]
  tic,toc=mktictoc()
  for case in io_cases
    tic()
    open("$(test_dir)/$(case).out","w") do fout
      solve("$(prob_home)/io/$(case).in",fout)
    end
    got=open("$(test_dir)/$(case).out","r") do fout
      read(fout,String)
    end
    elapsed=toc()

    push!(res,(case=case,got=got,elapsed=elapsed))
  end
  info["res"]=res
end
