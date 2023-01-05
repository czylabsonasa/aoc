##############################################################
# advent of code 2015 day 2 part 2

function solve(fin,fout)

  readit(input)=
    split(read(input,String),keepempty=false).|>
      r->parse.(Int,split(r,'x'))


  println(
    fout,
    sum(
      2(a+b) +a*b*c for (a,b,c) in readit(fin).|>sort
    )
  )

end # of solve(fin,fout)
