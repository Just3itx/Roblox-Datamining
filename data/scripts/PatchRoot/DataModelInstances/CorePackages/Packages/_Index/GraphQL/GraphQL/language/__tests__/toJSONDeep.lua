-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:51:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local Array = require(scriptParentParentParentParent.LuauPolyfill).Array

local isObjectLike = require(scriptParentParentParent.jsutils.isObjectLike).isObjectLike

local function toJSONDeep(arg1)
    if not isObjectLike(arg1) then
        return arg1
    end

    if type(arg1.toJSON) == "function" then
        return arg1:toJSON()
    end

    if Array.isArray(arg1) then
        return Array.map(arg1, toJSONDeep)
    end

    local result = ({})

    for k, value in pairs(arg1) do
        result[k] = toJSONDeep(value)
    end

    return result
end

return { toJSONDeep = toJSONDeep }
