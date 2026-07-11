%sudoku puzzle solving program
%this is the fouth iteration of my sudoku puzzle solver which takes 4x4 a 
% user input sudoku saves it and solves it

clear
clc

%user instructions
disp("This program solves sudoku puzzles," + newline + "you will be asked to enter the values given by the puzzle."+newline+"If a square is blank then input a 0 in its place");


%initialising square 2x2 cell
grids = cell(2, 2); 

%initialising whole grid
wholeGrid = zeros(4);

%store a 2x2 grid of zeros in each cell
for i = 1:4
    grids{i} = zeros(2);  
end


%getting current filled in squares from user

for gridNum = 1:4

    for row = 1:2

        for col = 1:2

            grids{gridNum}(row, col) = input("Enter value of row "+row+", and column "+col+" of grid "+gridNum+": ");

        end

    end
    disp("Grid "+gridNum +":");
    disp(grids{gridNum});


end

%long way but single line
%wholeGrid = [grids{1} grids{2} grids{3}; grids{1} grids{2} grids{3};grids{1} grids{2} grids{3}]
wholeGrid = [grids{1} grids{2}; grids{3} grids{4}];
disp(wholeGrid);


%finding location of blank squares
%%[row, col] = find(grids{1} == 0); 
%blankSpacesGrid1 = length([row, col]);

%runs loop while there are still zeros present in the wholeGrid

while any(wholeGrid(:) == 0)
    %while any(grids{1}(:) == 0)
    
    %finds blank spaces in subgrids and adjusts to wholeGrid index
    for gridNums = 1:4
        [row, col] = find(grids{gridNums} == 0);
        
        if gridNums == 2
            col = col+2;
        elseif gridNums == 3
            row = row+2;
        elseif gridNums == 4
            row = row+2;
            col = col+2;
        end

        %finds only possible location for a number in a subgrid and then
        %plots it
        for num = 1:4
    
            possibilities = 0;
    
            for i = 1:length(row)
    
                if all(wholeGrid(row(i),:) ~= num) && all(wholeGrid(:, col(i)) ~= num)
    
                    possibilities = possibilities + 1;
                    possible = i;
    
    
                end
   
            end
             
            if possibilities == 1
            
                wholeGrid(row(possible), col(possible))= num;
                %wholeGrid = [grids{1} grids{2}; grids{3} grids{4}];
    
            end
            
        end
        %[row, col] = find(grids{1} == 0);
    %end
    end
end

disp(wholeGrid);
