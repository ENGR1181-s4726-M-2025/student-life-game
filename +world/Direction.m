% Describes a cardinal direction in a World
% Add their values to a position to move in that direction
classdef(Abstract) Direction
    properties(Constant)
        NORTH = [-1, 0];
        SOUTH = [1, 0];
        WEST = [0, -1];
        EAST = [0, 1];
    end
end