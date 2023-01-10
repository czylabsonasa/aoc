module Testit


export mktictoc, mkmsg, ppdict
include("util.jl")

export infoit_repl, infoit_cli
include("infoit.jl")

export validateit
include("validateit.jl")


# compile and run commands' collection
include("cr_command.jl")

export prepareit
include("prepareit.jl")

export compileit
include("compileit.jl")


export runit
include("runit.jl")


export finalit
include("finalit.jl")



#include("runit.jl")
#include("evalit.jl")
#include("reportit.jl")

end
