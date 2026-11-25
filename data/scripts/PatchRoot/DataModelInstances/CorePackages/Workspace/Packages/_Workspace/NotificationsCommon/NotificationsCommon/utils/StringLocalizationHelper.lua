-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:21:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local React = require(scriptParentParentParent.React)
local LocalizationRoactContext = require(scriptParentParentParent.Localization).LocalizationRoactContext
local useLocalization = require(scriptParentParentParent.Localization).Hooks.useLocalization
local NotificationsCommon = script:FindFirstAncestor("NotificationsCommon")
local _type = require(NotificationsCommon.type)

local RobloxTranslator = require(scriptParentParentParent.RobloxTranslator)

return {
    getLocalizedStrings = function(arg1)
        if React.useContext(LocalizationRoactContext) ~= nil then
            return useLocalization(arg1)
        end

        local result = ({})
        for k, value in pairs(arg1) do
            local success, result2 = pcall(function()
                return RobloxTranslator:FormatByKey(value)
            end)
            if success then
                result[k] = result2
            else
                result[k] = value
            end
        end
        return result
    end
}
