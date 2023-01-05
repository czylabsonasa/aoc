##############################################################
# advent of code 16 day 2 part 1

function solve(fin,fout)

  readit(input)=
    split(read(input,String),'\n',keepempty=false)

  input=readit(fin)

  move=Dict(
    'U'=>(-1,0),
    'D'=>(1,0),
    'R'=>(0,1),
    'L'=>(0,-1),
  )

  act=(2,2)
  bc=[]
  for row in input
  #println(row)
    for c in row
      next=act.+move[c]
      if all((0,0).<next.<(4,4))
        act=next
      end
    end
    push!(bc,3*(act[1]-1)+act[2])
  end

  println(fout,join(bc))

end # of solve(fin,fout)
