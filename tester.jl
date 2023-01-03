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

function tester(sol_path,prob_id=nothing)
  if !isfile(sol_path)
    pr_err("no such file.\n")
    return
  end

  info=configit(".")
  problem_store=info["problem_store"]  
  configit(problem_store,info)

  sol_path_parts=split(sol_path,'/')
  fname=sol_path_parts[end]
  fname_parts=split(fname,'.')
  if prob_id===nothing
    prob_id=fname_parts[end-1]
  end
  prob_home="$(problem_store)/$(prob_id)" # subject of change 
  ext=fname_parts[end]

  

  info["prob_id"]=prob_id
  info["prob_home"]=prob_home
  info["sol_path"]=sol_path
  info["fname"]=fname
  configit(prob_home,info)


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
