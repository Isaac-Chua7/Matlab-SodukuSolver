% %sudoku puzzle solving program
% this is the 3rd iteration of my sudoku puzzle solver, in this iteration I 
% have reduced my program to solve 4x4 sudoku puzzles for simplicity while
% trying to develop the functionality, this code can take user inputs for a 
% 4x4 sudoku but is unable to solve it.
 

%The code for recieving user input has been commented out and the grids
%have simply been declared for efficiency

% clear
% clc
% 
% %user instructions
% disp("This program solves sudoku puzzles," + newline + "you will be asked to enter the values given by the puzzle."+newline+"If a square is blank then input a 0 in its place");
% 
% 
% %initialising square 2x2 cell
% grids = cell(2, 2); 
% 
% %initialising whole grid
% wholeGrid = [];
% 
% %store a 2x2 grid of zeros in each cell
% for i = 1:4
%     grids{i} = zeros(2);  
% end
% 
% 
% %getting current filled in squares from user
% 
% for gridNum = 1:4
% 
%     for row = 1:2
% 
%         for col = 1:2
% 
%             grids{gridNum}(row, col) = input("Enter value of row "+row+", and column "+col+" of grid "+gridNum+": ");
% 
%         end
% 
%     end
%     disp("Grid "+gridNum +":");
%     disp(grids{gridNum});
% 
% 
% end

%The code for recieving user input has been commented out and the grids
%have simply been declared for efficiency
grids{1} = [0 3; 0 0];
grids{2} = [0 2; 4 3];
grids{3} = [2 0; 3 4];
grids{4} = [3 0; 0 0];

%long way but single line
wholeGrid = [grids{1} grids{2}; grids{3} grids{4}]


%finding location of blank squares in grid 1
[row, col] = find(grids{1} == 0);
%blankSpacesGrid1 = length([row, col]);

%runs loop while there are still zeros present in the wholeGrid

while any(grids{1}(:) == 0)

    for num = 1:4

        possibilities = 0;

        for i = 1:length(row)

            if all(wholeGrid(row(i),:) ~= num) && all(wholeGrid(:, col(i)) ~= num)

                possibilities = possibilities + 1;
                possible = i;


            end

            if possibilities == 1
        
                grids{1}(row(possible), col(possible))= num;

            end
        end
        possibilities = 0;
    end
    [row, col] = find(grids{1} == 0);
end
