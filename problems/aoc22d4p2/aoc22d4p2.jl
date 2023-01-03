function solve(fin,fout)

  readit(input)=split(read(input,String),"\n",keepempty=false)

  input=readit(fin)
  tot=0
  for row in input
    A,B,C,D=parse.(Int,map(x->isdigit(x) ? x : ' ',row)|>split)
    tot+=(B<C || D<A)
  end

  println(fout,length(input)-tot)

end # of solve(fin,) 
