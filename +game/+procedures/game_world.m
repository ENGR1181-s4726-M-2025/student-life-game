function game_world(gm, wld)
    arguments
        gm (1, 1) %StudentLifeGame
        wld (1, 1) %world.World
    end

    gm.view = game.View.WORLD_ENGINEERING_CORE;
    scene = gm.scenes(gm.view);

    % Put loading gear in the middle of the scene
    scene.fg(ceil(scene.HEIGHT/2), ceil(scene.WIDTH/2)) = game.Sprites.GEAR;
    gm.draw();

    spritemap = load('maps/engineering_core.sprites.csv');

    scene.fg(ceil(scene.HEIGHT/2), ceil(scene.WIDTH/2)) = game.Sprites.CHECKBOX_TRUE;
    gm.draw();

    while (1)
        key = getKeyboardInput(gm.sge);

        switch (key)
            case player.cfg.key_north
                
            case player.cfg.key_north
                
        end

        gm.draw();
    end
end