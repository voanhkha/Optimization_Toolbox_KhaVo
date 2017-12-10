function B = pivot(A, r, c)
% Pivoting all rows in A based on the pivot position specified by row r and
% column c. 

%% Author: Kha Vo, voanhkha@yahoo.com
% Date Completed: Nov 2017.

if r > size(A,1) || c > size(A,2)
   fprintf('Error: The pivot element index is greater than the size of input matrix \r') 
end

A(r,:) = A(r,:)/A(r,c);

for i = 1:size(A,1)
    if i ~= r && A(i,c)~=0
       A(i,:) = A(i,:) - A(r,:)*A(i,c);
    end
end

B = A;