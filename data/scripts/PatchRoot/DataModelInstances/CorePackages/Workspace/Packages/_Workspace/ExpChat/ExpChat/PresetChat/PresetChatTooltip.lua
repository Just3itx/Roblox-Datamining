-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:11:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent

local React = require(ExpChatParent.React)
local SignalsReact = require(ExpChatParent.SignalsReact)

local Foundation = require(ExpChatParent.Foundation)
local Coachmark = Foundation.Coachmark
local PopoverSide = Foundation.Enums.PopoverSide
local PopoverAlign = Foundation.Enums.PopoverAlign

local ExpChatShared = require(ExpChatParent.ExpChatShared)
local FFlagExpChatPresetChatEnabled = ExpChatShared.Flags.FFlagExpChatPresetChatEnabled
local FFlagExpChatUseUnifiedTooltipStore = ExpChatShared.Flags.FFlagExpChatUseUnifiedTooltipStore
local FFlagExpChatPresetFullWidthButtonFixes = require(ExpChat.Flags.FFlagExpChatPresetFullWidthButtonFixes)

local Constants = require(ExpChat.PresetChat.Constants)
local Localization = require(ExpChat.Localization)
local GetChatTooltipStore = require(ExpChat.Stores.GetChatTooltipStore)
local useChatTooltipLifecycle = require(ExpChat.ChatWindow.UI.useChatTooltipLifecycle)

return React.memo(function(tbl1) -- name: PresetChatTooltip
    if not (FFlagExpChatPresetChatEnabled and FFlagExpChatUseUnifiedTooltipStore) then
        return React.createElement(React.Fragment, nil, tbl1.children)
    end

    local chatTooltipStore = GetChatTooltipStore(false)
    local var1 = SignalsReact.useSignalState(chatTooltipStore.getShouldShow("PresetChatTooltip"))

    local var2 = useChatTooltipLifecycle({ tooltipKey = "PresetChatTooltip", targetTextChannel = tbl1.targetTextChannel })

    local var3 = Localization.useLocalization({
        headerText = "CoreScripts.TextChat.Tooltip.QuickWords.Header",
        bodyText = "CoreScripts.TextChat.Tooltip.QuickWords.Body"
    })

    local onClose = React.useCallback(function()
        var2.onDismiss()

        ExpChatShared.Analytics:TelemetryLogEvent(
            ExpChatShared.Analytics.ExpChatPresetActionConfig,
            {
                event_type = Constants.Analytics.EventTypes.Dismiss,
                component = Constants.Analytics.Components.PresetTooltip
            },
            ExpChatShared.Analytics.DefaultStandardizedFields
        )
    end, { var2.onDismiss })

    React.useEffect(function()
        if var1 then
            ExpChatShared.Analytics:TelemetryLogEvent(
                ExpChatShared.Analytics.ExpChatPresetActionConfig,
                {
                    event_type = Constants.Analytics.EventTypes.Show,
                    component = Constants.Analytics.Components.PresetTooltip
                },
                ExpChatShared.Analytics.DefaultStandardizedFields
            )
        end
    end, { var1 })

    if not var1 then
        return React.createElement(React.Fragment, nil, tbl1.children)
    elseif FFlagExpChatPresetFullWidthButtonFixes and tbl1.anchorRef ~= nil then
        return React.createElement(
            React.Fragment,
            nil,
            tbl1.children,
            React.createElement(Coachmark, {
                title = var3.headerText,
                text = var3.bodyText,
                isOpen = var2.isActive,
                onClose = onClose,
                side = PopoverSide.Right,
                align = PopoverAlign.Center,
                anchorRef = tbl1.anchorRef
            })
        )
    end

    return React.createElement(Coachmark, {
        title = var3.headerText,
        text = var3.bodyText,
        isOpen = var2.isActive,
        onClose = onClose,
        side = PopoverSide.Right,
        align = PopoverAlign.Center
    }, tbl1.children)
end)
