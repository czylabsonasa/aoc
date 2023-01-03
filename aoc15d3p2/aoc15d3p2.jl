##############################################################
# advent of code 2015 day 3 part 2

function solve(fin,fout)

  # splits around newline, so 
  # treats each line as a separate case
  readit(input)=
    split(read(input,String),'\n',keepempty=false)


  dd=Dict(
    '<'=>(-1,0),
    '>'=>(1,0),
    '^'=>(0,-1),
    'v'=>(0,1),
  )

  function sub(r)
    [
      accumulate(
        (x,y)->x.+y,
        [dd[x] for x in r],
        init=(0,0)
      )...,
      (0,0)
    ]
  end # of sub


  solve(case)=vcat(
    case[1:2:end]|>sub,
    case[2:2:end]|>sub
  )|>unique|>length
    

  println(
    fout,
    join(
      solve.(readit(fin)),
      '\n'
    )
  )

end # of solve(fin,fout)
