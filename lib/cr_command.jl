cr_command=( # compile and run commands
  julia=(
    compile=nothing,
    app=`julia app.jl`,
    prog=`julia solve.jl`,
  ),
  python=(
    compile=nothing,
    app=`python app.jl`,
    prog=`python solve.py`,
  ),
)
