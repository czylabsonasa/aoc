function compileit(info)
  proc=info["process"]
  if proc["error"]>0
    return
  end
  
  lang=info["submission"]["lang"]
  compile=getfield(getfield(cr_command,Symbol(lang)),Symbol("compile"))
  if compile===nothing
    return
  end

  try
    res=run(compile)
  catch
    proc["compileit"]="system error in compileit"
    return
  end    
  
  proc["compileit"]=if res.exitcode!=0
    "error in compileit: $(res.exitcode)"
  else
    "ok"
  end
end
