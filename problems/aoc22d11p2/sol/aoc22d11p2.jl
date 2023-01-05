using DataStructures: Queue, enqueue!, dequeue!
#using StaticArrays

function solve(fin,fout)

  function readit(input)
    input=split(read(input,String),"\n\n",keepempty=false)

    tr(x)=map(c->!isdigit(c) ? ' ' : c, x)
    monkeys=[]
    for rec in input
      rows=split(rec,'\n')
      id=parse(Int,tr(rows[1]))# 0...#monkeys-1
      list=Queue{Int}()
      for x in parse.(Int,split(tr(rows[2])))
        enqueue!(list,x)
      end
      xpr=split(rows[3],"=")[2]
      fun=Meta.eval(Meta.parse("(old)->"*xpr))
      d=parse(Int,tr(rows[4]))
      a=parse(Int,tr(rows[5]))
      b=parse(Int,tr(rows[6]))
      push!(monkeys,(
        list=list,
        fun=fun,
        action=(d,a+1,b+1) # set 1-based
      ))
    end
    monkeys
  end # of readit

  # BigInt is too slow/consumes too much memory (old^2)
  # the items are transformed to a list of remainders (remlists)

    monkeys=readit(fin)

    R=10000
    M=length(monkeys)

    ds=[monkeys[m].action[1] for m in 1:M]
    
    store=[]; S=0;
    queues=[]
    for m in 1:M
      rQ=Queue{Int}()
      Q=monkeys[m].list
      while length(Q)>0
        item=dequeue!(Q)
        ritem=fill(item,M).%ds
        
        S+=1
        push!(store,ritem)
        enqueue!(rQ,S)
      end
      push!(queues,rQ)
    end

    insp=fill(0,M)
    for r in 1:R # rounds
      for m in 1:M
        rQ=queues[m]
        # World Age Problem: invokelatest
        fun(x::Int)=Base.invokelatest(monkeys[m].fun,x) 
        d,a,b=monkeys[m].action
        insp[m]+=length(rQ)
        while length(rQ)>0     
          s=dequeue!(rQ)
          ritem=store[s]
          map!(fun,ritem,ritem)
          ritem.%=ds # we need to do this at each inspection to avoid overflow
          # for i in 1:M
            # ritem[i]=fun(ritem[i])%ds[i]
          # end
          enqueue!(
            queues[ritem[m]==0 ? a : b],
            s
          )
        end
      end
    end

    insp=sort(insp)

    println(fout,insp[end]*insp[end-1])

end # of solve(fin,)
