##############################################################
# advent of code 16 day 3 part 2

function solve(fin,fout)

  readit(input)=mapreduce(
    permutedims,
    vcat,
    split(read(input,String),"\n",keepempty=false).|>x->parse.(Int,split(x))
  ) 

  A=readit(fin)[:]

  #println(stderr,A)

  ans=sum(
    (r=sort(A[i:i+2]);r[1]+r[2]>r[3]) for i in 1:3:length(A)
  )

  println(fout,ans)

end # of solve(fin,fout)
