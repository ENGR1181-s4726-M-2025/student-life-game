classdef Player < handle
    properties
        pos (3,1) {mustBeInteger, mustBePositive} = [59, 188, 1]; % near CBEC
        
    end

    methods
        move(world)
    end
end