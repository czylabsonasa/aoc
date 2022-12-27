module aoc2022d7

Base.@kwdef mutable struct Node
  name::String=""
  data::Int=0
  links::Union{Nothing,Dict{String,Node}}=nothing
end
__nodelinks=Dict{String,Node}

isitdir(x::Node)=(x.links!==nothing)
newdir(;name="",data=0,links=__nodelinks())=
  Node(name=name,data=data,links=links)
newfile(;name="",data=0)=
  Node(name=name,data=data)
newroot()=(root=newdir(name="/");root.links[".."]=root;root)

push!(x::Node,yname::AbstractString; data::Int=-1)=try
  if !haskey(x.links,yname)
    x.links[yname]=if data<0
      newdir(name=yname,links=__nodelinks(".."=>x))
    else 
      newfile(name=yname,data=data)
    end
  end
catch
  println("oops...")
end


root=newroot()
display(root)

sample=raw"""
$ cd /
$ ls
dir a
14848514 b.txt
8504156 c.dat
dir d
$ cd a
$ ls
dir e
29116 f
2557 g
62596 h.lst
$ cd e
$ ls
584 i
$ cd ..
$ cd ..
$ cd d
$ ls
4060174 j
8033020 d.log
5626152 d.ext
7214296 k
"""

akt=root
for line in split(sample,"\n",keepempty=false).|>strip
  line=split(line)
  if line[1]=="\$"
    if line[2]=="ls"
      nothing
    else
      if line[3]=="/"
        akt=root
      else
        akt=akt.links[line[3]]
      end
    end
  elseif line[1]=="dir"
    push!(akt,line[2])
  else
    push!(akt,line[2],data=parse(Int,line[1]))
  end
end

function trav(akt::Node,indent::String)
  println(stderr,"$(indent)$(akt.name)")
  (akt.links===nothing) && return
  for (name,node) in akt.links
    (name=="..") && continue
    trav(node,indent*" ")
  end
end

end # module

using .
