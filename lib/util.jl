using Printf:@sprintf
using Crayons

function mkmsg()
  cmsg=Crayon(foreground=:light_blue)
  cet=Crayon(foreground=:light_yellow)

  function msg(msg,et=nothing)
    # if length(msg)>20
      # msg=msg[end-19:end]
    # end
    if et!==nothing
      @sprintf "\n%s\n%30s\n\n" cmsg(msg) cet(@sprintf "%.3f sec" et)
    else
      @sprintf "\n%s\n\n" cmsg(msg)
    end
  end
  msg
end

function mktictoc()
  past=[]
  tic()=push!(past,time())
  toc()=past>[] ? time()-pop!(past) : 0.0
  tic,toc
end
