##############################################################
# advent of code 2015 day 2

function day2()

  readit(input)=
    split(read(input,String),keepempty=false).|>
      r->parse.(Int,split(r,'x'))


  function part1(input)
    sum(
      3a*b +2b*c +2c*a for (a,b,c) in readit(input).|>sort
    )
  end # of part1


  function part2(input)
    sum(
      2(a+b) +a*b*c for (a,b,c) in readit(input).|>sort
    )
  end # of part1

  part1,part2

end # of day2
