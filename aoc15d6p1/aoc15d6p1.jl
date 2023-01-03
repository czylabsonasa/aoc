##############################################################
# advent of code 2015 day 6 part 1

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

  # full brute-force
  # for each point:
  # starts from the end, maintain the applicable toggles
  # until some definite+applicable action (off/on) is found 
  rect,action=readit(fin)
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
  
  println(fout,n_on)

end # of solve(fin,)
