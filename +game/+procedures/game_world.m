function game_world(gm, wld)
    arguments
        gm (1, 1) %game.StudentLifeGame
        wld (1, 1) %world.World
    end

    gm.view = game.View.WORLD_ENGINEERING_CORE;
    scene = gm.scenes(gm.view);


    while (1)
        key = getKeyboardInput(gm.sge);

        switch (key)
            case player.PlayerCfg.key_north
                
        end

        gm.draw();
    end
end