##############################################################
# advent of code 16 day 1 part 1


using CircularArrays
function solve(fin,fout)

  readit(input)=
    split(read(input,String),'\n',keepempty=false)

  dirs=CircularArray(
    [(-1,0),(0,1),(1,0),(0,-1)]
  )

  function solve(case::AbstractString)
    I,loc=1,(0,0)
    for cmd in split(case,',',keepempty=false).|>strip
      d,s=cmd[1],parse(Int,cmd[2:end])
#println(d,' ',s)
      I+=(d=='R' ? 1 : -1)
      loc=loc.+s.*dirs[I]
#println(loc)
    end
    abs.(loc)|>sum
  end # of solve(case)

  for case in readit(fin)  
    println(fout,solve(case))
  end

end # of y16d1p1
