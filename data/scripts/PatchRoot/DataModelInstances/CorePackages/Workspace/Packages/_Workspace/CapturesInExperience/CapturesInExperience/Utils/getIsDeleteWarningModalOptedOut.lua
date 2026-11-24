-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:11:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppStorageService = game:GetService("AppStorageService")
local Players = game:GetService("Players")

local scriptParentParent = script.Parent.Parent

local Constants = require(scriptParentParent.Constants)
local getLocalUserId = require(scriptParentParent.Utils.getLocalUserId)
local getUserIdsFromString = require(scriptParentParent.Utils.getUserIdsFromString)

return function(): boolean
    local success, result = pcall(function(): string
        return AppStorageService:GetItem(Constants.DeleteWarningModalOptOutStorageKey)
    end)

    return not not (success and result ~= "" and getUserIdsFromString(result)[getLocalUserId(Players) or ""])
end
