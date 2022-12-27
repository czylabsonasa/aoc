deps=["DataStructures","StaticArrays"]
include("config.jl")


function readit(input)
  tr(x)=map(c->!isdigit(c) ? ' ' : c, x)
  input=split(input,"\n\n",keepempty=false)
  monkeys=[]
  for rec in input
    rows=split(rec,'\n')
    id=parse(Int,tr(rows[1]))# 0...#monkeys
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
  #display(monkeys)
  monkeys
end

function part1(input; R=20) 
  monkeys=readit(input)
  M=length(monkeys)
  insp=fill(0,M)
  for r in 1:R # rounds
    for m in 1:M
      list=monkeys[m].list
      fun(x)=Base.invokelatest(monkeys[m].fun,x) # W.A.P.
      d,a,b=monkeys[m].action
      insp[m]+=length(list)
      while length(list)>0
        item=fun(dequeue!(list))÷3
        enqueue!(
          monkeys[item%d==0 ? a : b].list,
          item
        )
      end
    end
  end
  insp=sort(insp)
  #display(insp)

  insp[end]*insp[end-1]
end


# BigInt is too slow
# the items are transformed to a list of remainders (remlists)
function part2(input; R=1000) 
  monkeys=readit(input)
  M=length(monkeys)

  remlists=[]
  for m in 1:M
    rlist=Queue{SizedVector{M,Int}}()
    list=monkeys[m].list
    while length(list)>0
      item=dequeue!(list)
      ritem=SizedVector{M,Int}(fill(item,M))
      enqueue!(rlist,ritem)
    end
    push!(remlists,rlist)
  end

  display(remlists)
  
  insp=fill(0,M)
  for r in 1:R # rounds
    for m in 1:M
      rlist=remlists[m]
      # World Age Problem: invokelatest
      fun(x)=Base.invokelatest(monkeys[m].fun,x) 
      d,a,b=monkeys[m].action
      insp[m]+=length(rlist)
      while length(rlist)>0
        ritem=dequeue!(rlist)
        ritem[m]=fun(ritem[m])%d
        enqueue!(
          remlists[ritem[m]==0 ? a : b],
          ritem
        )
      end
    end
  end
  insp=sort(insp)
  display(insp)

  insp[end]*insp[end-1]
end



println("part1")
println("sample: ",part1(read("sample",String))) 
println("input:  ",part1(read("input",String)))

println("part2")
println("sample: ",part2(read("sample",String),R=10000))
#println("input:  ",part1(read("input",String)))
