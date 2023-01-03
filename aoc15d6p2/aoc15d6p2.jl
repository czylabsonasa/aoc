##############################################################
# advent of code 2015 day 6 part 2

function solve(fin,fout)

  function readit(input)
    input=split(
      read(input,String),'\n',keepempty=false
    )
    rect,action=[],[]
    for r in input
      if startswith(r,"toggle")
        push!(action,-1)
      elseif startswith(r,"turn on")
        push!(action,1)
      else
        push!(action,0)
      end
      r=parse.(Int, 
        split(map(c->isdigit(c) ? c : ' ',r))
      )
      push!(
        rect,
        [
          min(r[1],r[3]),max(r[1],r[3]),
          min(r[2],r[4]),max(r[2],r[4]),          
        ]
      )
    end
    rect,action
  end

  # brute-force
  rect,action=readit(fin)
    
  A=fill(0,1000,1000)
  for (r,act) in zip(rect,action)
    x0,x1,y0,y1=r.+1
    δ=if act==1
      1
    elseif act==-1
      2
    else
      -1
    end
    A[x0:x1,y0:y1].+=δ
    A[A.<0].=0
  end

  println(fout, sum(A))

end # of solve(fin,)
