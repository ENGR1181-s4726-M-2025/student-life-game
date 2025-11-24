% This class should be abstract, but is not because Matlab's implementation of 
%   abstract classes does not provide a way to create a vector of them.

% The degree of hacking that went into making this work...

classdef Widget < handle & matlab.mixin.Heterogeneous
    properties
        % These should not have default values
        pos (1, 2) {mustBeInteger, mustBePositive} = [1, 1];
        dims (1, 2) {mustBeInteger, mustBePositive} = [1, 1];
    end

    methods
        % These should not actually be functions

        % Click event handler
        click(self, btn)

        % Like `draw` of Pane and Menu, but creates a new matrix that a Pane
        %   then overlays upon a scene at the position of the Widget.
        show(self)

        % Point inside bounds of this Widget
        encloses(self, point)
    end
end
