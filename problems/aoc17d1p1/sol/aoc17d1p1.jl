##############################################################
# advent of code 17 day 1 part 1

using CircularArrays

function solve(fin,fout)

  readit(input)=
    split(read(input,String),keepempty=false)
    

  ret=[]
  for r in readit(fin)
    c=collect(r).-'0'|>CircularVector
    #@info string(c)
    push!(ret,sum(c[c .== c[2:end+1]]))
  end

  println(fout,join(ret,'\n'))

end # of solve(fin,fout)



if abspath(PROGRAM_FILE)==@__FILE__
  solve(stdin,stdout)
end
