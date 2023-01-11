##############################################################
# advent of code 17 day 3 part 2

function solve(fin,fout)

  readit(input)=
    split(read(input,String),'\n',keepempty=false).|>x->parse(Int,x)

  
  ret=[]
  for x in readit(fin)
    # x>1, x==1 if-able
    volt=Dict((0,0)=>1)
    idx=1
    loc=(0,0)
    len=1
    while true
      loc=loc.+1
      len+=2
      dir=(-1,0)
      tloc=loc
      for _ in 1:4
        for s in 1:len-1
          idx+=1
          tloc=tloc.+dir
          s=0
          for i in -1:1, j in -1:1
            s+=get(volt,tloc.+(i,j),0)
          end
          volt[tloc]=s
          if s>x
            #push!(ret,idx) # can ask the first idx
            push!(ret,s)
            @goto DONE
          end
        end
        dir=(-dir[2],dir[1])
      end

    end
    @label DONE
  end 
  println(fout,join(ret,'\n'))

end # of solve(fin,fout)



if abspath(PROGRAM_FILE)==@__FILE__
  solve(stdin,stdout)
end
