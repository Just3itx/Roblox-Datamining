-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:50:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommonParent = script:FindFirstAncestor("AvatarExperienceCommon").Parent
local Dash = require(AvatarExperienceCommonParent.Dash)

local getTryOnItemReducerKey = require(script.Parent.getTryOnItemReducerKey)

local function findItemInTryOnItems(tbl1, arg1, str1: string?)
    if str1 then
        return tbl1[getTryOnItemReducerKey(tostring(arg1), str1)]
    end

    return Dash.find(tbl1, function(arg2): boolean
        return tostring(arg2.itemId) == tostring(arg1)
    end)
end

return findItemInTryOnItems
