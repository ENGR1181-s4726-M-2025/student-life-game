classdef Set
    properties
        val
    end

    methods
        function self = Set(val)
            self.val = val;
        end

        function eq = isequal(self, rhs)
            % i think an O(n*log(n)) solution exists by sorting both arrays
            % before comparing them but I've just realized we don't need
            % this type anyway

            eq = 0;
        end
    end
end