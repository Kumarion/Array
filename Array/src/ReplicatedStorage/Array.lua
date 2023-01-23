local HttpService = game:GetService("HttpService");
local array = {};

function array.new(t)
	local newArray = t or {};
	setmetatable(newArray, {__index = array});
	return newArray;
end

function array:sum()
	local sum = 0
	
	for i, v in ipairs(self) do
		if type(v) == "string" then
			continue
		end
		
		sum = sum + v
	end
	
	return sum
end

function array:map(fn)
	local newArray = {}
	
	for i, v in ipairs(self) do
		newArray[i] = fn(v)
	end
	
	return setmetatable(newArray, {__index = array})
end

function array:filter(fn)
	local newArray = {}
	
	for i, v in ipairs(self) do
		if fn(v) then
			table.insert(newArray, v)
		end
	end
	
	return setmetatable(newArray, {__index = array})
end

function array:find(target)
	return table.find(self, target)
end

function array:copyWithin(target, start, en)
	target = math.max(1, target + 1) -- Lua uses 1-based indexing
	start = start or 1
	en = en or #self
	
	for i = start, en do
		self[target + i - start - 1] = self[i]
	end
	
	return self
end

function array:clone()
	local newArray = {}
	
	for i, v in ipairs(self) do
		newArray[i] = v
	end
	
	return setmetatable(newArray, {__index = array})
end

function array:every(fn)
	for i, v in ipairs(self) do
		if not fn(v) then
			return false
		end
	end
	
	return true
end

function array:some(fn)
	for i, v in ipairs(self) do
		if fn(v) then
			return true
		end
	end
	
	return false
end

function array:reduce(fn, initialValue)
	local accumulator = initialValue or self[1]
	local startIndex = initialValue and 1 or 2
	
	for i = startIndex, #self do
		accumulator = fn(accumulator, self[i], i, self)
	end
	
	return accumulator
end

function array:reverse()
	local newArray = {}
	
	for i = #self, 1, -1 do
		table.insert(newArray, self[i])
	end
	
	return setmetatable(newArray, {__index = array})
end

function array:fill(value, start, en)
	start = start or 1
	en = en or #self
	
	for i = start, en do
		self[i] = value
	end
	
	return self
end

function array:merge(otherTable)
	local newTable = {}
	
	for i, v in ipairs(self) do
		table.insert(newTable, v)
	end
	
	for i, v in ipairs(otherTable) do
		table.insert(newTable, v)
	end
	
	return setmetatable(newTable, {__index = array})
end

function array:concat()
	return table.concat(self, ",");
end

function array:encode()
	return HttpService:JSONEncode(self);
end

function array:decode(str)
	return HttpService:JSONDecode(str);
end

function array:shift()
	local first = self[1]
	
	for i = 1, #self - 1 do
		self[i] = self[i + 1]
	end
	
	self[#self] = nil
	return first
end

function array:pop()
	local last = self[#self]
	self[#self] = nil
	
	return last
end

function array:push(value)
	table.insert(self, value)
	return self
end

function array:sort(cmp)
	table.sort(self, cmp)
	return self
end

function array:length()
	return #self
end

return array