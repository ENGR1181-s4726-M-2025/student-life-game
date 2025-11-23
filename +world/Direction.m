% Describes a cardinal direction in a World
% Add their values to a position to move in that direction
classdef(Enumeration) Direction
    enumeration
        NORTH (-1, 0)
        SOUTH (1, 0)
        EAST (0, -1)
        WEST (0, 1)
    end
end