using DataStructures: Queue, enqueue!, dequeue!


function solve(fin,fout)

  # as in day8
  readit(input)=mapreduce(
    permutedims,
    vcat,
    split(read(input,String),"\n",keepempty=false).|>collect
  ) 


  # a slight twist of part1
  # i think that it is possible to define a common solver
  # for part1+part2 - but is it worth the time invested?
  # (regarding the code duplication "issue")
  table=readit(fin)
  
  R,C=size(table)
  INF=R*C+1
  dist=fill(INF,R,C)
  S=Tuple(findfirst(==('S'),table))
  E=Tuple(findfirst(==('E'),table))
  table[S...]='a'
  table[E...]='z'

  Q=Queue{Tuple{Int,Int}}()
  enqueue!(Q,E)
  dist[E...]=0

  while length(Q)>0
    sx,sy=dequeue!(Q)
    c=table[sx,sy]
    (c=='a') && continue # no need to continue the search
    d=dist[sx,sy]+1
    for (tx,ty) in [(sx-1,sy),(sx+1,sy),(sx,sy-1),(sx,sy+1)]
      (tx<1 || tx>R || ty<1 || ty>C || c-table[tx,ty]>1 || d>=dist[tx,ty]) && continue
      dist[tx,ty]=d
      enqueue!(Q,(tx,ty))
    end
  end

  I=Tuple.(findall(==('a'),table))

  println(fout, minimum(dist[i...] for i in I))

end # of solve(fin,)
