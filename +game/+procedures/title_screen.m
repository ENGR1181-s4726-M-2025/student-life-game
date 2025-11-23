function title_screen(gm)
    arguments
        gm (1, 1) %StudentLifeGame
    end

    gm.view = game.View.TITLE;
    scene = gm.scenes(gm.view);

    % Build the title screen UI
    menu = spruiten.Menu();
    pane = menu.Pane([4, 2], [15, 11]);
    ticky_box = pane.Checkbox([3, 5]);

    % Initial draw pass. Makes SGE open a figure, on which we install
    %   the onclick handler
    menu.draw(scene);
    gm.draw()

    % Init: Start getting mouse inputs
    % Comment out to stop clobbering SGE's builtin listener
    %game.SgeShims.registerInputHandlers(self.sge.my_figure);

    % temp: Skip directly to world (remove when title screen is done)
    gm.game_world();

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
        [clicked_widget, btn] = menu.next_clicked_widget(gm.sge, scene);

        if clicked_widget == ticky_box
            fprintf("tick!\n");
        end

        menu.draw(scene);

        gm.draw();
    end
end