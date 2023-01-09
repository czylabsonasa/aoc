#
#
#
function validateit(info)

  proc=info["process"]
  if proc["error"]>0
    return
  end
  proc["validateit"]="ok"

  
  sub=info["submission"]
  gen=info["general"]

  sol_path=sub["sol_path"]
  # sol_path
  if sol_path=="" || !isfile(sol_path)
    proc["validateit"]="sol_path error $(sol_path)"
    proc["error"]+=1
    return
  end

  sol_file=split(sol_path,'/')[end]
  sp_sol_file=split(sol_file,'.')

  # extract the body end the extension 
  sol_file_body,ext=if length(sp_sol_file)>1
    sp_sol_file[end-1:end]
  else
    sp_sol_file[end],""
  end
    
  
  problem_db=info["general"]["problem_db"]
  problem_id=sub["problem_id"]

  if problem_id>"" 
    if !isdir("$(problem_db)/$(problem_id)")
      proc["validateit"]="no such problem ($(problem_id))"
      proc["error"]+=1
      return
    end
  else
    if !isdir("$(problem_db)/$(sol_file_body)")
      proc["validateit"]="cannot guess problem_id"
      proc["error"]+=1
      return
    end
    problem_id=sol_file_body
  end


  lang=sub["lang"]
  if lang>"" 
    if !(lang in keys(info["lang"]))
      proc["validateit"]="unknown/not available language/$(lang) "
      proc["error"]+=1
      return
    end
  else
    for (l,elist) in info["lang"]
      if lowercase(ext) in elist
        lang=l
        break
      end
    end
  end

  if lang==""
    proc["validateit"]="unable to guess language"
    proc["error"]+=1
  end


  sub["problem_id"]=problem_id
  sub["problem_dir"]="$(problem_db)/$(problem_id)"
  sub["lang"]=lang
  sub["ext"]=info["lang"][lang][1]

  
end
