classdef World < handle
    properties
        % Map of sprites
        sprites (:, :) {mustBeInteger, mustBePositive} = game.Sprites.EMPTY;

        % Map of colliders (building edges, doors, ..., anything else that does 
        %   something when you run into it)
        colliders (:, :) {mustBeInteger, mustBePositive} = 0;

        % Position inside of this world
        player_pos (2, 1) {mustBeInteger, mustBePositive} = [59, 188];

    end

    methods
        function draw(self, scene, player)
            arguments
                self (1, 1) %world.World
                scene (1, 1) game.ViewScene
                player (1, 1) player.Player
            end

            top_left = self.player_pos - ceil(size(scene.bg) / 2);

            scene.bg(top)
        end

        % Move the player in the world in some direction. 
        % Return a gate ID if the player has stepped on one
        function gate = move(self, direction)
            arguments
                self (1, 1) world.World
                direction (1, 1) worlds.Direction
            end
        end
    end
end