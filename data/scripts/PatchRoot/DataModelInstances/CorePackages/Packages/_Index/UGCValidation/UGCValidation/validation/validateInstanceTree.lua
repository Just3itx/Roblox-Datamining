-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:41:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local Analytics = require(scriptParentParent.Analytics)
local Constants = require(scriptParentParent.Constants)
local validateWithSchema = require(scriptParentParent.util.validateWithSchema)
local _Types = require(scriptParentParent.util.Types)

local function validateInstanceTree(arg1, arg2, arg3)
    local var1 = validateWithSchema(arg1, arg2, arg3)
    if var1.success == false then
        Analytics.reportFailure(Analytics.ErrorType.validateInstanceTree, nil, arg3)
        return false, { "Detected the following error(s): " .. var1.message }
    end

    local tbl1 = {}
    if Constants.BANNED_NAMES[arg2.Name] then
        table.insert(tbl1, string.format("%s has an invalid name", arg2:GetFullName()))
    end

    for _, descendant in pairs(arg2:GetDescendants()) do
        for _, value in pairs(Constants.BANNED_CLASS_NAMES) do
            if descendant:IsA(value) then
                table.insert(tbl1, string.format("%s is of type %s which is not allowed", descendant:GetFullName(), value))
            end
        end

        if Constants.BANNED_NAMES[descendant.Name] then
            table.insert(tbl1, string.format("%s has an invalid name", descendant:GetFullName()))
        end
    end

    if not (#tbl1 > 0) then
        return true
    end

    Analytics.reportFailure(Analytics.ErrorType.validateInstanceTree_InvalidDescendants, nil, arg3)
    return false, tbl1
end

return validateInstanceTree
