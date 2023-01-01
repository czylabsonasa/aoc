##############################################################
# advent of code 2015 day 5

function day5()

  readit(input)=
    split(read(input,String),'\n',keepempty=false)

  function isnice(s)
    r1,r2,r3=0,0,true # rule counters
    pc='_'
    for c in s
      (c in "aeiou") && (r1+=1)
      (c==pc) && (r2+=1)
      (pc*c in ["ab", "cd", "pq", "xy"]) && (r3=false; break)
      pc=c
    end
    r3 && r1>2 && r2>0
  end

  function part1(input)
    readit(input).|>isnice|>sum
  end # of part1



  function isnice2(s)
    r1,r2=false,false # rule counters
    past=Dict()
    pc='_'
    for (i,c) in enumerate(s)
      pi=get(past,c,i)
      (i-pi==2) && (r1=true)
      past[c]=i

      pi=get(past,pc*c,i)
      (i-pi>1) && (r2=true)
      past[pc*c]=i

      pc=c
      (r1 && r2 && break)
    end
    r1 && r2
  end

  function part2(input)
    readit(input).|>isnice2|>sum
  end # of part2

  part1,part2

end # of day5
