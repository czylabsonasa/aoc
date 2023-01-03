# aoc 2022 day 8 part 2

function solve(fin,fout)

  readit(input)=mapreduce(
    permutedims,
    vcat,
    split(read(input,String),"\n",keepempty=false).|>collect.|>x->parse.(Int,x)
  ) 


# similar approach (rotl90) to that of part 1, but here a monotone stack is used to 
# administer the closest larger to the left

  A=readit(fin)
  INF=10
  ret=fill(1,size(A))
  for _ in 1:4
    r,c=size(A)
    for i in 1:r
      sta=[(INF,-1)] # negate to handle ties correctly
      for j in 1:c
        v=(A[i,j],-j)
        while v>sta[end]
          pop!(sta)
        end
        ret[i,j]*=(j+sta[end][2])
        push!(sta,v)
      end        
    end
    A=rotl90(A)
    ret=rotl90(ret)
  end
  println(fout, maximum(ret[:]))

end # of solve(fin,)
