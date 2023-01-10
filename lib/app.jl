# from tesztelek2
include("solve.jl")
function app()
  cnt=1
  while true
    fin=try 
      open("io/$(cnt).in","r") 
    catch
      nothing 
    end

    (fin==nothing) && break
    fout=open("io/$(cnt).run","w")

    t0=time()
    ok=1
    try 
      solve(fin,fout)
    catch
      ok=0
    end
    t0=time()-t0

    close(fin)
    close(fout)

    cnt=cnt+1
  end
end
app()
