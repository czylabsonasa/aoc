##############################################################
# advent of code 17 day 4 part 2

using DataStructures

function solve(fin,fout)

  readit(input)=
    split(read(input,String),'\n',keepempty=false)


  isvalid(pph)=all((pph|>split.|>collect.|>sort.|>join|>counter|>values).<2)
  
  
  println(
    fout,
    sum(
      readit(fin).|>isvalid,
      init=0
    )
  )

end # of solve(fin,fout)



if abspath(PROGRAM_FILE)==@__FILE__
  solve(stdin,stdout)
end


