classdef Grid < spruiten.Widget
    properties(Constant)
        
    end
    properties
        content (:, :) char = '';
        white (1, 1) logical = false;

        % Defined in Widget. See spruiten.Wdiget for explanation
        %pos = [1, 1]; % validation on inherited properties is broken R2024b
        %dims = [1, 1]; % "
    end

    methods

        % Use single quotes when passing `content`
        function self = Grid(pos, dims, scale)
            arguments
                pos (1, 2) {mustBeInteger, mustBePositive}
                dims (1, 2) {mustBeInteger, mustBePositive}
                scale (1, 2) {mustBeInteger, mustBePositive}
            end

            self.pos = pos;
            self.dims = dims .* scale;
            self.scale = scale;
        end

        function click(self, btn) %#ok<INUSD> required by Widget class
        end
        
        function sprites = show(self)
            arguments   
                self (1, 1) %spruiten.Widgets.Grid
            end

            % needs fix from MathWorks - currently no way to construct a
            %   dictionary with char keys, so we must convert to strings

            sprites = zeros(self.dims);

            for row = 1:self.dims(1) % lines/rows
                for col = 1:self.dims(2) % chars/cols
                    if (self.white)
                        sprites(row, col) = spruiten.widgets.Text.GLYPHS_WHITE(string(self.content(row, col)));
                    else
                        sprites(row, col) = spruiten.widgets.Text.GLYPHS(string(self.content(row, col)));
                    end
                end
            end
        end

        function res = encloses(self, point)
            res = all(self.pos <= point) && all(point < (self.pos + self.dims));
        end

        function self = set_content(self, content)
            arguments
                self (1, 1) %spruiten.Widgets.Grid
                content (:, :) char
            end

            content = upper(char(content));

            self.content = content;
            self.dims = size(content);
        end

        function self = set_white(self, white)
            arguments
                self (1, 1) %spruiten.Widgets.Grid
                white (1, 1) logical
            end

            self.white = white;
        end
    end
end