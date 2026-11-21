-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:00:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommon = script:FindFirstAncestor("AuthCommon")
local AppStorageUtilities = require(AuthCommon.Utils.AppStorageUtilities)
local AuthCommonParent = AuthCommon.Parent
local Cryo = require(AuthCommonParent.Cryo)
local num1 = game:DefineFastInt("DefaultMaxPruneAccounts", 50)
local _PreviousAccountEntry = require(AuthCommon.Utils.PreviousAccountEntry)

local function prunePreviousAccountsList(): boolean
    local previousAccountsList = AppStorageUtilities.getPreviousAccountsList()
    local var1 = Cryo.Dictionary.values(previousAccountsList)
    local var2 = Cryo.List.filter(var1, function(arg1): boolean
        return arg1.signOutTimestamp == nil
    end)
    local var3 = Cryo.List.filter(var1, function(arg1): boolean
        return arg1.signOutTimestamp ~= nil
    end)

    if #var3 <= num1 then
        return true
    end

    local var4 = Cryo.List.sort(var3, function(arg1, arg2): boolean
        return arg1.signOutTimestamp > arg2.signOutTimestamp
    end)

    local tbl1 = {}
    local num2 = 0

    for _, value in ipairs(var4) do
        if num1 <= num2 then
            break
        end

        if value.userId then
            tbl1[value.userId] = value
        end
        num2 += 1
    end

    for _, value in ipairs(var2) do
        if value.userId then
            tbl1[value.userId] = value
        end
    end
    AppStorageUtilities.setPreviousAccountsList(tbl1)
    return true
end

return prunePreviousAccountsList
