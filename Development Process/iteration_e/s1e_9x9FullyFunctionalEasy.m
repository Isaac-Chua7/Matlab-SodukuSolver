% %sudoku puzzle solving program
%this is the fifth iteration of my sudoku puzzle solving program, that has
%been increased in size back up to a 9x9 puzzle, the solving algorith has
%also been adjusted slightly due to complexities present in 9x9 puzzles
%that are absent in 4x4's
%this iteration of the program can solve simple sudoku puzzles that only
%require constraint propagation to be solved.


%the code that recieve user input has been commented out and replaced with
%copy and pasted test cases to improve testing efficiency
 
% clear
% clc
% % 
% % %user instructions
% disp("This program solves sudoku puzzles," + newline + "you will be asked to enter the values given by the puzzle."+newline+"If a square is blank then input a 0 in its place");
% 
% 
% %initialising square 3x3 cell
% grids = cell(3, 3); 
% 
% %initialising whole grid
% wholeGrid = zeros(9);
% 
% %store a 3x3 grid of zeros in each cell
% for i = 1:9
%     grids{i} = zeros(3);  
% end
% 
% 
% %getting current filled in squares from user
% 
% for gridNum = 1:9
% 
%     for row = 1:3
% 
%         for col = 1:3
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

%%Test Case 1
% grids{1} = [5 3 0; 6 0 0; 0 9 8];
% grids{2} = [0 7 0; 1 9 5; 0 0 0];
% grids{3} = [0 0 0; 0 0 0; 0 6 0];
% grids{4} = [8 0 0; 4 0 0; 7 0 0];
% grids{5} = [0 6 0; 8 0 3; 0 2 0];
% grids{6} = [0 0 3; 0 0 1; 0 0 6];
% grids{7} = [0 6 0; 0 0 0; 0 0 0];
% grids{8} = [0 0 0; 4 1 9; 0 8 0];
% grids{9} = [2 8 0; 0 0 5; 0 7 9];

% Test Case 2 this sudoku can be solved, the other cannot
grids{1} = [0 6 0; 0 8 1; 4 5 0];
grids{2} = [0 0 0; 0 0 2; 0 1 6];
grids{3} = [5 0 3; 0 0 4; 0 7 0];
grids{4} = [2 0 8; 0 7 3; 1 4 0];
grids{5} = [0 6 5; 0 2 4; 0 0 0];
grids{6} = [3 0 0; 0 5 0; 9 0 0];
grids{7} = [0 0 7; 9 0 6; 0 0 4];
grids{8} = [0 0 0; 0 4 7; 0 0 1];
grids{9} = [0 6 0; 2 8 1; 0 3 5];

% Test Case 3
% grids{1} = [0 0 5; 0 1 9; 0 0 0];
% grids{2} = [2 0 0; 4 0 7; 0 9 0];
% grids{3} = [0 7 0; 5 3 0; 0 0 0];
% grids{4} = [1 0 0; 3 4 0; 0 0 8];
% grids{5} = [0 8 6; 0 0 0; 0 0 0];
% grids{6} = [0 0 0; 0 0 0; 0 0 0];
% grids{7} = [0 2 6; 8 5 1; 0 0 3];
% grids{8} = [0 0 8; 9 4 0; 0 5 0];
% grids{9} = [0 4 0; 0 0 6; 8 9 0];



%long way but single line
wholeGrid = [grids{1} grids{2} grids{3}; grids{4} grids{5} grids{6};grids{7} grids{8} grids{9}];
disp(wholeGrid);


%runs loop while there are still zeros present in the wholeGrid
for j = 1:5%while any(wholeGrid(:) == 0)

    %finds blank spaces in subgrids and adjusts to wholeGrid index
    for gridNums = 1:9
        [subRow, subCol] = find(grids{gridNums} == 0);
        [row, col] = find(grids{gridNums} == 0);
        
        if gridNums == 2
            col = col+3;
        elseif gridNums == 3 
            col = col+6;
        elseif gridNums == 4
            row = row+3;
        elseif gridNums == 5
            row = row+3;
            col = col+3;
        elseif gridNums == 6
            row = row+3;
            col = col+6;
        elseif gridNums == 7
            row = row+6;
        elseif gridNums == 8
            row = row+6;
            col = col+3;
        elseif gridNums == 9
            row = row+6;
            col = col+6;
        end

        %finds only possible location for a number in a subgrid and then
        %plots it
        for num = 1:9
    
            possibilities = 0;
    
            for i = 1:length(row)
    
                if all(wholeGrid(row(i),:) ~= num) && all(wholeGrid(:, col(i)) ~= num) && all(grids{gridNums}(:) ~= num)
    
                    possibilities = possibilities + 1;
                    possible = i;
    
    
                end
   
            end
             
            if possibilities == 1
            
                wholeGrid(row(possible), col(possible))= num;
                grids{gridNums}(subRow(possible), subCol(possible)) = num;
            end
            
        end

    end
end

%display the final wholeGrid matrix in the command window
disp(wholeGrid);
