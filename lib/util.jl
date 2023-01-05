using Printf:@sprintf
pr_et(x)=@sprintf "%.3f sec" x
pr_msg(x)=printstyled(x,color=:light_cyan)
pr_err(x)=printstyled(x,color=:red)


function mktictoc()
  past=[]
  tic()=push!(past,time())
  toc()=past>[] ? time()-pop!(past) : 0.0
  tic,toc
end


import TOML
function configit(pathto,config=nothing)
  # default
  if isfile("$(pathto)/config.toml")
    temp=TOML.parsefile("$(pathto)/config.toml")
    if config===nothing
      return temp
    else
      # overwrites the old content
      for (k,v) in temp
        config[k]=v
      end
    end
  end
  
end

