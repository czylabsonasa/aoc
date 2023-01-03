# aoc 2022 day 6 part 2

function solve(fin,fout)

  input=readline(fin)
  
  L=14
  volt=fill(0,26)
  for c in input[1:L]
    volt[c-'a'+1]+=1
  end
  nbad=count(>(1),volt)

  i=L
  while nbad>0
    i+=1
    cbe=input[i]-'a'+1
    cki=input[i-L]-'a'+1
    nbad+=(volt[cbe]==1)
    volt[cbe]+=1
    nbad-=(volt[cki]==2)
    volt[cki]-=1
  end

  println(fout,i)

end # of solve(fin,)
