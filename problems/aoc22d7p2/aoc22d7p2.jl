# aoc 2022 day 7 part 2

struct Node1
  name::AbstractString
  tip::Symbol
  content::Union{AbstractString,Dict{AbstractString,Node1}}
end
Node=Node1 

dir_content=Dict{AbstractString,Node}
newdir(name,content)=Node(name,:dir,content)
newfile(name,content)=Node(name,:file,content)
newroot(name)=(
  root=newdir(name,dir_content());
  root.content[".."]=root;
  root
)

function insert(x,name,tip,content="")
  if !haskey(x.content,name)
    x.content[name]=if tip===:file
      newfile(name,content)
    else 
      newdir(name,dir_content(".."=>x))
    end
  end
end

function solve(fin,fout)

  readit(input)=
    split(read(input,String),"\n",keepempty=false).|>strip

  function process()
    input=readit(fin)
    root=newroot("/")
    akt=root
    for line in input
      line=split(line)
      if line[1]=="\$"
        if line[2]=="ls"
          nothing # pushing everything that follows into 'akt'
        else # cd
          if line[3]=="/"
            akt=root
          else
            akt=akt.content[line[3]]
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

  function trav(akt,dsizes,indent="",prt=false)
    (prt==true) && println(stderr,"$(indent)$(akt.name)")
    if akt.tip===:file
      return parse(Int,akt.content)
    end

    s=0
    for (name,node) in akt.content
      (name=="..") && continue
      s+=trav(node,dsizes,indent*" ")
    end
    dsizes[akt]=s
    s
  end

  root=process()
  dsizes=Dict{Node,Int}()
  # both part can be solved trav once
  trav(root,dsizes)

  dsizes=sort([s for (_,s) in dsizes])
  
  SPACE=70000000
  UNUSED=SPACE-dsizes[end]
  REQ=30000000
  opt=-1
  for s in dsizes
    if UNUSED+s>=REQ
      opt=s
      break 
    end
  end

  println(fout,opt)


end # of solve(fin,)
