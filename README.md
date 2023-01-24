# Array
Similar to Dictionary [https://github.com/Kumarion/Dictionary]
Only difference is its only for arrays.

Based off the array prototype in JavaScript. (Will see similar methods)

# Example
```lua
-- Init the array
local Numbers = Array({1, 2, 3, 4, 5});

-- Equivalent of:
local Numbers = {1, 2, 3, 4, 5};

-- Perform methods on the array
print(Numbers:sum()); -- Result: 15

-- Push
Numbers:push(6);
print(Numbers); -- Result: {1, 2, 3, 4, 5, 6}

-- Length
print(Numbers:length()); -- Result: 6

-- You get it..
```

Might not work fully as I'm still working on it.