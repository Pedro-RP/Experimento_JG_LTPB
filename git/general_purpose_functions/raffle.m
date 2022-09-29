%raffled = raffle(a,b,hmany)
%
%This function raffles a number between the integers a and b in which every
%integer in this interval has equal probability.

function  raffled = raffle(a , b, hmany)

rng(0,'twister');
raffled = randi([a b],hmany,1);

end