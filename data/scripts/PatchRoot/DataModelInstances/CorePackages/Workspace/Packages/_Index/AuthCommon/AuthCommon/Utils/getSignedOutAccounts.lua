-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:50:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommon = script:FindFirstAncestor("AuthCommon")
local AppStorageUtilities = require(AuthCommon.Utils.AppStorageUtilities)
local _PreviousAccountEntry = require(AuthCommon.Utils.PreviousAccountEntry)
local AuthCommonParent = AuthCommon.Parent
local Cryo = require(AuthCommonParent.Cryo)

local GetFFlagShowInvoluntarilySignedOutAccounts = require(AuthCommonParent.SharedFlags).GetFFlagShowInvoluntarilySignedOutAccounts
local FFlagFixPreviousAccountsListEntries = require(AuthCommonParent.SharedFlags).FFlagFixPreviousAccountsListEntries

local function subarray<T>(tbl1: {T}, num1: number, num2: number): {T} -- Luacid: Inlined by compiler; 1 call site recovered
    local result = {}
    for i = num1, num2 do
        table.insert(result, tbl1[i])
    end
    return result
end

local function getSignedOutAccounts(num1: number, tbl1, bool1: boolean?)
    local previousAccountsList = AppStorageUtilities.getPreviousAccountsList()
    local fFlagShowInvoluntarilySignedOutAccounts = GetFFlagShowInvoluntarilySignedOutAccounts()

    local var1 = Cryo.Dictionary.values(previousAccountsList)
    local var2 = Cryo.List.filter(var1, function(arg1)
        if FFlagFixPreviousAccountsListEntries then
            local userId = arg1.userId
            if userId == nil or userId == "" then
                return false
            end
        end
        if not fFlagShowInvoluntarilySignedOutAccounts then
            return arg1.signOutTimestamp
        end

        local bool2 = not (tbl1 == nil or arg1.userId == nil) and tbl1[arg1.userId] == true
        local bool3 = bool1 == true and arg1.showInAccountPicker == false
        return not (bool2 or bool3)
    end)

    local var3 = if fFlagShowInvoluntarilySignedOutAccounts then Cryo.List.sort(var2, function(arg1, arg2): boolean
        return (arg1.signOutTimestamp or arg1.signInTimestamp or 0) > (arg2.signOutTimestamp or arg2.signInTimestamp or 0)
    end) else Cryo.List.sort(var2, function(arg1, arg2): boolean
        return arg1.signOutTimestamp > arg2.signOutTimestamp
    end)

    if not var3 then
        return {}
    end

    local num2 = #var3
    return subarray(var3, 1, math.min(num1, num2))
end

return getSignedOutAccounts
