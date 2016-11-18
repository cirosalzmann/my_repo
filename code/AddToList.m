function List = AddToList(currList, Value)
    newList = zeros(1, length(currList));
    
    for i = 1:length(currList)
       newList(i) = currList(i); 
    end
    newList(length(currList) + 1) = Value;
    List = newList;
end
