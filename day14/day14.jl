using OffsetArrays

function day14()
  # it also performs some shared tasks
  function readit(input)
    input=split(read(input,String),"\n",keepempty=false).|>
      r->map(c->!isdigit(c) ? ' ' : c,r).|>
        r->parse.(Int,split(r))

    # compute the limits of rock structures
    miniR,maxiR=typemax(Int),typemin(Int)
    miniC,maxiC=typemax(Int),typemin(Int)
    for r in input
      mini,maxi=extrema(r[2:2:end])
      miniR,maxiR=min(miniR,mini),max(maxiR,maxi)
      mini,maxi=extrema(r[1:2:end])
      miniC,maxiC=min(miniC,mini),max(maxiC,maxi)
    end
    println(miniR," ",maxiR," ",miniC," ",maxiC)

    # maxiR+2 for the second part
    table=OffsetMatrix(fill(0,0:maxiR+2,miniC-1:maxiC+1))
    for r in input
      pts=collect(zip(r[2:2:end],r[1:2:end]))
      r,c=pts[1]
      for (rr,cc) in pts[2:end]
        if r!=rr
          table[r:sign(rr-r):rr,cc].=1
        else
          table[r,c:sign(cc-c):cc].=1
        end          

        r,c=rr,cc
      end
    end

    miniR,maxiR,miniC,maxiC,table
  end

  function part1(input)
    miniR,maxiR,miniC,maxiC,table=readit(input)
    
    #display(input)
    
    rest=0
    start=(0,500)
    while true 
      #display(table)
      state=0
      r,c=start
      while true
        (r≥maxiR || c<miniC || c>maxiC) && break
        state=1
        for δc in [0,-1,+1]
          if table[r+1,c+δc]==0
            state=0
            c+=δc
            r+=1
            break
          end            
        end
        (state==1) && break
      end
      (state==0) && break
      table[r,c]=2
      rest+=1
    end

    rest
  end # of part1

  function part2(input)
    miniR,maxiR,miniC,maxiC,table=readit(input)
    println(size(table))
    FL,_=size(table) # floor
    FL-=1
    table[FL,:].=1

    function widen() 
      δ=64 # ad-hoc δ
      miniC,maxiC=miniC-δ,maxiC+δ
      table=OffsetMatrix(
        hcat(
          fill(0,FL+1,δ),
          table,
          fill(0,FL+1,δ)
        ),
        0:FL,miniC-1:maxiC+1
      )
      table[FL,:].=1
    end
    
    #display(input)
    
    rest=0
    start=(0,500)
    while table[start...]==0 
      #display(table)
      state=0
      r,c=start
      while true
        (c≤miniC || c≥maxiC) && widen()
        
        state=1
        for δc in [0,-1,+1]
          if table[r+1,c+δc]==0
            state=0
            c+=δc
            r+=1
            break
          end            
        end
        (state==1) && break
      end
      #(state==0) && break
      table[r,c]=2
      rest+=1
    end
    println(size(table))
    rest
  end # of part2

  part1,part2,2

end # of day14
