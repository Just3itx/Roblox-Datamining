-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:20:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppStorageService = game:GetService("AppStorageService")
local Players = game:GetService("Players")

local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local Dash = require(scriptParentParentParent.Dash)

local Constants = require(scriptParentParent.Constants)
local EventNames = require(scriptParentParent.Analytics.EventNames)
local getLocalUserId = require(scriptParentParent.Utils.getLocalUserId)
local getUserIdsFromString = require(scriptParentParent.Utils.getUserIdsFromString)

return function(arg1)
    local success, result = pcall(function(): string
        return AppStorageService:GetItem(Constants.DeleteWarningModalOptOutStorageKey)
    end)

    if not success then
        return
    end

    local userIdsFromString = getUserIdsFromString(result)
    userIdsFromString[getLocalUserId(Players) or ""] = true
    local str1 = table.concat(Dash.keys(userIdsFromString), ",")

    local success2, _result = pcall(function()
        AppStorageService:SetItem(Constants.DeleteWarningModalOptOutStorageKey, str1)
        AppStorageService:Flush()
    end)

    if not success2 then
        return
    end

    arg1.fireEvent(EventNames.CapturesDeleteWarningModalOptedOut)
end
