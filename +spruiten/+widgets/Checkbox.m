classdef Checkbox < spruiten.Widget
    properties
        ticked (1, 1) logical = false;

        % Defined in Widget. See spruiten.Wdiget for explanation
        %pos = [1, 1]; % validation on inherited properties is broken R2024b
        %dims = [1, 1]; % "
    end

    methods
        function self = Checkbox(pos, ticked)
            arguments
                pos (1, 2) {mustBeInteger, mustBePositive}
                ticked (1, 1) logical
            end

            if nargin < 2
                ticked = false;
            end

            self.pos = pos;
            self.ticked = ticked;
        end

        function click(self, btn)
            arguments
                self (1, 1) %Checkbox
                btn (1, 1) {mustBeNumeric}
            end

            % toggle state on left click
            if btn == 1
                self.ticked = ~self.ticked;
            end
        end
        
        function sprites = show(self)
            arguments   
                self (1, 1) %Checkbox
            end

            if self.ticked
                sprites = [game.Sprites.CHECKBOX_TRUE];
            else
                sprites = [game.Sprites.CHECKBOX_FALSE];
            end
        end

        function res = encloses(self, point)
            arguments   
                self (1, 1) %Checkbox
                point (1, 2) {mustBeInteger}
            end

            res = point == self.pos;
        end
    end
end