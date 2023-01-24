local HttpService = game:GetService("HttpService");
local Array = {};

-- Array functions
local tblFind = table.find;

-- Array
setmetatable(Array, {
    __call = function(self, t)
        local newArray = t or {};
        setmetatable(newArray, {__index = Array});
        return newArray;
    end
})

-- Array methods
function Array:destroy()
	-- Destroy the array and remove the metatable
	-- They could clear the array and keep reusing it, OR they could clear the array and the metatable will never be garbage collected
	-- They can call :destroy if they know they won't be using it anymore
	setmetatable(self, nil);
end

function Array:sum()
	local sum = 0
	
	for i, v in ipairs(self) do
		if type(v) == "string" then
			continue
		end
		
		sum = sum + v
	end
	
	return sum
end

function Array:random()
	return self[math.random(1, #self)]
end

function Array:splice(start, deleteCount, ...)
	local newArray = {}
	
	for i = 1, start - 1 do
		table.insert(newArray, self[i])
	end
	
	for i = 1, select("#", ...) do
		table.insert(newArray, select(i, ...))
	end
	
	for i = start + deleteCount, #self do
		table.insert(newArray, self[i])
	end
	
	return setmetatable(newArray, {__index = Array})
end

function Array:shuffle()
	local newArray = {}
	
	for i, v in ipairs(self) do
		table.insert(newArray, v)
	end
	
	for i = #newArray, 2, -1 do
		local j = math.random(i)
		newArray[i], newArray[j] = newArray[j], newArray[i]
	end
	
	return setmetatable(newArray, {__index = Array})
end

function Array:map(fn)
	local newArray = {}
	
	for i, v in ipairs(self) do
		newArray[i] = fn(v)
	end
	
	return setmetatable(newArray, {__index = Array})
end

function Array:filter(fn)
	local newArray = {}
	
	for i, v in ipairs(self) do
		if fn(v) then
			table.insert(newArray, v)
		end
	end
	
	return setmetatable(newArray, {__index = Array})
end

function Array:find(target)
	return tblFind(self, target)
end

function Array:copyWithin(target, start, en)
	target = math.max(1, target + 1) -- Lua uses 1-based indexing
	start = start or 1
	en = en or #self
	
	for i = start, en do
		self[target + i - start - 1] = self[i]
	end
	
	return self
end

function Array:clone()
	local newArray = {}
	
	for i, v in ipairs(self) do
		newArray[i] = v
	end
	
	return setmetatable(newArray, {__index = Array})
end

function Array:every(fn)
	for i, v in ipairs(self) do
		if not fn(v) then
			return false
		end
	end
	
	return true
end

function Array:some(fn)
	for i, v in ipairs(self) do
		if fn(v) then
			return true
		end
	end
	
	return false
end

function Array:reduce(fn, initialValue)
	local accumulator = initialValue or self[1]
	local startIndex = initialValue and 1 or 2
	
	for i = startIndex, #self do
		accumulator = fn(accumulator, self[i], i, self)
	end
	
	return accumulator
end

function Array:reverse()
	local newArray = {}
	
	for i = #self, 1, -1 do
		table.insert(newArray, self[i])
	end
	
	return setmetatable(newArray, {__index = Array})
end

function Array:fill(value, start, en)
	start = start or 1
	en = en or #self
	
	for i = start, en do
		self[i] = value
	end
	
	return self
end

function Array:merge(otherTable)
	local newTable = {}
	
	for i, v in ipairs(self) do
		table.insert(newTable, v)
	end
	
	for i, v in ipairs(otherTable) do
		table.insert(newTable, v)
	end
	
	return setmetatable(newTable, {__index = Array})
end

function Array:concat()
	return table.concat(self, ",");
end

function Array:encode()
	return HttpService:JSONEncode(self);
end

function Array:decode(str)
	return HttpService:JSONDecode(str);
end

function Array:includes(value)
	for i, v in ipairs(self) do
		if (v == value) then
			return true
		end
	end
	
	return false
end

function Array:clear()
	-- fast method?
	for i = #self, 1, -1 do
		self[i] = nil
	end
end

function Array:shift()
	local first = self[1]
	
	for i = 1, #self - 1 do
		self[i] = self[i + 1]
	end
	
	self[#self] = nil
	return first
end

function Array:pop()
	-- fast method?
	local last = self[#self]
	self[#self] = nil
	
	return last
end

function Array:push(value)
	table.insert(self, value)
	return self
end

function Array:sort(cmp)
	table.sort(self, cmp)
	return self
end

function Array:fastRemove(i)
	local n = #self
	self[i] = self[n]
	self[n] = nil
end

function Array:isEmpty()
	return (#self == 0)
end

function Array:length()
	return #self
end

return Array