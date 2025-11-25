classdef Time < handle
    properties(Constant)
        SECS_MIN = uint32(60);
        MINS_HOUR = uint32(60);
        HOURS_DAY = uint32(24);

        SECS_HOUR = game.Time.SECS_MIN * game.Time.MINS_HOUR;
        SECS_DAY = game.Time.SECS_HOUR * game.Time.HOURS_DAY;

        MINS_DAY = game.Time.MINS_HOUR * game.Time.HOURS_DAY;
    end

    properties
        % Time of day, in seconds since midnight on Day 1.
        % Does not reset at midnight of each successive day.
        s (1, 1) uint32 {mustBeInteger, mustBeNonnegative} = ...
            8 * game.Time.SECS_HOUR;
    end

    methods

        % return the current time as a char vector like 'HH:MM'
        function current_time_chars = print_time(self)
            arguments
                self (1, 1) game.Time
            end
            [hrs, mins] = self.hms();
            current_time_chars = char(sprintf("%02d:%02d", hrs, mins));
        end

        % return the current time as a thriplet [hours, minutes, seconds]
        function [hrs, mins, secs] = hms(self)
            arguments
                self (1, 1) game.Time
            end

            hrs = mod(idivide(self.s, game.Time.SECS_HOUR), game.Time.HOURS_DAY);
            mins = mod(idivide(self.s, game.Time.SECS_MIN), game.Time.MINS_HOUR);
            secs = mod(self.s, game.Time.SECS_MIN);
        end

        % step time by some seconds
        function step(self, secs)
            arguments
                self (1, 1) game.Time
                secs (1, 1) uint32
            end

            self.s = self.s + secs;
        end

    end
end