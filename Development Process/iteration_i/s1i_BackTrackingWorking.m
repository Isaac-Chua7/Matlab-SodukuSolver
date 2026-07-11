%sudoku puzzle solving program that takes a user input of a sudoku puzzle,
%where a blank spot is represented by the number 0, then solves the puzzle
%and displays the final result.

%this is the 9th iteration of my program and improves the code by including
%a backtracking function that runs when the constraint propagation
%algorithm is unable to complete the puzzle. It has changes the final
%display of the solution to a function format so it can be easily multiple
%times or at different stages.


%the code that recieve user input has been commented out and replaced with
%copy and pasted test cases to improve testing efficiency
clear
clc
% 
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

%Test Case 1
% grids{1} = [5 3 0; 6 0 0; 0 9 8];
% grids{2} = [0 7 0; 1 9 5; 0 0 0];
% grids{3} = [0 0 0; 0 0 0; 0 6 0];
% grids{4} = [8 0 0; 4 0 0; 7 0 0];
% grids{5} = [0 6 0; 8 0 3; 0 2 0];
% grids{6} = [0 0 3; 0 0 1; 0 0 6];
% grids{7} = [0 6 0; 0 0 0; 0 0 0];
% grids{8} = [0 0 0; 4 1 9; 0 8 0];
% grids{9} = [2 8 0; 0 0 5; 0 7 9];

%Test Case 2
% grids{1} = [0 6 0; 0 8 1; 4 5 0];
% grids{2} = [0 0 0; 0 0 2; 0 1 6];
% grids{3} = [5 0 3; 0 0 4; 0 7 0];
% grids{4} = [2 0 8; 0 7 3; 1 4 0];
% grids{5} = [0 6 5; 0 2 4; 0 0 0];
% grids{6} = [3 0 0; 0 5 0; 9 0 0];
% grids{7} = [0 0 7; 9 0 6; 0 0 4];
% grids{8} = [0 0 0; 0 4 7; 0 0 1];
% grids{9} = [0 6 0; 2 8 1; 0 3 5];

%Test Case 3
grids{1} = [0 0 5; 0 1 9; 0 0 0];
grids{2} = [2 0 0; 4 0 7; 0 9 0];
grids{3} = [0 7 0; 5 3 0; 0 0 0];
grids{4} = [1 0 0; 3 4 0; 0 0 8];
grids{5} = [0 8 6; 0 0 0; 0 0 0];
grids{6} = [0 0 0; 0 0 0; 0 0 0];
grids{7} = [0 2 6; 8 5 1; 0 0 3];
grids{8} = [0 0 8; 9 4 0; 0 5 0];
grids{9} = [0 4 0; 0 0 6; 8 9 0];






%long way but single line
wholeGrid = [grids{1} grids{2} grids{3}; grids{4} grids{5} grids{6};grids{7} grids{8} grids{9}];
%disp(wholeGrid);

%takes of the original given number's so computer input can be displayed
%in a different colour later on
originalGrid = wholeGrid;


progress = true;

%runs loop while there are still zeros present in the wholeGrid
while any(wholeGrid(:) == 0)

    %sets progress to false
    progress = false; 

    %runs loop for each of the 9 3x3 grids, to find location of blank/ 0
    %spots
    for gridNums = 1:9
        [subRow, subCol] = find(grids{gridNums} == 0);
        [row, col] = find(grids{gridNums} == 0);
        
        %alters row and col nuber of blank spots within 3x3 grids to be 
        %consistent with overall wholeGrid.
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

        %for loop run for the nine possible sudoku numbers, plots number in
        %a blank spot of a 3x3 grid if that is the only possible location
        %for that number
        for num = 1:9
    
            %sets possibilities to 0
            possibilities = 0;
    
            %runs for loop for the number of blank squares (does this one
            %3x3 grid at a time
            for i = 1:length(row)
    
                %checks if the numbers 1-9 starting with 1 are present in
                %the row or coloumn of the wholeGrid(9x9), also checks if
                %the number is present in the current 3x3 grid. If this if
                %statement is true then the number could be placed at the
                %index of the current blank space.
                if all(wholeGrid(row(i),:) ~= num) && all(wholeGrid(:, col(i)) ~= num) && all(grids{gridNums}(:) ~= num)
    
                    %counts the number of possible placements
                    possibilities = possibilities + 1;

                    %remembers the index of the blank space where placement
                    %is possible
                    possible = i;
    
    
                end
   
            end
             
            %if there is only one valid placement for a number it is placed
            %at the corressponding index
            if possibilities == 1
                
                %subRow and subCol values allow for the valid number
                %placement within the current 3x3 grid
                grids{gridNums}(subRow(possible), subCol(possible)) = num;

                %the whole grid is updated
                wholeGrid = [grids{1} grids{2} grids{3}; 
                             grids{4} grids{5} grids{6};
                             grids{7} grids{8} grids{9}];
                
                %progress is set to true to allow the program to continue
                %having known it is still making solving progress
                progress = true;
            end
            
        end

    end

    %displays the solution of the puzzle, prints message and visually plots
    %the solution is constraint propagation alone was able to solve the
    %puzzle
    if all(wholeGrid(:) ~= 0)
       
        displaySudoku(originalGrid, wholeGrid)

    end

    %if basic solver (constraint propagation is unable to make anymore
    %progress the backtracking algorithm is called, this checks if a blank
    %space can take a specific value, then tries to solve the puzzle with
    %this new value, if it can't it changes the value to something else
    if any(wholeGrid(:) == 0) && progress == false
        
        disp("Basic solver can no longer make any progress, starting backtracking");
    
        % Solve the puzzle with backtracking, once backTracker solves the
        % puzzle it returns here
        [wholeGrid, success] = backtrackSolve(wholeGrid);
    
        %marks the solution of the puzzle and prints message
        if success == true

            disp("Backtracking worked, puzzle is solved:");

        end
    
    end


end

%This is the backtracking function it references a second function called 
%possiblePlacement, together they solve the sudoku puzzle by guessing and 
%adjusting if the program can't solve the puzzle.


%the backtrackSolve function outputs the wholeGrid (2d matrix), success
%(boolean), and has the parameter 'wholeGrid'
function [wholeGrid, success] = backtrackSolve(wholeGrid)

    %initialises success as false
    success = false;

    %finds the location of the first blank space/ '0' in the wholeGrid matrix
    [row, col] = find(wholeGrid == 0, 1); 
    
    %checks if the puzzle is solved (if row equals 0 there are no blank
    %spaces)
    if length(row) == 0
        
        success = true;
        
        %returns if the puzzle is solves to stop further code, running
        %without purpose
        return;

    end

    %goes through all 9 possible number inputs
    for num = 1:9

        %calls possiblePlacement function to test if current number can be 
        %placed in the first blank space
        if possiblePlacement(wholeGrid, row, col, num)
           
            %plots the number
            wholeGrid(row, col) = num;

            %restarts the backtrack function to continue solving
            [wholeGrid, success] = backtrackSolve(wholeGrid);

            %while solving continues it will either complete the puzzle, in
            %which case it will return so it can display the final outcome.
            %or it will not be able to solve the puzzle, in which case the
            %program backtracks and sets the blank space back to '0'
            if success == true
                
                return;

            end

            %previously mentioned case in which program backtracks and sets
            %blank space to '0'
            wholeGrid(row, col) = 0;  % Backtrack

        end
    
    end

end

%possiblePlacement function is called by the backtracking function to check
%if a number can be placed in a blank space without violating any sudoku 
%rules 
function valid = possiblePlacement(wholeGrid, row, col, num)
    
    %this if statement checks if the number is already present in the blank 
    %spaces's row or column
    if any(wholeGrid(row, :) == num) || any(wholeGrid(:, col) == num)
        
        %valid is returned as false if number is already present in the blank 
        %spaces's row or column
        valid = false;
        
        return;
   
    end

    %this code runs if the number is not already present in the blank
    %space's row or column, this finds out with 3x3 subgrid the blank space
    %is in
    firstRowOfSubGrid = floor((row - 1) / 3) * 3 + 1;
    firstColOfSubGrid = floor((col - 1) / 3) * 3 + 1;
    subGrid = wholeGrid(firstRowOfSubGrid:firstRowOfSubGrid+2, firstColOfSubGrid:firstColOfSubGrid+2);

    %this code then checks is the number is not already in the 3x3 subgrid,
    %setting valid to true if this requirement is met
    valid = all(subGrid(:) ~= num);


end

displaySudoku(originalGrid, wholeGrid);


function displaySudoku(originalGrid, wholeGrid)
% displaySudoku - Plots a 9x9 Sudoku grid and displays the numbers
% originalGrid - The initial puzzle (used to determine original vs filled-in numbers)
% wholeGrid    - The complete grid to display (including filled-in values)

%Closes any currently open figure windows
close all;

% displaying the result visually (nicely)
figure; % opening a new figure window
hold on; % plots everything together

% plotting black lines to make 9x9 grid
for i = 0:9
    plot([i i], [0 9], 'k');  % Vertical lines
    plot([0 9], [i i], 'k');  % Horizontal lines

    % making specific lines bold/thicker to enhance visual representation
    if mod(i, 3) == 0
        plot([i i], [0 9], 'k', 'LineWidth', 3);  % Thickened Vertical lines
        plot([0 9], [i i], 'k', 'LineWidth', 3);  % Thickened Horizontal lines
    end
end

% ensures axis are equal size/stretch so grids are square, ticks off
axis equal off; 

% flatten matrices in case they’re passed in as 9x9
originalGrid = originalGrid(:);
wholeGrid = wholeGrid(:);

% plotting the matrix elements one by one at required coordinates, so that
% they line up with the spaces in the 9x9 grid. this does not bother with
% row and column number rather uses the overall index of the element.
drawUp = 1;

for plotCol = 1:9
    for plotRow = 9:-1:1

        if wholeGrid(drawUp) == 0
                text((plotCol-0.5), (plotRow-0.5), '', ...
                'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', ...
                'FontSize', 18, 'FontWeight', 'bold');


        elseif originalGrid(drawUp) == wholeGrid(drawUp)
            text((plotCol-0.5), (plotRow-0.5), num2str(wholeGrid(drawUp)), ...
                'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', ...
                'FontSize', 18, 'FontWeight', 'bold');
        else
            text((plotCol-0.5), (plotRow-0.5), num2str(wholeGrid(drawUp)), ...
                'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', ...
                'FontSize', 18, 'FontWeight', 'bold', 'Color', 'r');        
        end
        drawUp = drawUp + 1;
    end
end

end



