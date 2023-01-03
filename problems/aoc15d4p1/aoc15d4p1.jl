##############################################################
# advent of code 2015 day 4 part 1

using MD5
function solve(fin,fout)

  readit(input)=
    split(read(input,String),'\n',keepempty=false).|>strip

  function solve(case::AbstractString,SW="00000")
    i=1
    while true
      startswith(
        md5("$(case)$i")|>bytes2hex,
        SW
      ) && break
      i+=1
    end
    i
  end # of solve(String)

  println(
    fout,
    join(
      solve.(readit(fin)),
      '\n'
    )
  )

end # of solve(fin,fout)
