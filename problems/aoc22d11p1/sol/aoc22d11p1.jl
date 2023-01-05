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

  monkeys=readit(fin)

  R=20
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

  println(fout, insp[end]*insp[end-1])

end # of solve(fin,)
