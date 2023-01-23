local Array = require(game.ReplicatedStorage.Array)
local Eggs = Array.new({
	{Egg = "Egg1", Price = 5},
	{Egg = "Egg2", Price = 2},
	{Egg = "Egg3", Price = 4},
	{Egg = "Egg4", Price = 3},
	{Egg = "Egg5", Price = 100},
})

-- Sort
local LeastToGreatest = Eggs:sort(function(a, b)
	return (a.Price < b.Price);
end)

print(LeastToGreatest);

-- Push (like table.insert)
Eggs:push({Egg = "Egg6", Price = 200});
print(Eggs);

-- Pop
local PoppedValue = Eggs:pop();
print("Popped value", PoppedValue)
print(Eggs);

-- Concat
local Encoded = Eggs:encode();
print(Encoded)

-- Some
local NumbersArray = Array.new({1, 2, 3, 4, 5});
local isEven = function(num) 
	return (num % 2 == 0);
end
print(NumbersArray:some(isEven)); -- true

-- Length
print(NumbersArray:length())