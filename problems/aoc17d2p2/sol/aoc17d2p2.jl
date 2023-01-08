
##############################################################
# advent of code 17 day 2 part 2

using LinearAlgebra
-
function solve(fin,fout)

  readit(input)=
    split(read(input,String),'\n',keepempty=false).|>r->parse.(Int,split(r))

  
  println(
    fout,
    sum(
      c->(ii=findfirst(==(0),(c .% c')+I(length(c)));c[ii[1]]÷c[ii[2]]),
      readit(fin),
      init=0
    )
  )

end # of solve(fin,fout)



if abspath(PROGRAM_FILE)==@__FILE__
  solve(stdin,stdout)
end
