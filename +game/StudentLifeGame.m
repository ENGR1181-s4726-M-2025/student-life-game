% NOTES ON VARIABLE NAMES (as I use them):
%
% In cases where a module name clashes with a common var name, abbreviated forms
%   refer to instances.
%
% `player` is a module, `plr` is an instance of Player.
% `world` is a module, `wld` is an instance of World.
% `game` is a moudle, `gm` is an instance of StudentLifeGame.
%
% Does not apply to object properties.

% Anyway.
% This is the main game class. Instantiating it will start the game.
% Contains a bunch of methods to interact with global state.
% This class also contains the base methods that are called to perform context 
%   switches. If any become long or complicated, consider breaking them into a
%   separate file in +procedures/.

classdef StudentLifeGame < handle

    properties
        sge (1, 1); %game.simpleGameEngine
        view (1, 1) game.View = game.View.TITLE;
        scenes (1, :) dictionary = dictionary();% TODO: find elegant way to
                                                 %   check underlying type 

        world (1, 1) world.WorldKind = world.WorldKind.ENGINEERING_CORE;
        worlds (1, :) dictionary = dictionary(); % TODO: find elegant way to
                                                 %   check underlying type
        player (1, 1); %player.Player

        time (1, 1) game.Time;
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
            
            % Init SGE
            self.sge = game.simpleGameEngine( ...
                spritesheet, ...
                sprite_size(1), ...
                sprite_size(2), ...
                zoom_factor, ...
                [0, 0, 0] ... % black background by default
            );

            % Create Views
            view_kinds = enumeration('game.View'); % TODO: find a better way
            for i = 1:length(view_kinds)
                self.scenes(view_kinds(i)) = game.ViewScene;
            end

            self.loading_gear();

            % Create player
            self.player = player.Player();

            % New clock. State gets stuck if we don't make a new one
            self.time = game.Time();

            % Load worlds
            world_kinds = enumeration('world.WorldKind');

            for i = 1:length(world_kinds)
                kind = world_kinds(i);
                self.worlds(kind) = world.World();

                self.worlds(kind).sprites = load( ...
                    world.WorldKind.SPRITES(kind));

                self.worlds(kind).colliders = load( ...
                    world.WorldKind.COLLIDERS(kind));
            end

            self.remove_loading_gear();

            % Main game loop.
            % Many of the other View procedures have their own loops.
            % Switch views by modifying self.view and returning out of that 
            %   function.
            while (true)
                switch (self.view)
                    case game.View.TITLE
                        self.title_screen();
                    case game.View.WORLD
                        self.game_world(self.player.world);
                    case game.View.SCHEDULING
                        self.scheduling();
                    otherwise
                        error("Could not select invalid View %s", self.view);
                end
            end
        end

        % Render the currently selected View
        function draw(self)
            arguments
                self (1, 1) %StudentLifeGame
            end

            scene = self.scenes(self.view);
            self.sge.drawScene(scene.bg, scene.fg);
        end

        % Shows a gear in the middle of the current scene until execution 
        %   completes
        function loading_gear(self)
            scene = self.scenes(self.view);
            midpt = scene.midpoint();
            scene.fg(midpt(1), midpt(2)) = game.Sprites.GEAR;

            self.draw();
        end

        % Eliminates an existing loading gear.
        %   This fn is separate becuase loading may lead directly to a full
        %   redraw, in which case it would be inefficient to delete the
        %   gear from the scene and call a draw when we're just going to
        %   redraw everything anyway.
        function remove_loading_gear(self)
            scene = self.scenes(self.view);
            midpt = scene.midpoint();

            if scene.fg(midpt(1), midpt(2)) == game.Sprites.GEAR
                scene.fg(midpt(1), midpt(2)) = game.Sprites.EMPTY;
            end

            self.draw();
        end

        %% BEGIN breakout fns

        function title_screen(self)
            game.procedures.title_screen(self);
        end

        function game_world(self)
            game.procedures.game_world(self);
        end

        function scheduling(self)
            game.procedures.scheduling(self);
        end

    end

end