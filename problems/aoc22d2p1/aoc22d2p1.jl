##############################################################
# aoc2022 day 2 part 1


function solve(fin,fout)

  readit(input)=[split(row) for row in split(read(input,String),"\n",keepempty=false)]

  #         Sc      P      R
  pt=Dict("C"=>3,"B"=>2,"A"=>1)
  lose=Dict("B"=>"C","A"=>"B","C"=>"A")
  tr=Dict("Z"=>"C","Y"=>"B","X"=>"A")

  # apply
  totpt=0
  for (k,v) in readit(fin)
    v=tr[v]
    if v==k
      totpt+=3
    elseif v==lose[k]
      totpt+=6
    end
    totpt+=pt[v]
  end

  println(fout,totpt)
  
end # of solve(fin,)
