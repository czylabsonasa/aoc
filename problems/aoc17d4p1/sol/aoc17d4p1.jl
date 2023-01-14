##############################################################
# advent of code 17 day 4 part 1

using DataStructures

function solve(fin,fout)

  readit(input)=
    split(read(input,String),'\n',keepempty=false)


  println(
    fout,
    sum(readit(fin).|>x->(x|>split|>counter|>values.<2)|>all)
  )

end # of solve(fin,fout)



if abspath(PROGRAM_FILE)==@__FILE__
  solve(stdin,stdout)
end
