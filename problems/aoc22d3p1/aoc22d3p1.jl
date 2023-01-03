# aoc 2022 day 3 part 1

function solve(fin, fout)

  readit(input)=split(read(input,String),"\n",keepempty=false)

  val(x)=x in 'a':'z' ? x-'a'+1 : x-'A'+27
  tot=0
  for row in readit(fin)
    L,R=row[1:end÷2],row[1+end÷2:end]
    tot+=sum(val.(intersect(L,R)))
  end

  println(fout,tot)

end # of solve(fin,)
