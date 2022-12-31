using OffsetArrays

function day15()
  readit(input)=
    [row for row in split(read(input,String),"\n",keepempty=false)].|>
      r->map(c->isdigit(c)||c=='-' ? c : ' ',r).|>
        r->parse.(Int,split(r))


  # intervals, "size" of the union, sorting
  function part1(input)
    Y=if endswith(input,"1.in") # example vs real input
      10
    else
      2000000
    end
    
    input=readit(input)
    #display(input)
    onY=Set()
    ivs=[] # intervals
    for r in input
      d=abs(r[1]-r[3])+abs(r[2]-r[4])
      dY=abs(r[2]-Y)
      δ=d-dY
      (δ<0) && continue
      push!(ivs,(r[1]-δ,r[1]+δ))
      (r[4]==Y) && push!(onY,(r[3],r[4])) # the beacons on the Y line handled at the end
    end

    sort!(ivs)
    push!(ivs,(typemax(Int),0)) # a sentinel at the end

    exc=0
    A,B=ivs[1]
    for (a,b) in ivs[2:end] 
      if B<a
        exc+=(B-A+1)
        A,B=a,b
      else
        B=max(b,B)
      end
    end
    
    exc-length(onY)
  end # of part1


  # multiset by vector
  # O(sensors*(UP-LO+1))
  # it is incredibly slow w/o the work() function...
  function part2(input)
    LO,UP=if endswith(input,"1.in") # example vs real input
      0,20
    else
      0,4000000
    end
    
    sensors=[(r[1],r[2],abs(r[1]-r[3])+abs(r[2]-r[4])) for r in readit(input)]


    # multiset
    state=OffsetVector(fill(0,UP-LO+1),LO:UP)
    
    # init the state 
    function init(;y=LO-1,sensors=sensors,state=state)
      for (sx,sy,sd) in sensors
        δ=abs(sy-y)
        lo,up=sx-sd+δ,sx+sd-δ
        (lo>up) && continue
        state[max(LO,lo):min(UP,up)].+=1
      end
      findall(==(0),state)|>length
    end # of init
  
    numZero=init()

    function work(y::Int,numZero::Int;LO=LO,UP=UP,sensors=sensors,state=state)
      for (sx,sy,sd) in sensors
        δ=abs(sy-y)
        lo,up=sx-sd+δ,sx+sd-δ
        if y>sy
          (lo-up>2) && continue
          if LO≤lo-1≤UP
            (state[lo-1]==1) && (numZero+=1)
            state[lo-1]-=1
          end
          if LO≤up+1≤UP && up+1>lo-1
            (state[up+1]==1) && (numZero+=1)
            state[up+1]-=1
          end
        else
          (lo>up) && continue
          if LO≤lo≤UP
            (state[lo]==0) && (numZero-=1)
            state[lo]+=1
          end
          if LO≤up≤UP && up>lo
            (state[up]==0) && (numZero-=1)
            state[up]+=1
          end
        end
      end
      numZero
    end # of work

    xx,yy=typemax(Int),typemax(Int)
    for y in LO:UP
      numZero=work(y,numZero)
      if numZero==1
        yy=y
        break
      end
    end # main loop

    if numZero==1
      I=findfirst(==(0),state)    
      xx=I[1]
    end
    
    display((xx,yy)) # (2713145, 3132904) for 2.in
    4000000*xx+yy
  end # of part2

  part1,part2

end # of solve of day15
