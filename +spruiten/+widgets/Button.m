classdef Button < spruiten.Widget
    properties
        pos = [1, 1]; % validation on inherited properties is broken R2024b
        dims = [1, 1]; % "
    end

    methods
        function self = Text(pos, content)
            arguments
                pos (1, 2) {mustBeInteger, mustBePositive}
                content {mustBeText}
            end


        end

        function click(self, btn) %#ok<INUSD> required by Widget iface
        end
    end
end