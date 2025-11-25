function scheduling(gm)    
    arguments
        gm (1, 1) %StudentLifeGame
    end

    % alias for spawning Text widgets
    Text = @spruiten.widgets.Text;

    scene = gm.scenes(gm.view);
    
    %% Assemble menu

    menu = spruiten.Menu();
    p_info = menu.Pane([1, 1], [10, 11]) ...
        .widget(Text([1, 1]).set_content('scheduler')) ...
        .widget(Text([3, 1]).set_content( ...
            [ ...
                'CLICK A  '
                'COURSE & '
                'PICK A   '
                'TIME SLOT'
                'ON RIGHT '
                'TO ADD IT'
            ] ...
        ));

    p_courses = menu.Pane([12, 1], [7, 11]);

    % names of our course, just for the loop below
    course_names = [
        "GENED1201"
        "ENGR 1181"
        "PHYS 1250"
        "CHEM 1210"
        "ENGR 1100"
    ];

    % a mapping of 'course name' -> text widget
    courses = dictionary();

    for i = 1:height(course_names)
        txt = p_courses.Text([i, 1]).set_content(course_names(i));
        courses(txt) = course_names(i);
            
    end

    %% Interaction variables setup
    course_selected = [];


    while (true)
        %% Draw
        
        menu.draw(scene);
        gm.draw();

        %% Handle user inputs

        % Get a reference to whatever the user has clicked (or the number 0 if
        %   they have not clicked on anything in particular)
        wid = menu.next_clicked_widget(gm.sge);

        if ( ...
            ismember('spruiten.Widget', superclasses(wid)) ...
            && isKey(courses, wid) ...
        )%&& ~isKey(courses)
            if ~isempty(course_selected)
                course_selected.set_background(0).set_white(false);
            end

            course_selected = ...
                wid.set_background(game.Sprites.RED).set_white(true);
        end
    end