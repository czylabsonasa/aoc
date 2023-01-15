##############################################################
# advent of code 17 day 6 part 1

using CircularArrays

function solve(fin,fout)

  readit(input)=
    parse.(Int,split(read(input,String)))

  
  b=CircularVector(readit(fin))
  n=length(b)
  volt=Dict(join(b,'_')=>0)
  step=0
  while true
    i=argmax(b)
    bi=b[i]
    b[i]=0
    q,r=divrem(bi,n)
    b.+=q
    b[i+1:i+r].+=1

    bb=join(b,'_')
    s=get(volt,bb,-1)

    step+=1

    if s<0
      volt[bb]=step
    else
      break
    end
  end 
  
  println(fout,step)

end # of solve(fin,fout)



if abspath(PROGRAM_FILE)==@__FILE__
  solve(stdin,stdout)
end
