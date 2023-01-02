##############################################################
# advent of code __YEAR__ day __DAY__ part __PART__


using CircularArrays
function y16d1p1(fin,fout)

  readit(input)=
    split(read(input,String),'\n',keepempty=false)

  dirs=CircularArray(
    [(-1,0),(0,1),(1,0),(0,-1)]
  )
  for case in readit(fin)  
    I,loc=1,(0,0)
    for cmd in split(case,',',keepempty=false).|>strip
      d,s=cmd[1],parse(Int,cmd[2:end])
#println(d,' ',s)
      I+=(d=='R' ? 1 : -1)
      loc=loc.+s.*dirs[I]
#println(loc)
      
    end
    println(fout,abs(loc[1])+abs(loc[2]))
  end

end # of y16d1p1
