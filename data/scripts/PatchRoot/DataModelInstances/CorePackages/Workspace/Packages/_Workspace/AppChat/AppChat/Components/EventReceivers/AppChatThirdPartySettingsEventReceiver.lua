-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:20:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent
local React = require(AppChatParent.React)
local Responsive = require(AppChatParent.Responsive)
local useDispatch = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useProperty = require(AppChatParent.GuiObjectUtils).useProperty
local ThirdPartyChatSettingsLoaded = require(AppChat.Actions.ThirdPartyChatSettingsLoaded)
local ThirdPartyUserService = game:GetService("ThirdPartyUserService")

local function AppChatThirdPartySettingsEventReceiver()
    local var1 = useDispatch()
    local var2 = useProperty(ThirdPartyUserService, "FriendCommunicationRestrictionStatus")
    local var3 = Responsive.usePreferredInput()
    React.useEffect(function()
        if not var1 or not var2 then
            return
        end

        local var4 = var2

        if var3 ~= Responsive.Input.Directional and var2 == Enum.ChatRestrictionStatus.Unknown then
            var4 = Enum.ChatRestrictionStatus.NotRestricted
        end
        var1(ThirdPartyChatSettingsLoaded(var4))
    end, { var1, var2, var3 })
    return nil
end

return AppChatThirdPartySettingsEventReceiver
