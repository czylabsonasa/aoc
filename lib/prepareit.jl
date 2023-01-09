function prepareit(info)
  proc=info["process"]
  if proc["error"]>0
    return
  end
  proc["prepareit"]="ok"

  sub=info["submission"]
  gen=info["general"]

  test_dir=gen["test_dir"]
  test_id=sub["test_id"]
  test_dir="$(test_dir)/$(test_id)"
  if isdir(test_dir)
    proc["prepareit"]="hash collision :-)"
    proc["error"]+=1
    return
  end

  mkdir(test_dir)

  ext=sub["ext"]
  cp(sub["sol_path"],"$(test_dir)/solve.$(ext)")

  cp("""$(sub["problem_dir"])/io""","$(test_dir)/io")
  
end
