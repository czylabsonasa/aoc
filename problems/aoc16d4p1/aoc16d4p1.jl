##############################################################
# advent of code 16 day 4 part 1

using DataStructures
function solve(fin,fout)

  readit(input)=
    split(read(input,String),'\n',keepempty=false)

  room_sum=0
  for r in readit(fin)
    sp_r=split(r,isdigit,keepempty=false)
    #println(rr)
    t=sort(
      filter(isletter,sp_r[1])|>counter|>collect,
      lt=(x,y)->(x[2]>y[2])||(x[2]==y[2] && x[1]<y[1])
    )
    t=join(p[1] for p in t)

    # println(t)
    # println(sp_r[2])
    
    if t[1:5]==sp_r[2][2:6]
      room_sum+=parse(Int,filter(isdigit,r))
    end
  end

  println(fout,room_sum)

end # of solve(fin,fout)
