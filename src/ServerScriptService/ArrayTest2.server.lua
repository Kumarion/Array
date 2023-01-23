local Array = require(game.ReplicatedStorage.Array)
local myArray = Array();
table.insert(myArray, "H");
table.insert(myArray, "He");
table.insert(myArray, "Hel");
table.insert(myArray, "Hello");

-- filtering a table?
local filteredArray = myArray:filter(function(value)
	return value == "Hello"
end)

print(filteredArray)

-- concatenation
local concatenatedString = myArray:reduce(function(acc, cur) return acc .. cur end)
print(concatenatedString)

-- Normal table methods work on it
print(table.find(myArray, "H"))

-- Removing an element
table.remove(myArray, 1); -- should remove H
print(myArray)

-- reversing the array
print(myArray:reverse())

-- make a new array and merge with another
local otherTable = {4, 5, 6}
-- use a new table
local newArray = myArray:merge(otherTable)
print(newArray) -- Output: {"He", "Hel", "Hello", 4, 5, 6}

-- reverse it
print(newArray:reverse())

-- using shift
local first = newArray:shift()
print(first) -- Output: He
print(newArray) -- Output: {"Hel", "Hello", 4, 5, 6}

-- binary search
local indexOfSearchedValue = newArray:find("Hello")
print(indexOfSearchedValue)