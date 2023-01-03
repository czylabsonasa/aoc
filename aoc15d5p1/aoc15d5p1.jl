##############################################################
# advent of code 2015 day 5 part 1

function solve(fin,fout)

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

  println(
    fout,
    readit(fin).|>isnice|>sum
  )

end # of solve(fin,)
