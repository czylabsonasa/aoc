pr_msg(x)=printstyled(x,color=:light_cyan)
pr_err(x)=printstyled(x,color=:red)


function mktictoc()
  past=[]
  tic()=push!(past,time())
  toc()=past>[] ? time()-pop!(past) : 0.0
  tic,toc
end
