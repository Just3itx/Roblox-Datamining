-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:00:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local CoreGui = game:GetService("CoreGui")

local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local t = require(CorePackages.Packages.t)

local scriptParentParentParent = script.Parent.Parent.Parent

if require(scriptParentParentParent.Flags.FFlagTopBarDeprecateChatRodux) then
    return nil
end

local UpdateChatVisible = require(scriptParentParentParent.Actions.UpdateChatVisible)
local UpdateChatMessages = require(scriptParentParentParent.Actions.UpdateChatMessages)

local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local ChatSelector = require(RobloxGui.Modules.ChatSelector)

local GameSettings = UserSettings().GameSettings

local var1 = Roact.PureComponent:extend("ChatConnector")

var1.validateProps = t.strictInterface({ isSmallTouchScreen = t.boolean, updateChatVisible = t.callback, updateChatMessages = t.callback })

function var1.didMount(arg1)
    local chatVisible = GameSettings.ChatVisible
    if arg1.props.isSmallTouchScreen then
        chatVisible = false
    end

    ChatSelector:SetVisible(chatVisible)

    arg1.props.updateChatMessages(ChatSelector:GetMessageCount())
    arg1.props.updateChatVisible(ChatSelector:GetVisibility())

    arg1.chatVisibleConnection = ChatSelector.VisibilityStateChanged:connect(function(arg2)
        arg1.props.updateChatVisible(arg2)
    end)

    arg1.chatMessagesConnection = ChatSelector.MessagesChanged:connect(function(arg2)
        arg1.props.updateChatMessages(arg2)
    end)
end

function var1.render(_)
    return nil
end

function var1.willUnmount(arg1)
    arg1.chatVisibleConnection:disconnect()
    arg1.chatMessagesConnection:disconnect()
end

return RoactRodux.UNSTABLE_connect2(function(arg1) -- name: mapStateToProps
    return {
        isSmallTouchScreen = arg1.displayOptions.isSmallTouchDevice
    }
end, function(arg1) -- name: mapDispatchToProps
    return {
        updateChatVisible = function(arg2)
            return arg1(UpdateChatVisible(arg2))
        end,
        updateChatMessages = function(arg2)
            return arg1(UpdateChatMessages(arg2))
        end
    }
end)(var1)
