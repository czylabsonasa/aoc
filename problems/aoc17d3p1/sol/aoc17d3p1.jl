##############################################################
# advent of code 17 day 3 part 1

function solve(fin,fout)

  readit(input)=
    split(read(input,String),'\n',keepempty=false).|>x->parse(Int,x)

  ret=[]
  for x in readit(fin)
    push!(ret,
      if x<2
        0
      elseif x<10
        1+x%2
      else                   # O(1) :-)
        y=isqrt(x)
        y-=(1-y%2)            # we need odd side-length
        pt=(y÷2+1,y÷2+1)      # initial point (lower-right corner of the larger square)
        d=(-1,0)              # initial direction (upward)
        st=y+1                # step along the larger square
        x=x-y^2               # steps left
        while x>0
          ast=min(x,st)       # actual step
          pt=pt.+ast.*d
          x=x-ast
          d=(-d[2],d[1])      # ccw rotation
        end
        abs.(pt)|>sum
      end
    )
  end
  
  println(fout,join(ret,'\n'))

end # of solve(fin,fout)



if abspath(PROGRAM_FILE)==@__FILE__
  solve(stdin,stdout)
end
