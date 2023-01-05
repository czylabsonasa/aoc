##############################################################
# advent of code 16 day 4 part 2

using DataStructures
function solve(fin,fout)

  readit(input)=
    split(read(input,String),'\n',keepempty=false)


  function decode(c::Char,sh)
    if c in 'a':'z'
      'a'+(c-'a'+sh)%26
    else # i don handle '-'
      c
    end
  end
  function decode(x::AbstractString,sh)
    if sh==0
      x
    else
      map(c->decode(c,sh),x)      
    end
  end

  room_sum=0
  for r in readit(fin)
    sp_r=split(r,isdigit,keepempty=false)
    #println(rr)
    tmp=sort(
      filter(isletter,sp_r[1])|>counter|>collect,
      lt=(x,y)->(x[2]>y[2])||(x[2]==y[2] && x[1]<y[1])
    )
    tmp=join(p[1] for p in tmp)

    # println(t)
    # println(sp_r[2])
    
    if tmp[1:5]==sp_r[2][2:6]
      id=parse(Int,filter(isdigit,r))
      dec=decode(sp_r[1],id%26)
      #println(stderr,dec," ",id)
      if findfirst("north",dec)!==nothing
        printstyled(stderr,"\n",dec," ***  ",id,"\n\n",blink=true)
      end
    end
  end

  println(fout,1)

end # of solve(fin,fout)
