#!/home/nosy/bin/julia

include("lib/util.jl")
tic,toc=mktictoc()
msg=mkmsg()


tic()
import Pkg
Pkg.activate(".")

include("lib/runit.jl")
include("lib/evalit.jl")
include("lib/printit.jl")
include("lib/configit.jl")


deps=[
  "Printf","PrettyTables", "TOML", "Crayons",
  "DataStructures", # 22/(11,12): Queue
  "OffsetArrays", # 22/(14,15,18(part2))
  "MD5", # 15/(4)
  "CircularArrays", #
]

@info msg("getting up", toc())



function tester()
  @warn "\ncall w/o arg, handle deps:\n\n"
  include("deps.jl")
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
  lsolve(x,y)=Base.invokelatest(solve,x,y)
  info["solve"]=lsolve

  @info msg("include $(sol_path)",toc())


  tic()
  runit(info)
  @info msg("run",toc())


  tic()
  evalit(info)
  @info msg("eval",toc())

#exit(1)


  tic()
  printit(info)
  @info msg("print",toc())

end # of tester


if abspath(PROGRAM_FILE)==@__FILE__
  if length(ARGS)==0
    tester()
  else
    tester(ARGS[1])
  end
end
