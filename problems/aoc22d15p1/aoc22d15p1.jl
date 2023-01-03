using OffsetArrays

function solve(fin,fout)
  readit(input)=
    [row for row in split(read(input,String),"\n",keepempty=false)].|>
      r->map(c->isdigit(c)||c=='-' ? c : ' ',r).|>
        r->parse.(Int,split(r))


  # intervals, "size" of the union, sorting
  input=readit(fin)
  
  Y=input[1][1]
  #display(input)
  onY=Set()
  ivs=[] # intervals
  for r in input[2:end]
    d=abs(r[1]-r[3])+abs(r[2]-r[4])
    dY=abs(r[2]-Y)
    δ=d-dY
    (δ<0) && continue
    push!(ivs,(r[1]-δ,r[1]+δ))
    (r[4]==Y) && push!(onY,(r[3],r[4])) # the beacons on the Y line handled at the end
  end

  sort!(ivs)
  push!(ivs,(typemax(Int),0)) # a sentinel at the end

  exc=0
  A,B=ivs[1]
  for (a,b) in ivs[2:end] 
    if B<a
      exc+=(B-A+1)
      A,B=a,b
    else
      B=max(b,B)
    end
  end
  
  println(fout,exc-length(onY))

end # of solve(fin,)
