function julia(info)
  function compileit(info)
    proc=info["process"]
    if proc["error"]>0
      return
    end
    sub=info["submission"]
    

    # ...

    proc["compileit"]="ok"
  end


  # will be compile and run
  compileit,nothing
end
