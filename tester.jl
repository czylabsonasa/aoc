#!/home/nosy/bin/julia

include("util.jl")
tic,toc=mktictoc()


tic()
import Pkg
Pkg.activate(".")
include("lib.jl")

pr_msg("getting up: $(round(toc(),digits=2)) sec\n")


deps=[
  "Printf","PrettyTables", # 
  "DataStructures", # 11,12: Queue
  "OffsetArrays", # 14,15,18(part2)
]




function tester()
  Pkg.instantiate()
  if isdefined(Main,:deps) && deps>[]
    Pkg.add.(deps)
  end
  nothing
end

function tester(akt)
  if !isfile(akt)
    pr_err("no such file.\n")
    return
  end
  
  spakt=split(akt,'/')
  dir_name=join(spakt[1:end-1],'/')
  part_name=split(spakt[end],'.')[1]
  cases=filter(x->endswith(x,".in"),readdir(dir_name))

#display(cases); exit(0)

  tic()
  pre_part=include(akt)
  part(x)=Base.invokelatest(pre_part,x) # WAP
  printstyled("\n"*"-o-"^15*"\n",color=40)
  pr_msg(" include $(akt): $(round(toc(),digits=2)) sec\n")
  printstyled("-o-"^15*"\n\n",color=40)

  what=(dir_name=dir_name,part=part,part_name=part_name,cases=cases)
  tic()
  res=runit(what)
  pr_msg("   run:   $(round(toc(),digits=2))\n")

  tic()
  status=evalit(what,res)
  pr_msg("   eval:  $(round(toc(),digits=2))\n")

  tic()
  printit(what,res,status)
  pr_msg("   print: $(round(toc(),digits=2))\n\n") # using it once is slow...

end # of tester


if abspath(PROGRAM_FILE)==@__FILE__
  if length(ARGS)==0
    tester()
  else
    tester(ARGS[1])
  end
end
