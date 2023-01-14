##############################################################
# advent of code 17 day 5 part 1

function solve(fin,fout)

  readit(input)=
    parse.(Int,read(input,String)|>split)

  lst=readit(fin)

  n=length(lst)
  jmp=0
  i=1
  while true
    ii=i+lst[i]
    lst[i]+=1
    jmp+=1
    if ii<1 || ii>n
      break
    end
    i=ii
  end

  println(fout,jmp)

end # of solve(fin,fout)



if abspath(PROGRAM_FILE)==@__FILE__
  solve(stdin,stdout)
end
