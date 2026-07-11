%sudoku puzzle solving program
%this is the second iteration of my sudoku solving program, this iteration
%combines all 9 of the 2d matrix grids into a 9x9 2d matrix called 
%wholeGrid

clear
clc

%user instructions
disp("This program solves sudoku puzzles," + newline + "you will be asked to enter the values given by the puzzle."+newline+"If a square is blank then input a 0 in its place");


%initialising square 9x9 cell
grids = cell(3, 3); 

%initialising whole grid
wholeGrid = [];

%store a 3x3 grid of zeros in each cell
for i = 1:9
    grids{i} = zeros(3);  
end


%getting current filled in squares from user

for gridNum = 1:9

    for row = 1:3

        for col = 1:3

            grids{gridNum}(row, col) = input("Enter value of row "+row+", and column "+col+" of grid "+gridNum+": ");

        end

    end
    disp("Grid "+gridNum +":");
    disp(grids{gridNum});


end

%long way but single line
wholeGrid = [grids{1} grids{2} grids{3}; grids{4} grids{5} grids{6};grids{7} grids{8} grids{9}]

