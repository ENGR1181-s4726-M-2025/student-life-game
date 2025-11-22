classdef(Abstract) Widget < handle
    properties(Abstract)
        pos (1, 2) {mustBeInteger, mustBePositive}
        dims (1, 2) {mustBeInteger, mustBePositive}
    end

    methods(Abstract)
        % Click event handler
        click(self, btn)

        % Like `draw` of Pane and Menu, but creates a new matrix that a Pane
        %   then overlays upon a scene at the position of the Widget.
        show(self)

        % Point inside bounds of this Widget
        encloses(self, point)
    end
end
