##############################################################
# advent of code 2015 day 3 part 1

function solve(fin,fout)

  # splits around newline, so 
  # treats each line as a separate case
  readit(input)=
    split(read(input,String),'\n',keepempty=false)


  function sub(r)
    d=Dict(
      '<'=>(-1,0),
      '>'=>(1,0),
      '^'=>(0,-1),
      'v'=>(0,1),
    )
    [
      accumulate(
        (x,y)->x.+y,
        [d[x] for x in r],
        init=(0,0)
      )...,
      (0,0)
    ]
  end # of sub

  solve(case::AbstractString)=case|>sub|>unique|>length

  println(
    fout,
    join(
      solve.(readit(fin)),
      '\n'
    )
  )

end # of solve(fin,fout)
