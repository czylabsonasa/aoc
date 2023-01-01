##############################################################
# advent of code 2015 day 4

using MD5
function day4()

  readit(input)=
    read(input,String)|>strip

  function part1(input,SW="00000")
    input=readit(input)
    i=1
    while true
      startswith(
        md5("$(input)$i")|>bytes2hex,
        SW
      ) && break
      i+=1
    end
    i
  end # of part1


  part2(input)=part1(input,"000000")
  # end of part2

  part1,part2

end # of day4
