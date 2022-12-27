module aoc2022d7

export 
   process, trav, Node

struct Node1
  name::AbstractString=""
  tip::Symbol=:undef
  content::Union{AbstractString,Dict{AbstractString,Node}}=""
end
Node=Node1 # thank to Tim Holy :-)

name(x::Node)=x.name
tip(x::Node)=x.tip
content(x::Node)=x.content

newdir(name,content)=Node(name,:dir,content)
newfile(name,content)=Node(name,:file,content)
newroot(name)=(
  root=newdir(name,Dict{AbstractString,Node}());
  root.content[".."]=root;
  root
)




#function insert(x::Node,yname::String;content::t_content=nothing)
function insert(x,name,tip,content="")
  cx=content(x)
  if !haskey(cx,name)
    cx[name]=if tip===:file
      newfile(name,content)
    else 
      newdir(name,t_links(".."=>x))
    end
  end
end


# insert(x::Node,yname::AbstractString;content::t_content=nothing)=
  # insert(x,String(yname),content)

function process(sample)
  root=newroot("/")
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
          akt=content(akt)[line[3]]
        end
      end
    elseif line[1]=="dir"
      insert(akt,line[2],:dir)
    else  # file
      insert(akt,line[2],:file,line[1])
    end
  end
  root
end

function trav(akt::Node,dirs;indent::String="")
  println(stderr,"$(indent)$(name(akt))")
  if tip(akt)===:file
    return parse(Int,content(akt))
  end

  s=0
  for (name,node) in content(akt)
    (name=="..") && continue
    s+=trav(node,jok,indent*" ")
  end
  dirs[akt]=s
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

function part1(input)
  root=process(input)
  sizes=Dict{Node,Int}
  trav(root,sizes)
  
end

