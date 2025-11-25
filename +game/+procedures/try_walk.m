function [collider, walked] = try_walk(gm, key)
    arguments
        gm (1, 1) %game.StudentLifeGame
        key (1, :) char
    end

    wld = gm.worlds(gm.world);
    scene = gm.scenes(gm.view);

    collider = 0;

    switch (key)
        case player.PlayerCfg.KEY_NORTH
            collider = wld.move(scene, world.Direction.NORTH);
            if ~collider
                gm.time.step(1);
            end
        case player.PlayerCfg.KEY_SOUTH
            collider = wld.move(scene, world.Direction.SOUTH);
            if ~collider
                gm.time.step(1);
            end
        case player.PlayerCfg.KEY_WEST
            collider = wld.move(scene, world.Direction.WEST);
        case player.PlayerCfg.KEY_EAST
            collider = wld.move(scene, world.Direction.EAST);
        otherwise
            return
    end

    % only executes if player has moved
    switch (collider)
        %case false % skip stepping time
        case world.Collider.PATH
            gm.time.step(1);
        %case world.Collider.ROAD
            gm.time.step(1);
        otherwise
            % 50% speed penalty for straying from walkways
            gm.time.step(2);
    end
end
