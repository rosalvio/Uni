include "alldifferent.mzn";

int b;
var 0..100: c;

constraint 250*b + 200*c <= 4000;

constraint 2*b <= 6;

constraint 75*b + 150*c <= 2000;

constraint 100*b+150*c <= 500;

constraint 75*c <= 500;

solve maximize 400*b+450*c;

output
    ["no. of bananas cakes = ", show(b), "\n",
    "no. of chocolate cakes = ", show(c), "\n"];