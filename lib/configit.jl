import TOML
function configit(pathto,config=nothing)
  # default
  if isfile("$(pathto)/config.toml")
    temp=TOML.parsefile("$(pathto)/config.toml")
    if config===nothing
      return temp
    else
      # overwrites the old content
      for (k,v) in temp
        config[k]=v
      end
    end
  end
  
end
