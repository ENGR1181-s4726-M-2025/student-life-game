function game_world(gm)
    arguments
        gm (1, 1) %game.StudentLifeGame
    end

    gm.view = game.View.WORLD;
    scene = gm.scenes(gm.view);
    wld = gm.worlds(gm.world);

    status_pane = spruiten.Pane([1, 1], [3, 10]);
    time_text = status_pane.Text([1, 1]).set_content("XXXXX");

   
    %% MAIN LOOP
    while (1)
        wld.draw(scene);

        time_text.content = gm.time.print_time();
        status_pane.draw(scene, true);

        gm.draw();

        %% PARK HERE
        key = getKeyboardInput(gm.sge);
        
        collider = game.procedures.try_walk(gm, key);
        

        switch (collider)
            % early break for the most common options, which do nothing
            case world.Collider.EMPTY
            case world.Collider.BARRIER
            case world.Collider.WALL

            case world.Collider.CBEC
                
        end
    end
end