##############################################################
# advent of code 2015 day 1 part 2

function solve(fin,fout)

  readit(fname)=
    split(read(fname,String),'\n',keepempty=false)


  solve(case::AbstractString)=findfirst(
    ==(-1),
    cumsum((c=='(' ? 1 : -1) for c in case)
  )    

  println(
    fout,
    join(
      solve.(readit(fin)),
      '\n'
    )
  )
end # of solve(fin,fout)
