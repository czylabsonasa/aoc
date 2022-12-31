### aoc + a simple julia project (CLI)

* command-line:
  * instantiate: `julia tester.jl` (w/o any argument)
  * run:         `julia tester.jl Y/dayD/partX.jl`
  * on linux one can use `./tester.jl ...` 
    after modifying the "shebang" line appropriately
* REPL
  * `include("tester.jl")`
  * `tester() # to instantiate`
  * `tester("Y/dayD/partX.jl")`
* REPL w/o `tester`:
  * `partX=include("Y/dayD/partX.jl")`
  * `partX("Y/dayD/I.in")`

* it's in delta stage
