##############################################################
# advent of code 2015 day 6

function day6()

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
  # full brute-force
  # for each point:
  # starts from the end, maintain the applicable toggles
  # until some definite+applicable action (off/on) is found 
  function part1(input)
    rect,action=readit(input)
    rect=vcat([[0,999,0,999]],rect)|>reverse
    action=vcat(0,action)|>reverse
    eleme(x,y,r)=(r[1]≤x≤r[2] && r[3]≤y≤r[4])
    n_on=0
    for x in 0:999, y in 0:999
      n_tog=0
      for (r,act) in zip(rect,action)
        !eleme(x,y,r) && continue
        (act==-1)&&(n_tog=1-n_tog;continue)
        n_on+=xor(n_tog,act)
        break        
      end
    end
    n_on      
  end # of part1

  # brute-force
  function part2(input)
    rect,action=readit(input)
    
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

    sum(A)

  end # of part2

  

  part1,part2

end # of day6
