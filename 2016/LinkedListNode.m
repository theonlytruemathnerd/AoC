classdef LinkedListNode < handle
    properties
        data double
        next LinkedListNode
    end

    methods
        function obj = LinkedListNode(data,mx)
            obj.data = data;
            if data < mx
                obj.next = LinkedListNode(data+1,mx);
            end
        end

        function obj = removeNext(obj)
            obj.next = obj.next.next;
        end

    end

end