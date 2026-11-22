-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:30:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCommon = script:FindFirstAncestor("MomentsCommon")

local MomentsLocalStorage = require(MomentsCommon.Storage.MomentsLocalStorage)
local MomentsLocalStorageKeys = require(MomentsCommon.Storage.MomentsLocalStorageKeys)
local Players = game:GetService("Players")

local CoachmarkImpressions = MomentsLocalStorageKeys.CoachmarkImpressions

local function createCoachmarkImpressionCache(tbl1)
    local dismissedValue = tbl1.dismissedValue
    local coachmarkId = tbl1.coachmarkId

    local var1 = tbl1.PlayersService or Players
    local var2 = tbl1.localStorage or MomentsLocalStorage

    local function getLocalUserId() -- Luacid: Inlined by compiler; 3 call sites recovered
        local localPlayer = var1.LocalPlayer
        if not (localPlayer and localPlayer.UserId and localPlayer.UserId > 0) then
            return nil
        end

        return tostring(localPlayer.UserId)
    end

    local function getStoredObject() -- Luacid: Inlined by compiler; 1 call site recovered
        local field = var2.getField(CoachmarkImpressions)
        return if type(field) == "table" then field else {}
    end

    local function setValue(num1: number)
        local localUserId = getLocalUserId()

        if not localUserId then
            return
        end

        local storedObject = getStoredObject()
        local tbl2 = storedObject[localUserId]
        if type(tbl2) ~= "table" then
            tbl2 = {}
            storedObject[localUserId] = tbl2
        end
        tbl2[coachmarkId] = num1
        var2.setField(CoachmarkImpressions, storedObject)
    end

    local function getValue() -- Luacid: Inlined by compiler; 1 call site recovered
        local localUserId = getLocalUserId()

        if not localUserId then
            return dismissedValue
        end

        local field = var2.getField(CoachmarkImpressions)
        local var3 = (type(field) ~= "table" and {} or field)[localUserId]

        if type(var3) ~= "table" then
            return 0
        end
        return tonumber(var3[coachmarkId]) or 0
    end

    return {
        getValue = getValue,
        incrementValue = function()
            setValue(getValue() + 1)
        end,
        dismissValue = function()
            setValue(dismissedValue)
        end
    }
end
return createCoachmarkImpressionCache
