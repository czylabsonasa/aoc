##############################################################
# advent of code 2016 day 5 part 2

using MD5
function solve(fin,fout)

  readit(input)=
    split(read(input,String),'\n',keepempty=false).|>strip

  # the only diff from p1 is the StartsWith
  function solve(case::AbstractString,SW="00000",hi=6) 
    pwd=fill('\0',8)
    i=-1
    for _ in 1:8
      while true
        i+=1
        h=md5("$(case)$i")|>bytes2hex
        if startswith(h,SW)
          hhi=h[hi]-'0'+1
          if (hhi in 1:8) && pwd[hhi]=='\0'
            pwd[hhi]=h[hi+1]
            break
          end
        end
      end
    end
    join(pwd)   
  end # of solve(String)


  println(
    fout,
    join(
      solve.(readit(fin)),
      '\n'
    )
  )

end # of solve(fin,fout)



if abspath(PROGRAM_FILE)==@__FILE__
  solve(stdin,stdout)
end
