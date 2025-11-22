classdef StudentLifeGame < handle

    properties
        sge (1, 1);% game.simpleGameEngine;
        view (1, 1) game.View = game.View.TITLE;
        scenes (1, :) dictionary = dictionary(); % TODO: find elegant way to
                                                 %   check underlying type
    end

    methods

        function self = StudentLifeGame( ...
                spritesheet, ...
                sprite_size, ...
                zoom_factor)
            arguments
                spritesheet (1, :) {mustBeText}
                sprite_size (1, 2) {mustBeInteger, mustBePositive}
                zoom_factor (1, 1) {mustBeInteger, mustBePositive}
            end
            
            % Init: SGE
            self.sge = game.simpleGameEngine( ...
                spritesheet, ...
                sprite_size(1), ...
                sprite_size(2), ...
                zoom_factor, ...
                [0, 0, 0] ... % black background by default
            );

            % Create: Views
            view_kinds = enumeration('game.View'); % TODO: find a better way
            for i = 1:length(view_kinds)
                self.scenes(view_kinds(i)) = game.ViewScene;
            end

            self.title_screen();
        end

        % Render the currently selected View
        function draw(self)
            arguments
                self (1, 1) %StudentLifeGame
            end

            scene = self.scenes(self.view);
            self.sge.drawScene(scene.bg, scene.fg);
        end

        function title_screen(self)
            arguments
                self (1, 1) %StudentLifeGame
            end

            self.view = game.View.TITLE;
            scene = self.scenes(self.view);

            % Build the title screen UI
            menu = spruiten.Menu();
            pane = menu.Pane([4, 2], [15, 11]);
            ticky_box = pane.Checkbox([3, 5]);

            % Initial draw pass. Makes SGE open a figure, on which we install
            %   the onclick handler
            menu.draw(scene);
            self.draw()

            % Init: Start getting mouse inputs
            % Comment out to stop clobbering SGE's builtin listener
            %game.SgeShims.registerInputHandlers(self.sge.my_figure);

            % Skip directly to world (remove when title screen is done)
            self.world_engineering_core();

            % Main title screen UI loop.
            % The game is launched out of this loop. Execution here pauses, and
            %   the primary in-world view launches its own loop.
            % Execution of different views resembles a tree:
            %
            %                  title_screen()
            %                        |
            %                     world()
            %                      / | \
            %          ... various possible menus ...
            %
            % When a view closes, its function returns and execution control is
            %   is handed back to the view that launched it.

            while (1)
                [clicked_widget, btn] = menu.next_clicked_widget(self.sge, scene);

                if clicked_widget == ticky_box
                    fprintf("tick!\n");
                end

                menu.draw(scene);

                self.draw();
            end
        end

        function world_engineering_core(self)
            arguments
                self (1, 1) %StudentLifeGame
            end

            self.view = game.View.WORLD_ENGINEERING_CORE;
            scene = self.scenes(self.view);

            % Put loading gear in the middle of the scene
            scene.fg(ceil(scene.HEIGHT/2), ceil(scene.WIDTH/2)) = game.Sprites.GEAR;
            self.draw();

            spritemap = load('maps/engineering_core.sprites.csv');

            scene.fg(ceil(scene.HEIGHT/2), ceil(scene.WIDTH/2)) = game.Sprites.CHECKBOX_TRUE;
            self.draw();

            while (1)
                key = getKeyboardInput(self.sge);

                switch (key)
                    case cfg.KEY_NORTH
                        
                    case cfg.KEY_SOUTH
                        
                end

                self.draw();
            end
        end

    end

end