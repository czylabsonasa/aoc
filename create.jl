#!/home/nosy/bin/julia

help()=println(stderr,
"""
usage:
julia create.jl Y/dayD
where Y is the year and 
D is a number between 1 and 25
""")

if length(ARGS)!=1
  help()
  exit(1)
end

Y,D=try
  local Y,D=split(ARGS[1],'/')
  Y=parse(Int,Y)
  @assert startswith(D,"day")
  D=parse(Int,D[4:end])
  @assert 1≤D≤25
  Y,D
catch
  println("wrong argument")
  help()
  exit(2)
end


target="$(Y)/day$(D)"
if !isdir("$(Y)") || !isdir(target)
  mkpath(target)
end

touch(f)=if !isfile(f)
  open(f,"w") do fh
    nothing
  end
end

for elem in readdir("skeleton")
  isfile("$(target)/$(elem)") && continue
  if endswith(elem,".in")
    touch("$(target)/$(elem)")
  end
  cont=replace(read("skeleton/$(elem)",String),
    "__DAY__"=>"$(D)","__YEAR__"=>"$(Y)")
  open("$(target)/$(elem)","w") do f
    print(f,cont)
  end
end

println(stderr,"OK!")
