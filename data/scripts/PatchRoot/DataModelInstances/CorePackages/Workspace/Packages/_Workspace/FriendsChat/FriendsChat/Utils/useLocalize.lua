-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:31:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsChatParent = script:FindFirstAncestor("FriendsChat").Parent

local React = require(FriendsChatParent.React)
local Localization = require(FriendsChatParent.Localization)
local LocalizationRoactContext = Localization.LocalizationRoactContext
local localizeStrings = Localization.localizeStrings

local function useLocalize()
    local var1 = React.useContext(LocalizationRoactContext)
    return React.useCallback(function(value): string
        if var1 == nil then
            return ""
        end
        local success, result = pcall(function()
            return localizeStrings(var1, { value = value }).value
        end)
        return if success and typeof(result) == "string" then result else ""
    end, { var1 })
end

return useLocalize
