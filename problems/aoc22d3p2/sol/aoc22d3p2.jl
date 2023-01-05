# aoc 2022 day 3 part 2

function solve(fin,fout)


  readit(input)=split(read(input,String),"\n",keepempty=false)

  val(x)=x in 'a':'z' ? x-'a'+1 : x-'A'+27

  input=readit(fin)
  tot=0
  for n in 1:3:length(input)
    tot+=val.(intersect(input[n],input[n+1],input[n+2]))|>sum
  end

  println(fout,tot)

end # of solve(fin,)
