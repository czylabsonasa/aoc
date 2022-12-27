# 
let
fvek=[
  "2*x",
  "x^2",
]

struct fvstore
  f::Function
end

n=length(fvek)
fvarr=fvstore[]

for f in fvek
  push!(fvarr,fvstore(eval(Meta.parse("x->"*f))))
end

fvarr
end
