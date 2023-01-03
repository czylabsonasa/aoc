# aoc 2022 day 10 part 2

function solve(fin,fout)

  readit(input)=
    [cmd for cmd in split(read(input,String),"\n",keepempty=false)]


# the value of X is needed during each cycle
  input=readit(fin)

  L=40
  nL=6

  i=0      # for access the input
  X=1      # aktual val
  state=1
  dX=0

  # two loops -> no modulo (but higher code complexity)
  disp=[]
  for cc in 1:(L*nL) # can be 0 based (cc-1 <-> cc)
    state-=1
    if state==0
      X+=dX
      cmd=split(input[i+=1]) 
      if length(cmd)==1
        state=1
        dX=0
      else
        state=2
        dX=parse(Int,cmd[2])
      end
    end
    # println(stderr,X)
    push!(disp,abs((cc-1)%L-X)<2 ? '#' : '.')
    
  end

  println(
    fout,
    reshape(disp,L,nL)|>permutedims|>eachrow.|>join|>x->join(x,"\n")
  )

end # of solve(fin,)
