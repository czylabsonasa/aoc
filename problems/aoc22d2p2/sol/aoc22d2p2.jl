##############################################################
# aoc2022 day 2 part 2


function solve(fin,fout)

  readit(input)=[split(row) for row in split(read(input,String),"\n",keepempty=false)]


  #         Sc      P      R
  pt=Dict("C"=>3,"B"=>2,"A"=>1)
  lose=Dict("B"=>"C","A"=>"B","C"=>"A")
  # here unused
  tr=Dict("Z"=>"C","Y"=>"B","X"=>"A")

  win=Dict("C"=>"B","B"=>"A","A"=>"C")

  totpt=0
  for (k,v) in readit(fin)
    if v=="X"        # lose
      v=win[k]
    elseif v=="Y"    # draw
      totpt+=3
      v=k
    else             # win
      totpt+=6
      v=lose[k]
    end              
    totpt+=pt[v]
  end

  println(fout,totpt)
  
end # of solve(fin,)
