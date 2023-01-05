#!/home/nosy/bin/julia

# temporary script for performing various modifications

if length(ARGS)<1
  printstyled("error\n",color=:red)
  exit(1)
end

for p in readdir(".",join=true)
  akt=split(p,'/')[2]
  if startswith(akt,ARGS[1])
    isdir("$(p)/io") && continue
    mkdir("$(p)/io")
    mkdir("$(p)/sol")
    for c in readdir(p)
      if endswith(c,".in") || endswith(c,".out")
        mv("$(p)/$(c)","$(p)/io/$(c)")
      elseif endswith(c,".jl")
        mv("$(p)/$(c)","$(p)/sol/$(c)")
      end
    end
  end
end

