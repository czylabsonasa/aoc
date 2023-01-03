# aoc 2022 day 9 part 1

function solve(fin,fout)

  readit(input)=
    [(r=split(row);(r[1],parse(Int,r[2]))) 
      for row in split(read(input,String),"\n",keepempty=false)]


  dirs=Dict(
    "D"=>(1,0),
    "U"=>(-1,0),
    "L"=>(0,-1),
    "R"=>(0,1)
  )


  input=readit(fin)

  vis=Set{Tuple{Int,Int}}()
  H,T=(0,0),(0,0)
  push!(vis,T)
  for (s,n) in input
    for _ in 1:n
      H=H.+dirs[s]
      δ=(H.-T)
      if maximum(abs.(δ))>1
        T=T.+sign.(δ)
        push!(vis,T)
      end
      #println(H," ",T," ",δ)
    end
  end
  println(fout,length(vis))

end # of solve(fin,)
