##############################################################
# advent of code 16 day 3 part 1

function solve(fin,fout)

  readit(input)=mapreduce(
    permutedims,
    vcat,
    split(read(input,String),"\n",keepempty=false).|>x->sort(parse.(Int,split(x)))
  ) 

  A=readit(fin) # w/ already sorted rows

  println(
    fout,
    sum(A[:,1]+A[:,2].>A[:,3])
  )


end # of solve(fin,fout)
