# aoc 2022 day 8 part 1

function solve(fin,fout)

  readit(input)=mapreduce(
    permutedims,
    vcat,
    split(read(input,String),"\n",keepempty=false).|>collect.|>x->parse.(Int,x)
  ) 

  A=readit(fin)
  ret=fill(false,size(A))
  for _ in 1:4
    r,c=size(A)
    tmp=fill(-1,c)
    for k in 1:r
      ret[k,:]=ret[k,:].||(A[k,:].>tmp)
      tmp=max.(tmp,A[k,:])
    end
    A=rotl90(A)
    ret=rotl90(ret)
  end

  println(fout, sum(ret))


end # of solve(fin,)
