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
  "DataStructures", # 22/(11,12): Queue
  "OffsetArrays", # 22/(14,15,18(part2))
  "MD5", # 15/(4)
  "CircularArrays", #
]




function tester()
  Pkg.instantiate()
  if isdefined(Main,:deps) && deps>[]
    Pkg.add.(deps)
  end
  nothing
end

function tester(sol_path)
  if !isfile(sol_path)
    pr_err("no such file.\n")
    return
  end
  
  sol_path_parts=split(sol_path,'/')
  fname=sol_path_parts[end]
  fname_parts=split(fname,'.')
  prob_id=fname_parts[1]
  prob_home=prob_id # subject of change 
  extco=fname_parts[2]

  
  info=configit(prob_home)
  info["prob_id"]=prob_id
  info["prob_home"]=prob_home
  info["sol_path"]=sol_path
  info["fname"]=fname


  tic()
  include(sol_path)
  # here the name solve is living
  printstyled("\n"*"-o-"^15*"\n",color=40)
  pr_msg(" include $(sol_path): $(round(toc(),digits=2)) sec\n")
  printstyled("-o-"^15*"\n\n",color=40)

  lsolve(x,y)=Base.invokelatest(solve,x,y)
  info["solve"]=lsolve

  tic()
  runit(info)
  pr_msg("   run:   $(round(toc(),digits=2))\n")


  tic()
  evalit(info)
  pr_msg("   eval:  $(round(toc(),digits=2))\n")

#exit(1)


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
