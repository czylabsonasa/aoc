##############################################################
# advent of code 2022 day 1 part2

function solve(fin,fout)

  readit(fname)=split(read(fname,String),keepempty=true)

  cals=[]
  akt=0
  for v in readit(fin)
    if v>"" 
      akt+=parse(Int,v) 
    else 
      akt>0 && push!(cals,akt)
      akt=0
    end
  end
  
  println(fout,sum(sort(cals)[end-2:end]))

end # of solve(fin,)
