function [g]=solveSVD(Z,B,l,w)
% This function solves for the camera response function
% This algorithm was provided in the reference from the assignment
% description: 
% http://vsingh-www.cs.wisc.edu/cs766-12/lec/debevec-siggraph97.pdf

n = 256;
A = zeros(size(Z,1)*size(Z,2)+n+1,n+size(Z,1));
b = zeros(size(A,1),1);
k = 1;
for i=1:size(Z,1)
    for j=1:size(Z,2)
        wij = w(Z(i,j)+1);
        A(k,Z(i,j)+1) = wij;
        A(k,n+i) = -wij; 
        b(k,1) = wij * B(i,j); 
        k=k+1;
    end
end

A(k,129) = 1;
k=k+1;
for i=1:n-2
    A(k,i)=l*w(i+1); 
    A(k,i+1)=-2*l*w(i+1); 
    A(k,i+2)=l*w(i+1);
    k=k+1;
end

x = A\b;

g = x(1:n);
