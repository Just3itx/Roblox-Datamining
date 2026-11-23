-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:11:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent
local React = require(AppChatParent.React)

local Frame = require(AppChat.Components.Common.Frame)
local ChatAbuseReport = require(script.Parent.ChatAbuseReport)

local InputHandlers = require(AppChatParent.InputHandlers)
local _ReactFocusNavigation = require(AppChatParent.ReactFocusNavigation)
local FocusNavigationUtils = require(AppChatParent.FocusNavigationUtils)
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local AppFocusRoot = FocusNavigationUtils.AppFocusRoot
local FocusNavigationEventNameEnum = FocusNavigationUtils.FocusNavigationEventNameEnum

local function AbuseReportScreen(arg1)
    local navigation = arg1.navigation
    local conversationId = navigation.getParam("conversationId", nil)
    local participantId = navigation.getParam("participantId", nil)

    local customEventHandlers = React.useMemo(function()
        local result = {}
        result[FocusNavigationEventNameEnum.NavigateBack] = {
            handler = InputHandlers.onRelease(function(arg2)
                navigation.pop()
                arg2:cancel()
            end)
        }
        return result
    end, { navigation })

    local element = React.createElement(Frame, {
        horizontalAlignment = Enum.HorizontalAlignment.Center,
        verticalAlignment = Enum.VerticalAlignment.Center,
        Size = UDim2.new(1, 0, 1, 0)
    }, {
        constraint = React.createElement("UISizeConstraint", { MaxSize = Vector2.new(800, 450) }),
        padding = React.createElement("UIPadding", {
            PaddingTop = UDim.new(0, 12),
            PaddingBottom = UDim.new(0, 12),
            PaddingLeft = UDim.new(0, 12),
            PaddingRight = UDim.new(0, 12)
        }),
        abuseReportFlow = React.createElement(ChatAbuseReport, {
            conversationId = conversationId,
            participantId = participantId,
            onAbandon = navigation.pop,
            onComplete = navigation.pop
        })
    })

    return React.createElement(AppFocusRoot, {
        surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.PopUp,
        isIsolated = true,
        isAutoFocusRoot = true,
        isFocusable = true,
        customEventHandlers = customEventHandlers
    }, { element })
end

return AbuseReportScreen
