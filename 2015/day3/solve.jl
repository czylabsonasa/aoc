##############################################################
# advent of code 2015 day 3

function day3()

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


  function part1(input)
    join(
      readit(input).|>sub.|>unique.|>length,
      '\n'
    )
  end # of part1


  function part2(input)
    ret=[]
    for case in readit(input)
      push!(
        ret,
        vcat(
          case[1:2:end]|>sub,
          case[2:2:end]|>sub,
        )|>unique|>length
      )
    end
    join(ret,"\n")
  end # of part2

  part1,part2

end # of day3
