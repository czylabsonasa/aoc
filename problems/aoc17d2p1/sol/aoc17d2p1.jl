##############################################################
# advent of code 17 day 2 part 1

function solve(fin,fout)

  readit(input)=
    split(read(input,String),'\n',keepempty=false).|>r->parse.(Int,split(r))

  println(
    fout,
    sum(
      x->(t=extrema(x);t[2]-t[1]),
      readit(fin),
      init=0
    )
  )

end # of solve(fin,fout)



if abspath(PROGRAM_FILE)==@__FILE__
  solve(stdin,stdout)
end
