-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T13:21:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local Array = require(scriptParentParent.LuauPolyfill).Array

local Headers = {}
Headers.__index = Headers

function Headers.new(arg1)
    local result = {}
    local tbl2

    if Array.isArray(arg1) then
        tbl2 = {}
        for _, value in arg1 do
            tbl2[value[1]] = value[2]
        end
    else
        tbl2 = arg1 or {}
    end

    result.headerList = tbl2
    result.guard = "none"

    setmetatable(result, Headers)
    return result
end

function Headers:append(str1: string, str2: string)
    if self.guard == "immutable" then
        error("TypeError: tried to append header to immutable Headers object")
    end

    self.headerList[str1] = str2
end

function Headers:delete(str1: string)
    if self.guard == "immutable" then
        error("TypeError: tried to delete key on immutable Headers object")
    end

    if not self:has(str1) then
        return
    end

    self.headerList[str1] = nil
end

function Headers:get(str1: string)
    return self.headerList[str1]
end

function Headers:has(str1: string): boolean
    return self.headerList[str1] ~= nil
end

function Headers:set(str1: string, str2: string)
    if self.guard == "immutable" then
        error("TypeError: tried to set key on immutable Headers object")
    end
    self.headerList[str1] = str2
end

function Headers:__iter()
    return next, self.headerList
end

return { Headers = Headers }
