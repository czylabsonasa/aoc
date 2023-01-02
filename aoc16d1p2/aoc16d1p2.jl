##############################################################
# advent of code 16 day 1 part 2


using CircularArrays
function solve(fin,fout)

  readit(input)=
    split(read(input,String),'\n',keepempty=false)

  dirs=CircularArray(
    [(-1,0),(0,1),(1,0),(0,-1)]
  )

  function solve(case::AbstractString)
    start=(0,0)
    I,loc=1,start
    volt=Set([start])
    for cmd in split(case,',',keepempty=false).|>strip
      d,S=cmd[1],parse(Int,cmd[2:end])
      I+=(d=='R' ? 1 : -1)
      for s in 1:S
        loc=loc.+dirs[I]
        if loc in volt
          @goto FOUND
        end
        push!(volt,loc)
      end
    end
    @label FOUND
    abs.(loc.-start)|>sum
  end

  for case in readit(fin)
    println(fout,solve(case))
  end

end # of solve(fin,fout)
