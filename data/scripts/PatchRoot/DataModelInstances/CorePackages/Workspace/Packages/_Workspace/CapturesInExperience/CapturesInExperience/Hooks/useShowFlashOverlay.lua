-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:00:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppStorageService = game:GetService("AppStorageService")

local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local RoactUtils = require(scriptParentParentParent.RoactUtils)

local Constants = require(scriptParentParent.Constants)

local useSelector = RoactUtils.Hooks.RoactRodux.useSelector

local function func1()
    pcall(function()
        AppStorageService:SetItem(Constants.LastFlashOccurrenceTsLocalStorageKey, tostring(DateTime.now().UnixTimestampMillis))

        AppStorageService:Flush()
    end)
end

return function(arg1)
    local var1 = arg1 or AppStorageService

    if not useSelector(function(arg2)
        return arg2[Constants.RoduxKey].IsOverlayFlashActive
    end) then
        return false, func1
    end

    local success, result = pcall(function()
        return var1:GetItem(Constants.LastFlashOccurrenceTsLocalStorageKey)
    end)

    if not success then
        return false, func1
    end

    local var2 = tonumber(result)

    if var2 == nil then
        return false, func1
    end

    assert(var2 ~= nil, "lastFlashOccurrenceTs cannot be nil")

    if DateTime.now().UnixTimestampMillis - var2 < 500 then
        return false, func1
    end

    return true, func1
end
