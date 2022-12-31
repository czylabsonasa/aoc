
function day18()
  readit(input)=
    [(parse.(Int,split(r,','))...,) for r in split(read(input,String),"\n",keepempty=false)]

  # count neighbouring parts of the droplet
  function part1(input)
    input=readit(input)

    van=Set{Tuple{Int,Int,Int}}()
    push!(van,input...)
    edges=0
    for (a,b,c) in van
      edges+=(
        ((a,b,c+1) in van)+
        ((a,b,c-1) in van)+
        ((a,b+1,c) in van)+
        ((a,b-1,c) in van)+
        ((a+1,b,c) in van)+
        ((a-1,b,c) in van)
      )
    end

    # edges counted 2x and 1 edge "removes" two faces
    # so leave it as is
    # 6*length(van)-(edges÷2)*2
    6*length(van)-edges 
  end # of part1

  # small size: floodfill from an outer point
  # of the droplet
  function part2(input)
    input=readit(input)
    A=mapreduce(
      permutedims,
      vcat,
      [[r...,] for r in input]
    )
    
    (xlo,xup),(ylo,yup),(zlo,zup)=
      extrema.([A[:,1],A[:,2],A[:,3]])
    (xlo,xup)=(xlo,xup).+(-1,1)
    (ylo,yup)=(ylo,yup).+(-1,1)
    (zlo,zup)=(zlo,zup).+(-1,1)

    # println((xlo,xup))
    # println((ylo,yup))
    # println((zlo,zup))

    # 1  : lava
    # 0  : empty unvisited
    # -1 : empty visited
    table=OffsetArray(
      fill(0,xup-xlo+1,yup-ylo+1,zup-zlo+1),
      xlo:xup,
      ylo:yup,
      zlo:zup
    )
    for r in eachrow(A)
      table[r...]=1 
    end
    hit=0 # number of faces found
    function trav(x,y,z)
      table[x,y,z]=-1
      for (xx,yy,zz) in [(x-1,y,z),(x+1,y,z),(x,y-1,z),(x,y+1,z),(x,y,z-1),(x,y,z+1)]
        (xx<xlo || xx>xup || yy<ylo || yy>yup || zz<zlo || zz>zup) && continue
        (table[xx,yy,zz]==-1) && continue
        (table[xx,yy,zz]==1) && (hit+=1;continue)
        trav(xx,yy,zz)
      end
      
    end
    trav(xlo,ylo,zlo)
   

    hit
  end # of part2


  part1,part2

end # of day18
