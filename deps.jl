#!/home/nosy/bin/julia

import Pkg
Pkg.activate(".")
deps=[
  "Printf","PrettyTables", "TOML", "Crayons",
  "DataStructures", # 22/(11,12): Queue
  "OffsetArrays", # 22/(14,15,18(part2))
  "MD5", # 15/(4)
  "CircularArrays", #
]

if isdefined(Main,:deps) && deps>[]
  Pkg.add.(deps)
end

Pkg.instantiate()
