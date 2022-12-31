##############################################################
# advent of code 2015 day 1

function day1()

  readit(fname)=
    split(read(fname,String),'\n',keepempty=false)

  function part1(input)
    ret=[]
    for r in readit(input)
      push!(ret,sum((c=='(' ? 1 : -1) for c in r))
    end
    join(ret,'\n')
  end


  function part2(input)
    ret=[]
    for r in readit(input)
      i=findfirst(
        ==(-1),
        cumsum((c=='(' ? 1 : -1) for c in r)
      )
      push!(ret, i==nothing ? "N/A" : "$(i)")
    end
    join(ret,'\n')
  end

  part1,part2

end # of day1
