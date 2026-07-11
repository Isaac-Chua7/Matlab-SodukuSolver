% %sudoku puzzle solving program that takes a user input of a sudoku puzzle,
% %where a blank spot is represented by the number 0, then solves the puzzle
% %and displays the final result.
%This iteration adds the ability to go back and correct inputs if the user
%accidentally enters the wrong number, it also checks if the user inputs
%and invalid input.


clear
clc

% %user instructions
disp("This program solves sudoku puzzles," + newline + ...
    "you will be asked to enter the values given by the puzzle." ...
    +newline+"If a square is blank then input a 0 in its place");


%initialising square 3x3 cell
grids = cell(3, 3); 

%initialising whole grid
wholeGrid = zeros(9);

%store a 3x3 grid of zeros in each cell
for i = 1:9
    grids{i} = zeros(3);  
end


%getting current filled in squares from user

for gridNum = 1:9

    for row = 1:3

        for col = 1:3

            %prompts user for number input
            grids{gridNum}(row, col) = input("Enter value of row " + row ...
                + ", and column " + col + " of grid " + gridNum + ": ");

            %checking that the user input is not below 0 or above nine 
            %and is an integer, as required in a sudoku puzzle
            while grids{gridNum}(row, col) > 9 || ...
                grids{gridNum}(row, col) < 0 || ...
                mod(grids{gridNum}(row, col), 1) ~= 0

                %gets user to enter a valid input
                 grids{gridNum}(row, col) = input("INVALID INPUT " + ...
                     "enter the correct value for row "+ row + ...
                     ", and column "+col+" of grid "+gridNum+": ");

            end

        end

    end

    %displays the 3x3 subgrid that was just inputted
    disp("Grid "+gridNum +":");
    disp(grids{gridNum});

end

%combine subgrids (3x3) into the whole grid (9x9)
wholeGrid = [grids{1} grids{2} grids{3};
             grids{4} grids{5} grids{6};
             grids{7} grids{8} grids{9}];

%program takes note of what numbers the user inputted so when displaying
%later on computer additions can be display in a separate colour
originalGrid = wholeGrid;

%gets user to check if they made any input mistakes
disp("Check your inputted sudoku for mistakes, ");

%calls a function that gives the user a better visual representation of 
%what they have inputted
displaySudoku(originalGrid, wholeGrid, false);

%gets the user to notify program if they made a mistake
mistake = input("if there are any type 'mistake', " + ...
    "if not type something else: ", 's');

%if statement runs if user has declared a mistake
if mistake == "mistake"

    %checks number of mistakes
    numMistakes = input("how many mistakes did you make: ");

    %for loop runs which asks the user which sub grid, row and column their
    %mistake is in and then allows them to change it
    for i = 1:numMistakes

        subGridOfMistake = input("Which 3x3 subgrid is the mistake " + ...
            i + " in? ");

        rowOfMistake = input("Which row of the 3x3 subgrid is the " + ...
            "mistake " + i + " in? ");

        colOfMistake = input("Which column of the 3x3 subgrid is " + ...
            "the mistake " + i + " in? ");

        grids{subGridOfMistake}(rowOfMistake, colOfMistake) = input( ...
            "Enter the" + " correct value of the mistake "+ i +" space: ");

        %ensuring the corrected user input is a valide sudoku input
        while grids{subGridOfMistake}(rowOfMistake, colOfMistake) > 9 || ...
                grids{subGridOfMistake}(rowOfMistake, colOfMistake) < 0 || ...
                mod(grids{subGridOfMistake}(rowOfMistake, colOfMistake), 1) ~= 0

            %gets user to change their input if it is an invalid sudoku
            %input
            grids{subGridOfMistake}(rowOfMistake, colOfMistake) = ...
                input("INVALID INPUT enter " + "correct value for row " ...
                + row + ", and column "+ col +" of grid " ...
                + subGridOfMistake +": ");

        end

    end

end

%updates the wholeGrid after mistakes have been ammended
wholeGrid = [grids{1} grids{2} grids{3};
             grids{4} grids{5} grids{6};
             grids{7} grids{8} grids{9}];

%updates the original grid (used when plotting the final output)
originalGrid = wholeGrid;

%initialises progress as true
progress = true;

%initialises numberOfBackTracks as 0
numberOfBackTracks = 0;

%runs loop while there are still zeros present in the wholeGrid
while any(wholeGrid(:) == 0)

    %sets progress to false
    progress = false; 

    %runs loop for each of the 9 3x3 grids, to find location of blank/ '0'
    %spaces
    for gridNums = 1:9
        [subRow, subCol] = find(grids{gridNums} == 0);
        [row, col] = find(grids{gridNums} == 0);
        
        %alters row and col indexs of blank spaces within 3x3 subgrids to 
        %be consistent with overall wholeGrid.
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
                if all(wholeGrid(row(i),:) ~= num) && ...
                    all(wholeGrid(:, col(i)) ~= num) &&...
                    all(grids{gridNums}(:) ~= num)
    
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
       
        displaySudoku(originalGrid, wholeGrid, true)

    end

    %if basic solver (constraint propagation is unable to make anymore
    %progress the backtracking algorithm is called, this checks if a blank
    %space can take a specific value, then tries to solve the puzzle with
    %this new value, if it can't it changes the value to something else
    if any(wholeGrid(:) == 0) && progress == false
        
        disp("Basic solver can no longer make any progress, " + ...
            "now backtracking");

        %the number of backtracks is counted to avoid getting stuck in
        %infinite while loop
        numberOfBackTracks = numberOfBackTracks + 1;

        %if backtracking function has been run 82 times it will quit trying
        %to solve the puzzle and state that it is invalid (it would have
        %solved before this point had the puzzle been valid)
        if numberOfBackTracks == 82

            disp("Unable to solve puzzle, check is puzzle is invalid");
            close all;
            break


        end
    
        % Solve the puzzle with backtracking, once backTracker solves the
        % puzzle it returns here
        [wholeGrid, success] = backtrackSolve(wholeGrid);
    
        %marks the solution of the puzzle, prints message and visually
        %plots the solution
        if success == true

            disp("Backtracking worked, puzzle is solved:");
            displaySudoku(originalGrid, wholeGrid, true);

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

    %lines 346-350 finds out with 3x3 subgrid the blank space is in
    firstRowOfSubGrid = floor((row - 1) / 3) * 3 + 1;
    firstColOfSubGrid = floor((col - 1) / 3) * 3 + 1;

    subGrid = wholeGrid(firstRowOfSubGrid:firstRowOfSubGrid+2, ...
        firstColOfSubGrid:firstColOfSubGrid+2);

    %this code then checks is the number is not already in the 3x3 subgrid,
    %setting valid to true if this requirement is met
    valid = all(subGrid(:) ~= num);


end


%displaySudoku function plots a 9x9 Sudoku grid and displays the numbers,
%the originalGrid is used to determine original vs computer calculated 
%numbers, the wholeGrid is complete grid to display.
function displaySudoku(originalGrid, wholeGrid, isSolved)

    %closes any currently open figure windows
    close all;
    
    %displaying the result visually
    figure; % opening a new figure window
    hold on; % plots everything together
    
    %plotting black lines to make 9x9 grid
    for i = 0:9
       
        plot([i i], [0 9], 'k');  % vertical lines
        plot([0 9], [i i], 'k');  % horizontal lines
    
        %making specific lines bold/thicker create sudoku appearance
        if mod(i, 3) == 0
            
            plot([i i], [0 9], 'k', 'LineWidth', 3);  %thicker vertical lines
            plot([0 9], [i i], 'k', 'LineWidth', 3);  %thicker horizontal lines
        
        end
    
    end

    % ensures axis are equal size/stretch so grids are square, and ticks off
    axis equal off; 
    

    %initialises drawUp as 1
    drawUp = 1;

    % plotting the matrix elements one by one at required coordinates, so that
    % they line up with the spaces in the 9x9 grid. this does not bother with
    % row and column number rather uses the overall index of the element.
    for plotCol = 1:9
        for plotRow = 9:-1:1
    
            %as '0' represents a blank space a '0' is plotted as ''
            if wholeGrid(drawUp) == 0
                    text((plotCol-0.5), (plotRow-0.5), '', ...
                    'HorizontalAlignment', 'center', ...
                    'VerticalAlignment', 'middle', ...
                    'FontSize', 18, 'FontWeight', 'bold');
    
            %if the index (drawUp) of the wholeGrid was already in the
            %originalGrid (user input) then it is plotted in black
            elseif originalGrid(drawUp) == wholeGrid(drawUp)
                text((plotCol-0.5), (plotRow-0.5), ...
                    num2str(wholeGrid(drawUp)), 'HorizontalAlignment', ...
                    'center', 'VerticalAlignment', 'middle', ...
                    'FontSize', 18, 'FontWeight', 'bold');
    
            %if the index (drawUp) of the wholeGrid was not in the
            %originalGrid (user input) then it is plotted in red
            else
                
                text((plotCol-0.5), (plotRow-0.5), ...
                    num2str(wholeGrid(drawUp)), 'HorizontalAlignment', ...
                    'center', 'VerticalAlignment', 'middle', ...
                    'FontSize', 18, 'FontWeight', 'bold', 'Color', 'r'); 
    
            end
            
            %drawUp index is increased by 1
            drawUp = drawUp + 1;
        
        end

    end

    %checks it the program is solved before playing sound. Early on the 
    % grid is displayed for user to check mistakes, in this instance the
    % sound should not be played
    if isSolved == true

        %loading and playing a sound file once the puzzle is solved (y and 
        % Fs are conventional MATLAB variable names when working with 
        % audio, y for audio waveform and Fs for sampling frequency. 
        %This sound is taken from the NYT crossword completion music
        [y, Fs] = audioread('NYT Crossword SFX.mp3');  %load sound file 
        sound(y, Fs); %play sound

    end

end