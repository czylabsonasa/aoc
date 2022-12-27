#T=Union{Number,Vector{Number}}
#NumVec=Vector{T}

Cmp(x::Number,y::Number)=sign(y-x)

function Cmp(x::Number,y)
  isempty(y) && (return -1)
  Cmp(x,y[1])
end
function Cmp(x,y::Number)
  isempty(x) && (return 1)
  Cmp(x[1],y)
end
function Cmp(x,y)
  (isempty(x) || isempty(y)) && (return sign(length(y)-length(x)))
  c=Cmp(x[1],y[1])
  if c==0
    c=Cmp(x[2:end],y[2:end])
  end
  c
end

include("Cmp.in")

for (x,y) in input
  c=Cmp(x,y)
  r=if c==0
    "="
  elseif c==-1
    ">"
  else
    "<"
  end
  println("$(string(x)) $(r) $(string(y))")
end
