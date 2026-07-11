%sudoku puzzle solving program that takes a user input of a sudoku puzzle,
%where a blank spot is represented by the number 0, then solves the puzzle
%and displays the final result.

%this is the 8th iteration of the sudoku solving program and was simply
%used to catch up and ensure each section of code was adequately commented



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
grids{1} = [5 3 0; 6 0 0; 0 9 8];
grids{2} = [0 7 0; 1 9 5; 0 0 0];
grids{3} = [0 0 0; 0 0 0; 0 6 0];
grids{4} = [8 0 0; 4 0 0; 7 0 0];
grids{5} = [0 6 0; 8 0 3; 0 2 0];
grids{6} = [0 0 3; 0 0 1; 0 0 6];
grids{7} = [0 6 0; 0 0 0; 0 0 0];
grids{8} = [0 0 0; 4 1 9; 0 8 0];
grids{9} = [2 8 0; 0 0 5; 0 7 9];

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

originalGrid = wholeGrid;

progress = true;

%runs loop while there are still zeros present in the wholeGrid
while any(wholeGrid(:) == 0) && progress == true

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
end


%display in command window the final matrix
disp(wholeGrid)

%displaying the result visually (nicely)
figure;
hold on;

%plotting black lines to make 9x9 grid
for i = 0:9
    plot([i i], [0 9], 'k');  % Vertical lines
    plot([0 9], [i i], 'k');  % Horizontal lines

    %making specific lines bold/thicker to enhance visual representation
    if mod(i, 3) == 0

        plot([i i], [0 9], 'k', 'LineWidth', 3);  % Thickened Vertical lines
        plot([0 9], [i i], 'k', 'LineWidth', 3);  % Thickened Horizontal lines

    end
    
end
axis equal off;

%plotting the matirx elements one by one at reuired coordinates, so that
%they line up with the spaces in the 9x9 grid.
drawUp = 1;

for plotCol = 1:9
    
    for plotRow = 9:-1:1
        if originalGrid(drawUp) == wholeGrid(drawUp)            
        
            text((plotCol-0.5), (plotRow-0.5), num2str(wholeGrid(drawUp)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'FontSize', 18, 'FontWeight', 'bold');
        else
            text((plotCol-0.5), (plotRow-0.5), num2str(wholeGrid(drawUp)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'FontSize', 18, 'FontWeight', 'bold', 'Color', 'r');        
        end
        
        drawUp = drawUp + 1;
    
    end

end


