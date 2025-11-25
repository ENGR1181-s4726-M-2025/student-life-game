% A Spruiten menu. 
% Menus contain Panes, which contain Widgets. 
classdef Menu < handle
    properties
        panes (1, :) = []; %spruiten.Pane = [];
    end
    
    methods
        % Make a new Menu. Does not do anything until `draw` or
        %   `next_event` are called.
        function self = Menu()
        end
        
        % Wait for the next input event, execute appropriate listeners, and 
        %   return a handle to any widgets clicked
        function [widget, btn] = next_clicked_widget(self, sge)
            arguments
                self (1, 1) %spruiten.Menu
                sge (1, 1) %game.simpleGameEngine
            end

            % Hang until the user clicks something that can actually be clicked
            widget = 0;
            while widget == 0

                % Wait until the user clicks.
                % TODO: get non-ginput alternative working
                [point(1), point(2), btn] = getMouseInput(sge);
                %[point(1), point(2), btn] = ...
                %    game.SgeShims.getMouseInput(sge.my_figure, scene);

                if ~point | ~btn %#ok<OR2> Point is not a numeric scalar
                    continue
                end

                for i = 1:length(self.panes)
                    if self.panes(i).encloses(point)

                        % returns 0 if no widgets were clicked
                        widget = self.panes(i).click( ...
                            point, ...
                            btn ...
                        );
    
                        % Bring clicked pane to front of pane list.
                        % This will make draw() highlight the clicked pane.
                        self.panes = [ ...
                            self.panes(i), ...
                            self.panes(1:i-1), ...
                            self.panes(i+1:end)
                        ];
                        return;
                    end
                end
            end
        end

        % Draw each frame onto the provided ViewScene
        function draw(self, scene)
            arguments
                self (1, 1) %spruiten.Menu
                scene (1, 1) game.ViewScene
            end

            for i = 1:length(self.panes)
                % Draw panes. Second arg (`focused`) is true only for the first
                %   pane in the list, so only it will use the highlighted _FOC
                %   menu border sprites (which have a scarlet accent).
                self.panes(i).draw(scene, i == 1);
            end
        end

        % Create a new pane in this Menu
        function new = Pane(self, pos, dims)
            new = spruiten.Pane(pos, dims);
            self.panes = [new self.panes];
        end

        function pane = pane(self, pane)
            self.panes = [new self.panes];
        end
    end
end

