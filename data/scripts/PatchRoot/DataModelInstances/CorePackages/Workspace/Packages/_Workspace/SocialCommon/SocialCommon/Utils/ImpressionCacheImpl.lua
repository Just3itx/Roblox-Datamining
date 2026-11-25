-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T15:21:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppStorageService = game:GetService("AppStorageService")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

local SocialCommonParent = script:FindFirstAncestor("SocialCommon").Parent

local Cryo = require(SocialCommonParent.Cryo)

local function ImpressionCacheImpl(tbl1)
    local isKeyAvailableInEngine = tbl1.isKeyAvailableInEngine
    local dismissedValue = tbl1.dismissedValue
    local appStorageKey = tbl1.appStorageKey

    local var1 = tbl1.PlayersService or Players
    local var2 = tbl1.AppStorageService or AppStorageService

    local function getLocalUserId() -- Luacid: Inlined by compiler; 5 call sites recovered
        local localPlayer = var1.LocalPlayer
        if not (localPlayer and localPlayer.UserId and localPlayer.UserId > 0) then
            return nil
        end

        return tostring(localPlayer.UserId)
    end

    local function updateStoredValue(input) -- Luacid: Inlined by compiler; 1 call site recovered
        local success, result = pcall(function(): string
            return HttpService:JSONEncode(input)
        end)
        if success then
            var2:SetItem(appStorageKey, result)
            var2:Flush()
        end
    end

    local function getStoredValue(): {[any]: any}? -- Luacid: Inlined by compiler; 4 call sites recovered
        local item = var2:GetItem(appStorageKey) or ""

        local success, result = pcall(function()
            return HttpService:JSONDecode(item)
        end)

        return if success and type(result) == "table" then result else nil
    end

    local function setImpressionCountPerUser(localUserId: string, num1: number)
        local storedValue = getStoredValue()
        updateStoredValue((Cryo.Dictionary.join(storedValue or {}, { [localUserId] = num1 })))
    end

    local function getImpressionCountPerUser(localUserId: string): number -- Luacid: Inlined by compiler; 2 call sites recovered
        local storedValue = getStoredValue()
        return if storedValue and storedValue[localUserId] then tonumber(storedValue[localUserId]) or 0 else 0
    end

    local function setValue(num1: number) -- Luacid: Inlined by compiler; 2 call sites recovered
        local localUserId = getLocalUserId()

        if isKeyAvailableInEngine and localUserId then
            setImpressionCountPerUser(localUserId, num1)
        end
    end

    local function getValue() -- Luacid: Inlined by compiler; 1 call site recovered
        local localUserId = getLocalUserId()

        if isKeyAvailableInEngine and localUserId then
            return (getImpressionCountPerUser(localUserId))
        end
        return dismissedValue
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
return ImpressionCacheImpl
