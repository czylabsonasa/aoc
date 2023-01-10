##############################################################
# advent of code 2022 day 1 part 1

function solve(fin,fout)

  readit(input)=split(read(input,String),keepempty=true)

  maxi=akt=0 
  for v in readit(fin)
    if v>"" 
      v=parse(Int,v) 
    else 
      maxi=max(maxi,akt)
      akt=v=0
    end
    akt+=v
  end

 
  println(fout,maxi)
 
end # of solve(fin,)
