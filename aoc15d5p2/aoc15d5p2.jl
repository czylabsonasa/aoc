##############################################################
# advent of code 2015 day 5 part 2

function solve(fin,fout)

  readit(input)=
    split(read(input,String),'\n',keepempty=false)

  function isnice(s)
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

  println(
    fout,
    readit(fin).|>isnice|>sum
  )

end # of solve(fin,)
