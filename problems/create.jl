#!/home/nosy/bin/julia

pre_src="""
##############################################################
# advent of code __YEAR__ day __DAY__ part __PART__

function solve(fin,fout)

  readit(input)=
    split(read(input,String),keepempty=false)

  input=readit(fin)



  println(fout,0)

end # of solve(fin,fout)
"""


help()=printstyled(stderr,
"""
usage:
julia create.jl Y D P
where Y is the year (Y) and 
D is a number between 1 and 25
""",color=226)

if length(ARGS)!=3
  help()
  exit(1)
end

Y,D,P=try
  tp=tryparse.(Int,ARGS)
  @assert nothing ∉ tp
  tp  
catch
  printstyled(stderr,"wrong argument(s).\n",color=:red)
  help()
  exit(2)
end




target="aoc$(Y)d$(D)p$(P)"

if isdir(target)
  printstyled(stderr,"we have it already.\n",color=:red)
  exit(2)
end

mkdir(target)

touch(f)=if !isfile(f)
  open(f,"w") do fh
    nothing
  end
end

touch("$(target)/1.in")
touch("$(target)/1.out")
touch("$(target)/2.in")
touch("$(target)/2.out")


open("$(target)/$(target).jl","w") do f
  print(
    f,
    replace(
      pre_src,
      "__DAY__"=>"$(D)","__YEAR__"=>"$(Y)","__PART__"=>"$(P)"
    )
  )
end

println(stderr,"OK!")
