% Reference to a foreground and a background sprite map for SGE
classdef ViewScene < handle
    properties
        % Can't seem to use properties within properties.
        % Edit all if changing size (after thinking very hard about whether 
        %   that is a good idea in the first place)
        bg (25, 35) {mustBeInteger, mustBePositive} = ...
            repmat(game.Sprites.EMPTY, 25, 35);
        fg (25, 35) {mustBeInteger, mustBePositive} = ...
            repmat(game.Sprites.EMPTY, 25, 35);
    end

    properties(Constant)
        HEIGHT = 25;
        WIDTH = 35;
    end

    methods

    end
end

