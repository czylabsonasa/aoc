### aoc + a simple julia project (CLI)

* currently getting the problem's id is done by inspecting 
  its name :-) - which is of the form `aocYdDpP.jl`, 
  where Y,D,P are the year, day and part resp.
  * it will be modified, of course

* command-line:
  * instantiate: `julia tester.jl` (w/o any argument)
  * run:         `julia tester.jl pathto/aocYdDpP.jl`
  * on linux one can use `./tester.jl ...` 
    after modifying the "shebang" line appropriately
* REPL
  * `include("tester.jl")`
  * `tester() # to instantiate`
  * `tester("pathto/aocYdDpP.jl")`
* REPL w/o `tester`:
  * `include("pathto/aocYdDpP.jl")`
  * `solve("pathto/I.in",stdout)`

* it's in delta stage
