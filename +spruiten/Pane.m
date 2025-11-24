% A really bad [spr]ite [UI] [t]oolkit for simpleGame[En]gine.
% Colllection of static methods to make drawing menus easier
classdef Pane < handle
    properties
        widgets (1, :) spruiten.Widget = spruiten.Widget.empty;
        pos (1, 2) {mustBeInteger, mustBePositive} = [1, 1];
        dims (1, 2) {mustBeInteger, mustBePositive} = [1, 1];
    end

    methods

        % Create a pane base at the specified position on the sprite scene.
        % Install widgets by inserting them into this Pane's `widgets`
        %   vector.
        function self = Pane(pos, dims)
            arguments
                pos (1, 2) {mustBeInteger, mustBePositive}
                dims (1, 2) {mustBeInteger, mustBePositive}
            end

            self.pos = pos;
            self.dims = dims - 1;
        end

        % Test if a point is within the bounds (INCLUDING EDGES) of this Pane
        function res = encloses(self, point)
            arguments
                self (1, 1) %Pane;
                point (1, 2) {mustBeInteger}
            end

            res = all([ ...
                self.pos <= point, point <= (self.pos + self.dims) ...
            ]);
        end

        % Turn a pane-relative sprite coordinate into a global one
        function absolute = abs_pos(self, point)
            arguments
                self (1, 1) %Pane;
                point (1, 2) {mustBeInteger, mustBePositive}
            end
            
            absolute = self.pos + point;
        end

        % Turn a global sprite coordinate into a pane-relative one
        function relative = rel_pos(self, point)
            arguments
                self (1, 1) %Pane;
                point (1, 2) {mustBeInteger, mustBePositive}
            end
            
            relative = point - self.pos;
        end

        % Mouse click handler
        function widget = click(self, click_at, btn)
            arguments
                self (1, 1) %Pane;
                click_at (1, 2) {mustBeInteger, mustBePositive}
                btn (1, 1) {mustBeNumeric}
            end

            click_at_rel = self.rel_pos(click_at);
            
            widget = 0;
            for i = 1:length(self.widgets)
                if self.widgets(i).encloses(click_at_rel)
                    self.widgets(i).click(btn);
                    widget = self.widgets(i);
                    return;
                end
            end
        end

        % Draw the frame and its widgets onto a ViewScene
        function scene = draw(self, scene, focused)
            arguments   
                self (1, 1) %Pane
                scene (1, 1) game.ViewScene
                focused (1, 1) logical
            end
    
            x = self.pos(2);
            y = self.pos(1);
            w = self.dims(2);
            h = self.dims(1);
    
            if focused
                % top left
                scene.bg(y, x) = game.Sprites.MENU_FOC_NW;
                % top right
                scene.bg(y, x+w) = game.Sprites.MENU_FOC_NE;
                % bottom left
                scene.bg(y+h, x) = game.Sprites.MENU_FOC_SW;
                % bottom right
                scene.bg(y+h, x+w) = game.Sprites.MENU_FOC_SE;
                % top
                scene.bg(y, x+1:x+w-1) = game.Sprites.MENU_FOC_N;
                % bottom
                scene.bg(y+h, x+1:x+w-1) = game.Sprites.MENU_FOC_S;
                % left
                scene.bg(y+1:y+h-1, x) = game.Sprites.MENU_FOC_W;
                % right
                scene.bg(y+1:y+h-1, x+w) = game.Sprites.MENU_FOC_E;
            else
                % top left
                scene.bg(y, x) = game.Sprites.MENU_NW;
                % top right
                scene.bg(y, x+w) = game.Sprites.MENU_NE;
                % bottom left
                scene.bg(y+h, x) = game.Sprites.MENU_SW;
                % bottom right
                scene.bg(y+h, x+w) = game.Sprites.MENU_SE;
                % top
                scene.bg(y, x+1:x+w-1) = game.Sprites.MENU_N;
                % bottom
                scene.bg(y+h, x+1:x+w-1) = game.Sprites.MENU_S;
                % left
                scene.bg(y+1:y+h-1, x) = game.Sprites.MENU_W;
                % right
                scene.bg(y+1:y+h-1, x+w) = game.Sprites.MENU_E;
            end
            % background
            scene.bg(y+1:y+h-1, x+1:x+w-1) = game.Sprites.MENU;

            % Draw widgets
            for i = 1:length(self.widgets)
                w = self.widgets(i);
                wpos = self.abs_pos(w.pos);

                % trial and error index magic
                % i think the -1 on each dimension accounts for the
                %   pane-relative origin being (1, 1)
                % we have to do the same thing with clicks
                scene.fg( ...
                    wpos(1) : wpos(1) + w.dims(1) - 1, ...
                    wpos(2) : wpos(2) + w.dims(2) - 1 ...
                ) = w.show();
            end
        end

        % Safely add a widget to this Pane
        function insert_widget(self, wid)
            %if isempty(self.widgets)
                %self.widgets = wid;
            %else
                self.widgets = horzcat(self.widgets, wid);
            %end
        end

        %% BEGIN Pre-attached Widget constructors, for convenience
        % Input validation not needed because it is performed within the widget
        %   constructor

        function new = Checkbox(self, pos, ticked)
            if nargin < 3
                ticked = false;
            end

            new = spruiten.widgets.Checkbox(pos, ticked);
            self.insert_widget(new);
        end

        function new = Text(self, pos, content)
            new = spruiten.widgets.Text(pos, content);
            self.insert_widget(new);
        end
    end
end