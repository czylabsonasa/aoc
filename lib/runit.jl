function runit(info)
  proc=info["process"]
  if proc["error"]>0
    return
  end
  sub=info["submission"]
  lang=sub["lang"]
  mode=sub["sol_mode"]
  execute=getfield(getfield(cr_command,Symbol(lang)),Symbol(mode))
  if execute===nothing
    proc["runit"]="$(mode) is not available"
    proc["error"]+=1
    return
  end

  if mode=="app"
    cd(sub["test_dir"])
    try
      run(execute)
    catch
      proc["runit"]="rte"
      proc["error"]+=1
      return
    end
  end
  proc["runit"]="ok"
  
end
