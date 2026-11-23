-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:20:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent
local React = require(AppChatParent.React)
local useDispatch = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useDispatch
local ThirdPartyChatSettingsLoaded = require(AppChat.Actions.ThirdPartyChatSettingsLoaded)

local function AppChatRemoveThirdPartyRestriction()
    local var1 = useDispatch()
    React.useEffect(function()
        if var1 then
            var1(ThirdPartyChatSettingsLoaded(Enum.ChatRestrictionStatus.NotRestricted))
        end
    end, { var1 })
    return nil
end

return AppChatRemoveThirdPartyRestriction
