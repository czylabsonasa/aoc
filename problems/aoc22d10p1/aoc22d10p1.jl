# aoc 2022 day 10 part 1

function solve(fin,fout)

  readit(input)=
    [cmd for cmd in split(read(input,String),"\n",keepempty=false)]


  input=readit(fin)
  N=length(input)  

  obs_c=20
  obs_X=[]

  shift_mod(arr,m)=(arr[1]=arr[2];arr[2]=arr[3];arr[3]+=m)

  X=[1,1,1]
  c=[0,0,0]
  for cmd in input
    cmd=split(cmd)
    #println(stderr,cmd, " ", c[2], " ",X)
    if length(cmd)==1
      shift_mod(c,1)
      shift_mod(X,0)
    else
      shift_mod(c,2)
      #addx=parse(Int,cmd[2])
      #println(stderr,addx)
      shift_mod(X,parse(Int,cmd[2]))
    end

    if c[3]>obs_c            
      if c[2]==obs_c
        push!(obs_X,X[1]*obs_c)
      else
        push!(obs_X,X[2]*obs_c)
      end
      obs_c+=40
    end

    (obs_c>220) && break
  end

  println(fout,sum(obs_X))

end
