### aoc2022 + a simple julia project (CLI)

* command-line:
  * instantiate: `julia tester.jl` (w/o any argument)
  * run:         `julia tester.jl dayX/partY.jl`
  * on linux one can use `./tester.jl ...` after modifying the shebang line appropriately
* REPL
  * `include("tester.jl")`
  * `tester() # to instantiate`
  * `tester("dayX/partY.jl")`
* REPL w/o tester:
  * `partY=include("dayX/partY.jl")`
  * `partY("dayX/[1,2].in")`

* it's in gamma stage
