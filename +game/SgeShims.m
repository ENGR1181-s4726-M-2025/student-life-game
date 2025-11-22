classdef(Abstract) SgeShims
    methods(Static)

        % TODO: finisn
        function key = getKeyboardInput(sge)
            arguments
                sge (1, 1) %game.simpleGameEngine;
            end

            evt_kind = 0;
        end

        function [row, col, btn] = getMouseInput(fig, scene)
            arguments
                fig (1, 1) matlab.ui.Figure
                scene (1, 1) game.ViewScene
            end

            row = -1;
            col = -1;
            btn = -1;
        end

        function registerInputHandlers(fig)
            arguments
                fig (1, 1) double % matlab.ui.Figure
            end

            % With luck, override SGE's handler with our own
            set(fig, 'ButtonDownFcn', @(src, evt) guidata(src, evt));
        end
    end
end