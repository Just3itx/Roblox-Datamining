-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T19:41:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameJoinCard = script:FindFirstAncestor("GameJoinCard")
local GameJoinCardParent = GameJoinCard.Parent

local Foundation = require(GameJoinCardParent.Foundation)
local SocialCommon = require(GameJoinCardParent.SocialCommon)
local RobloxAppEnums = require(GameJoinCardParent.RobloxAppEnums)
local UserCtaAction = require(GameJoinCardParent.UserCtaCommon).Enums.UserCtaAction

local ButtonVariant = Foundation.Enums.ButtonVariant
local InputSize = Foundation.Enums.InputSize
local ChatEntryPointNames = SocialCommon.Enums.ChatEntryPointNames
local EnteredChatFromEntryPoint = SocialCommon.Actions.EnteredChatFromEntryPoint
local NotificationType = RobloxAppEnums.NotificationType

local FFlagGameJoinCardChatEntryPoint = require(GameJoinCard.Flags.FFlagGameJoinCardChatEntryPoint)
local GameJoinCardButtonAction = require(GameJoinCard.Analytics.AnalyticsConstants).GameJoinCardButtonAction
local useGameJoinCardAnalytics = require(GameJoinCard.Analytics.useGameJoinCardAnalytics)
local _Types = require(script.Parent.Types)
local getTelemetryFields = require(script.Parent.getTelemetryFields)

local module = {}
module[UserCtaAction.Chat] = function(arg1)
    return {
        id = UserCtaAction.Chat,
        variant = ButtonVariant.Standard,
        inputSize = InputSize.Medium,
        width = UDim.new(1, 0),
        text = arg1.localized[UserCtaAction.Chat],
        onActivated = function()
            if arg1.userId == "" then
                return
            end
            useGameJoinCardAnalytics.logGameJoinCardButtonEvent(GameJoinCardButtonAction.Chat, getTelemetryFields(arg1))
            if FFlagGameJoinCardChatEntryPoint then
                arg1.dispatch(EnteredChatFromEntryPoint(ChatEntryPointNames.GameJoinCard))
            end
            arg1.guiService:BroadcastNotification(arg1.userId, NotificationType.LAUNCH_CONVERSATION)
        end
    }
end

return module
