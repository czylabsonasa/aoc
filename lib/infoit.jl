# itt valami jot kellene kitalalni

# default_info()=Dict{String,Any}(
  # "sol_path"=>"",
  # "lang"=>"",
  # "user_id"=>0,
  # "problem_id"=>"",
  # "mode"=>"func"
# )

import TOML
infoit()=TOML.parsefile("config.toml")


function infoit_cli(args)
  info=infoit()
  sub=info["submission"]
  sub["sender"]="cli"
  sub["test_id"]=hash(time_ns())|>string

  proc=info["process"]
  proc["infoit"]="ok"

  for arg in args
    sp=split(arg,'=',keepempty=true)
    if length(sp)==1
      sub["sol_path"]=sp[1]
    elseif length(sp)==2 && sp[1] in keys(sub)
      sub[sp[1]]=sp[2]
    else
      proc["infoit"]="error in argument: $(arg)"
      proc["error"]+=1
      break
    end
  end
  info
end



function infoit_repl(;args...)
  info=infoit()
  sub=info["submission"]
  sub["sender"]="repl"
  sub["test_id"]=hash(time_ns())|>string
  

  proc=info["process"]
  proc["infoit"]="ok"

  for (k,v) in args
    sk=string(k)
    if sk in keys(sub)
      sub[sk]=v
    else
      proc["infoit"]="error in parameter: $(sk)=$(v)"
      proc["error"]+=1
      break      
    end
  end
  info
end
