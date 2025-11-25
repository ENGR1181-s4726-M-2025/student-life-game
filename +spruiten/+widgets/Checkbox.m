classdef Checkbox < spruiten.Widget
    properties
        checked (1, 1) logical = false;

        % Defined in Widget. See spruiten.Wdiget for explanation
        %pos = [1, 1]; % validation on inherited properties is broken R2024b
        %dims = [1, 1]; % "
    end

    methods
        function self = Checkbox(pos)
            arguments
                pos (1, 2) {mustBeInteger, mustBePositive}
            end

            self.pos = pos;
        end

        function click(self, btn)
            arguments
                self (1, 1) spruiten.widgets.Checkbox
                btn (1, 1) {mustBeNumeric}
            end

            % toggle state on left click
            if btn == 1
                self.checked = ~self.checked;
            end
        end
        
        function sprites = show(self)
            arguments   
                self (1, 1) spruiten.widgets.Checkbox
            end

            if self.checked
                sprites = [game.Sprites.CHECKBOX_TRUE];
            else
                sprites = [game.Sprites.CHECKBOX_FALSE];
            end
        end

        function res = encloses(self, point)
            arguments   
                self (1, 1) spruiten.widgets.Checkbox
                point (1, 2) {mustBeInteger}
            end

            res = point == self.pos;
        end

        function self_ref = set_checked(self, checked)
            arguments
                self (1, 1) spruiten.widgets.Checkbox
                checked (1, 1) logical
            end

            self.checked = checked;

            self_ref = self;
        end
    end
end