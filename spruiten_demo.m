sge = game.simpleGameEngine( ...
    'assets/sheet.png', ...
    16, 16, ...
    4 ...
);

menu = spruiten.Menu();

%                        pos      dimensions
left_pane =    menu.Pane([2, 1],  [5, 17]);
right_pane =   menu.Pane([2, 18], [5, 18]);

text_1 =  left_pane.Text([1, 1]) ...
    .set_content('Left pane here');
text_2 = right_pane.Text([2, 2]) ...
    .set_content('And right pane.');

% New pair of scenes for SGE
% contains two matrices:
%   - fg - 25x35, filled with EMPTY sprite
%   - bg - 25x35, filled with EMPTY sprite
scene = game.ViewScene();

% Main loop (run forever)
while (true)
    %% 1.  Draw

    % Menu draws its contents into the scene
    menu.draw(scene)

    % simpleGameEngine draws the prepared scene data
    sge.drawScene(scene.bg, scene.fg);

    %% 2.  Get user input

    % Returns one of the widgets in a Pane in the menu. If no widget was
    %   clicked, returns 0
    clicked_widget = menu.next_clicked_widget(sge);

    %% 3.  Handle input

    if clicked_widget == text_1
        text_1.set_background(game.Sprites.RED); % add a red background to 
                                                 % the text
        text_1.set_white(true); % use white text, for contrast
    else
        text_1.set_background(false); % remove red background
        text_1.set_white(false); % use black text
    end
end