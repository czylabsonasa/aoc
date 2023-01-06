##############################################################
# advent of code 16 day 6 part 1

using DataStructures
function solve(fin,fout)

  readit(input)=mapreduce(
    permutedims,
    vcat,
    split(read(input,String),'\n',keepempty=false).|>collect
  ) 

  A=readit(fin)

  solve(v)=argmax(x->x[2],counter(v))[1]

  println(
    fout,
    join(solve.(eachcol(A)))
  )

end # of solve(fin,fout)



if abspath(PROGRAM_FILE)==@__FILE__
  solve(stdin,stdout)
end
