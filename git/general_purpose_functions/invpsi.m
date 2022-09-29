function Y=invpsi(X)
%INVPSI - Inverse digamma (psi) function.  
%
% The digamma function is the derivative of the log gamma function.  This 
% function calculates the value Y > 0 for a value X such that 
% digamma(Y) = X. The code takes 3 Newton steps after initializing the Y
% according to a good approximation of digamma function.
%
% Source: Thomas Minka, Estimating a Dirichlet distribution, 
%         Tehcnical Report 2012, Appendix C.
%
% Change History :
% Date              Time       Prog
% 16-Sep-2013      23:40 PM    Baris Kurt   
% Bogazici University, Dept. of Computer Eng. 80815 Bebek Istanbul Turkey
% e-mail : bariskurt@gmail.com    
 
%initial estimate
M = double(X >= -2.22);
Y = M .*(exp(X) + 0.5) + (1-M) .* -1./(X-psi(1));
 
% make 3 Newton iterations:
Y = Y - (psi(Y)-X)./psi(1,Y);
Y = Y - (psi(Y)-X)./psi(1,Y);
Y = Y - (psi(Y)-X)./psi(1,Y);
 
end