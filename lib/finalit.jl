function finalit(info)
  sub=info["submission"]
  if sub["store"]==0 && sub["test_dir"]>""
    rm(sub["test_dir"],recursive=true)
  end
  proc=info["process"]
  proc["finalit"]="ok"
end
