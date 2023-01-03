# aoc 2022 day 4 part 1

function solve(fin,fout)

  readit(input)=split(read(input,String),"\n",keepempty=false)

  tot=0

  for row in readit(fin)
    A,B,C,D=parse.(Int,map(x->isdigit(x) ? x : ' ',row)|>split)
    tot+=((A≤C && B≥D) || (C≤A && D≥B))
  end

  println(fout,tot)

end # of solve(fin,)
