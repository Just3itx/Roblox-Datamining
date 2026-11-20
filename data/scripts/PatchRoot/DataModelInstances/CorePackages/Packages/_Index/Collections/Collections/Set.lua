-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T02:41:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local __DEV__ = _G.__DEV__
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent

local inspect = require(scriptParent.inspect)
local isArray = require(scriptParent.Array.isArray)
local forEach = require(scriptParent.Array.forEach)
local fromString = require(scriptParent.Array.from.fromString)

local _ES7Types = require(scriptParentParent.ES7Types)

local module = {
    __iter = function(arg1)
        return next, arg1._array
    end,
    __tostring = function(arg1)
        local str1 = "Set "
        if #arg1._array > 0 then
            str1 ..= "(" .. tostring(#arg1._array) .. ") "
        end
        return str1 .. inspect(arg1._array)
    end
}

module.__index = module

function module.new(arg1)
    local _map = ({})
    local var1

    if arg1 == nil then
        var1 = {}
    else
        local string2 = nil

        if typeof(arg1) == "table" then
            if isArray(arg1) then
                string2 = table.clone(arg1)
            else
                local var2 = getmetatable(arg1)
                if var2 and rawget(var2, "__iter") then
                    string2 = arg1
                elseif __DEV__ then
                    error("cannot create array from an object-like table")
                end
            end
        elseif typeof(arg1) == "string" then
            string2 = fromString(arg1)
        else
            error(("cannot create array from value of type `%s`"):format(typeof(arg1)))
        end

        if string2 then
            var1 = table.create(#string2)
            for _, value in string2 do
                if not _map[value] then
                    _map[value] = true
                    table.insert(var1, value)
                end
            end
        else
            var1 = {}
        end
    end

    return (setmetatable({ size = #var1, _map = _map, _array = var1 }, module))
end

function module:add(arg1)
    if not self._map[arg1] then
        self.size += 1
        self._map[arg1] = true
        table.insert(self._array, arg1)
    end
    return self
end

function module:clear()
    self.size = 0
    table.clear(self._map)
    table.clear(self._array)
end

function module:delete(arg1): boolean
    if not self._map[arg1] then
        return false
    end

    self.size -= 1
    self._map[arg1] = nil
    local var1 = table.find(self._array, arg1)
    if var1 then
        table.remove(self._array, var1)
    end
    return true
end

function module:forEach(arg1, arg2)
    if typeof(arg1) ~= "function" then
        error("callback is not a function")
    end

    forEach(self._array, function(arg3)
        if arg2 ~= nil then
            arg1(arg2, arg3, arg3, self)
            return
        end
        arg1(arg3, arg3, self)
    end)
end

function module:has(arg1): boolean
    return self._map[arg1] ~= nil
end

function module:ipairs()
    if __DEV__ then
        warn(
            debug.traceback(
                "`for _,_ in mySet:ipairs() do` is deprecated and will be removed in a future release, please use `for _,_ in mySet do` instead\n",
                2
            )
        )
    end
    return ipairs(self._array)
end

return module
