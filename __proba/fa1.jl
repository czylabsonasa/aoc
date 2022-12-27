module aoc2022d7

export 
   process, trav

# Base.@kwdef mutable struct Node
  # name::String=""
  # content::Union{AbstractString,Dict{AbstractString,Node}}=nothing
# end
Base.@kwdef struct Node
  name::String=""
  content::Union{AbstractString,Dict{AbstractString,Node}}=nothing
end

t_links=Dict{AbstractString,Node}
t_content=Union{Nothing,AbstractString,t_links}

isitdir(x::Node)=(typeof(x.content)!=String)
newdir(;name="",content=t_links())=
  Node(name=name,content=content)
newfile(;name="",content="")=
  Node(name=name,content=content)
newroot()=(
  root=newdir(name="/");root.content[".."]=root;root
)




#function insert(x::Node,yname::String;content::t_content=nothing)
function insert(x,yname::AbstractString;content::t_content=nothing)
  try
    if !haskey(x.content,yname)
      x.content[yname]=if typeof(content)<:AbstractString
        newfile(name=yname,content=content)
      else 
        newdir(name=yname,content=t_links(".."=>x))
      end
    end
  catch
    println(stderr,"oops...")
  end
end


# insert(x::Node,yname::AbstractString;content::t_content=nothing)=
  # insert(x,String(yname),content)

function process(sample)
  root=newroot()
  akt=root
  for line in split(sample,"\n",keepempty=false).|>strip
    line=split(line)
    if line[1]=="\$"
      if line[2]=="ls"
        nothing # pushing everything that follows into 'akt'
      else # cd
        if line[3]=="/"
          akt=root
        else
          # $ cd /a/b/c and
          # $ cd  a/b/c not handled
          # only 1 level (more level would need split+loop)
          akt=akt.content[line[3]]
        end
      end
    elseif line[1]=="dir"
      insert(akt,line[2])
    else  # file
      insert(akt,line[2],content=line[1])
    end
  end
  root
end

function trav(akt::Node,jok,indent::String="")
  #println(stderr,"$(indent)$(akt.name)")
  #println(typeof(akt.content))
  if typeof(akt.content)<:AbstractString
    s=parse(Int,akt.content)
    #println(akt)
    return s
  end

  s=0
  for (name,node) in akt.content
    (name=="..") && continue
    s+=trav(node,jok,indent*" ")
  end
  #println(s)
  if s<=100000
    jok[1]+=s
  end
  s
end

end # module


using .aoc2022d7


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

#root=process(sample)
# root=newroot()
# akt=root
# 
# 
# display(akt)
# insert(akt,"a",content="123")
# display(akt)
# insert(akt,"b")
# display(akt)
# 

function part1(input)
  root=process(input)
  jok=[0]
  trav(root,jok)
  jok[1]
end

