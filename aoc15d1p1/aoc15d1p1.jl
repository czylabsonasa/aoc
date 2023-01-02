##############################################################
# advent of code 2015 day 1 part 1

function solve(fin,fout)

  readit(input)=
    split(read(input,String),'\n',keepempty=false)

  solve(case)=sum((c=='(' ? 1 : -1) for c in case)

  println(
    fout,
    join(
      solve.(readit(fin)),
      '\n'
    )
  )
end # of solve(fin,fout)
