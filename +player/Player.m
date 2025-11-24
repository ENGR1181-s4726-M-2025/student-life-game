classdef Player < handle
    properties
        % Pending tasks the player must accomplish
        tasks (1, :);

        %% Player stats
        % note: GPA is derived from grades (use Player.gpa())

        % Physical health (from 0 to 1)
        health = 0.5;

        % Classes & grades in each (name -> from 0 to 4, representing F D C B A)
        classes (1, 1) dictionary = dictionary();
    end

    methods

    end
end