% NOTES ON VARIABLE NAMES (as I use them):
%
% `player` is a module, `plr` is an instance.
% `world` is a module, `wld` is an instance.
% `game` is a moudle, `gm` is an instance.
%
% Does not apply to object properties.

% Anyway.
% This is the main game class. Instantiating it will start the game.
% This class contains the base methods that are called to perform context 
%   switches. If any become long or complicated, consider breaking them into a
%   separate file in +procedures/.

classdef StudentLifeGame < handle

    properties
        sge (1, 1);% game.simpleGameEngine;
        view (1, 1) game.View = game.View.TITLE;
        scenes (1, :) dictionary = dictionary(); % TODO: find elegant way to
                                                 %   check underlying type
        worlds (1, :) 
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

        %% BEGIN breakout fns

        function title_screen(self)
            game.procedures.title_screen(self);
        end

        function game_world(self, world)
            game.procedures.game_world(self, world);
        end

    end

end