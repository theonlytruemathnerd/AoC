classdef LinkedList2017Day17 < handle
    properties
        value double
        next LinkedList2017Day17
    end

    methods
        function obj = LinkedList2017Day17(value)
            obj.value = value;
        end

        function insertAfter(obj, value)
            % fprintf('inserting %d after %d\n',value,obj.value)
            newNode = LinkedList2017Day17(value);
            newNode.next = obj.next;
            obj.next = newNode;
        end
    end
end