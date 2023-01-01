#!/home/nosy/bin/julia

include("util.jl")
tic,toc=mktictoc()


tic()
import Pkg
Pkg.activate(".")
include("lib.jl")

pr_msg("getting up: $(round(toc(),digits=2)) sec\n")


deps=[
  "Printf","PrettyTables", "TOML",
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

function tester(sol_fname)
  if !isfile(sol_fname)
    pr_err("no such file.\n")
    return
  end
  
  fname_parts=split(sol_fname,'/')
  prob_name=join(fname_parts[1:end-1],'/')
  dir_name=prob_name
  part_name=split(fname_parts[end],'.')[1]

  info=configit(dir_name)
  info["prob_name"]=prob_name
  info["dir_name"]=prob_name
  info["part_name"]=part_name
  info["sol_fname"]=sol_fname


  tic()
  pre_part=include(sol_fname)
  part(x)=Base.invokelatest(pre_part,x) # WAP
  printstyled("\n"*"-o-"^15*"\n",color=40)
  pr_msg(" include $(sol_fname): $(round(toc(),digits=2)) sec\n")
  printstyled("-o-"^15*"\n\n",color=40)

  info["part"]=part

  tic()
  runit(info)
  pr_msg("   run:   $(round(toc(),digits=2))\n")

  tic()
  evalit(info)
  pr_msg("   eval:  $(round(toc(),digits=2))\n")

  tic()
  printit(info)
  pr_msg("   print: $(round(toc(),digits=2))\n\n") # using it once is slow...

end # of tester


if abspath(PROGRAM_FILE)==@__FILE__
  if length(ARGS)==0
    tester()
  else
    tester(ARGS[1])
  end
end
