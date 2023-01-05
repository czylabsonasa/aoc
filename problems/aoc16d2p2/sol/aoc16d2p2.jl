##############################################################
# advent of code 16 day 2 part 2

function solve(fin,fout)

  readit(input)=
    split(read(input,String),'\n',keepempty=false)

  input=readit(fin)

  # nice but error prone(! i had 2 errors in the first try)
  move=Dict(
    (5,'R')=>6,
    (2,'D')=>6, (2,'R')=>3,
    (1,'D')=>3,
    (6,'U')=>2, (6,'D')=>'A', (6,'L')=>5, (6,'R')=>7,
    (3,'U')=>1, (3,'D')=>7, (3,'L')=>2, (3,'R')=>4,
    ('A','U')=>6, ('A','R')=>'B',
    (7,'U')=>3, (7,'D')=>'B', (7,'L')=>6, (7,'R')=>8,
    (4,'L')=>3, (4,'D')=>8,
    ('B','U')=>7, ('B','D')=>'D', ('B','L')=>'A', ('B','R')=>'C',
    (8,'U')=>4, (8,'D')=>'C', (8,'L')=>7, (8,'R')=>9,
    ('D','U')=>'B',
    ('C','U')=>8, ('C','L')=>'B', 
    (9,'L')=>8
  )

  act=5
  bc=[]
  for row in input
  #println(row)
    for c in row
      act=get(move,(act,c),act) # stay if no move is possible
    end
    push!(bc,act)
  end

  println(fout,join(bc))

end # of solve(fin,fout)
