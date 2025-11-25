classdef World < handle
    properties
        % Position inside of this world (next to CBEC)
        player_pos (1, 2) {mustBeInteger, mustBePositive} = [59, 188];

        %% Props below are loaded during init sequence

        % Map of sprites
        sprites (:, :) {mustBeInteger, mustBePositive} = game.Sprites.EMPTY;

        % Map of colliders (building edges, doors, ..., anything else that does 
        %   something when you run into it)
        colliders (:, :) {mustBeInteger} = 0;
    end

    methods
        function draw(self, scene)
            arguments
                self (1, 1) %world.World
                scene (1, 1) game.ViewScene
            end

            %% draw map tiles

            % destructuring rules would cause the x part to be dropped instead
            %   of setting top_left to a vector.
            % this is a row vector, by the way.
            
            top_left = self.scene_top_left(scene);
            bottom_right = top_left + (size(scene.bg) - 1);
            top = top_left(1);
            bottom = bottom_right(1);
            left = top_left(2);
            right = bottom_right(2);

            scene.bg(1:scene.HEIGHT, 1:scene.WIDTH) = ...
                self.sprites(top:bottom, left:right);

            %% draw player

            plr_scene_pos = self.player_pos_in_scene(scene);

            % done!
            scene.fg(plr_scene_pos(1), plr_scene_pos(2)) = game.Sprites.PLAYER;
        end

        % Move the player in the world in some direction. 
        % Return a gate ID if the player has stepped on one
        function collider = move(self, scene, direction)
            arguments
                self (1, 1) world.World
                scene (1, 1) game.ViewScene
                direction (1, 2) {mustBeInteger}
            end

            % Erase old player sprite (invalid)
            old_plr_pos = self.player_pos_in_scene(scene);
            scene.fg(old_plr_pos(1), old_plr_pos(2)) = game.Sprites.EMPTY;

            target_pos = self.player_pos + direction;

            % reject if we violate map bounds
            if any([ ...
                any(target_pos <= 0), ...
                target_pos(1) > height(self.colliders), ...
                target_pos(2) > width(self.colliders) ...
            ])
                collider = world.Collider.BARRIER;
                return
            end

            collider = self.colliders(target_pos(1), target_pos(2));

            % move, if there's nothing in our way
            if ( ...
                collider ~= world.Collider.WALL ...
                && collider ~= world.Collider.BARRIER ...
                && collider ~= world.Collider.NORTH ... % until/if north added
            )
                self.player_pos = target_pos;
            end

            %fprintf("Collider %d, sprite %d\n", collider, self.sprites(target_pos(1), target_pos(2)));
        end

        % this function is 100% certified black magic
        % Do Not Touch It.
        function plr_scene_pos = player_pos_in_scene(self, scene) 
            arguments
                self (1, 1) world.World
                scene (1, 1) game.ViewScene
            end

            midpt = scene.midpoint();
            top_left = self.scene_top_left(scene);

            % ?????? i ?? i just copied and pasted stuff in a random order
            plr_scene_pos(1) = midpt(1) - (top_left(1) - ...
                (self.player_pos(1) - floor(height(scene.bg) / 2)));
            plr_scene_pos(2) = midpt(2) - (top_left(2) - ...
                (self.player_pos(2) - floor(width(scene.bg) / 2)));
        end

        function top_left = scene_top_left(self, scene)
            top_left = [ ...
                clip( ...
                    self.player_pos(1) - floor(height(scene.bg) / 2), ...
                    1, ...
                    height(self.sprites) - scene.HEIGHT + 1 ...
                ), ...
                clip( ...
                    self.player_pos(2) - floor(width(scene.bg) / 2), ...
                    1, ...
                    width(self.sprites) - scene.WIDTH + 1 ...
                ), ...
            ];
        end
    end
end