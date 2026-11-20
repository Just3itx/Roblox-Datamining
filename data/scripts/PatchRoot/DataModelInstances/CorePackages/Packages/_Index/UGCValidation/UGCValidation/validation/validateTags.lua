-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:50:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CollectionService = game:GetService("CollectionService")

local scriptParentParent = script.Parent.Parent
local Analytics = require(scriptParentParent.Analytics)

local _Types = require(scriptParentParent.util.Types)

local function validateTags(arg1, arg2)
    local descendants = arg1:GetDescendants()
    table.insert(descendants, arg1)

    local tbl1 = {}
    for _, descendant in ipairs(descendants) do
        if #CollectionService:GetTags(descendant) > 0 then
            table.insert(tbl1, descendant)
        end
    end

    if not (#tbl1 > 0) then
        return true
    end

    Analytics.reportFailure(Analytics.ErrorType.validateTags, nil, arg2)

    return false, {}
end

return validateTags
