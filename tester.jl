#!/home/nosy/bin/julia
#
#
#

include("lib/Testit.jl")
using .Testit


tic,toc=mktictoc()
msg=mkmsg()

# cli call
function tester(args::Vector{String})
  info=infoit_cli(args)
  validateit(info)
  prepareit(info) # prepare testdir+sol_file+io
  compileit(info)
  runit(info)
  finalit(info)
  @info join(ppdict(["\ninfo"=>info],"  "),'\n')
end

# repl call
function tester(;args...)
  info=infoit_repl(;args...)
  validateit(info)
  prepareit(info) # prepare testdir+sol_file+io
  compileit(info)
  finalit(info)
  @info join(ppdict(["\ninfo"=>info],"  "),'\n')
end


if abspath(PROGRAM_FILE)==@__FILE__
  tester(ARGS)
end


#=
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
=#
