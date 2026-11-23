-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:30:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local React = require(AppChatParent.React)
local Foundation = require(AppChatParent.Foundation)
local BuilderIcons = require(AppChatParent.BuilderIcons)
local Cryo = require(AppChatParent.Cryo)
local OptionsEnum = require(script.Parent.OptionsEnum)

local FFlagAppChatEnableMessageContextMenu = require(AppChat.Flags.FFlagAppChatEnableMessageContextMenu)
local SignalsMigrationConfig = require(AppChat.Flags.SignalsMigrationConfig)

local tbl1 = {
    LayoutOrder = 1,
    isIncoming = false,
    handleEvent = function(_, _, _) end,
    emitImpressionTelemetryEvent = function() end
}

function Options(tbl2)
    local var1 = Cryo.Dictionary.union(tbl1, tbl2)
    local var2 = Foundation.Hooks.useTokens()

    React.useEffect(function()
        var1.emitImpressionTelemetryEvent()
    end, {})

    local onActivated = React.useCallback(function()
        var1.handleEvent(React.Event.Activated, nil, OptionsEnum.Reply)
    end, { var1.handleEvent })

    local var3 = React.useCallback(function()
        var1.handleEvent(React.Event.Activated, nil, OptionsEnum.MessageContextMenu)
    end, { var1.handleEvent })

    local tbl3 = {
        Reply = React.createElement(Foundation.IconButton, {
            onActivated = onActivated,
            icon = BuilderIcons.Icon.ArrowThickToRight,
            variant = Foundation.Enums.ButtonVariant.Standard,
            size = Foundation.Enums.InputSize.Medium,
            isCircular = true,
            LayoutOrder = if var1.isIncoming then 1 else -1
        }),
        MessageContextMenu = 0
    }
    local element

    if FFlagAppChatEnableMessageContextMenu then
        element = React.createElement(Foundation.IconButton, {
            onActivated = var3,
            icon = BuilderIcons.Icon.ThreeDotsHorizontal,
            variant = Foundation.Enums.ButtonVariant.Standard,
            size = Foundation.Enums.InputSize.Medium,
            isCircular = true,
            LayoutOrder = if var1.isIncoming then 2 else -2
        })
    else
        element = nil
    end

    tbl3.MessageContextMenu = element

    if not SignalsMigrationConfig.shouldUseViewRecyclerMessageList then
        return React.createElement(Foundation.View, { tag = "row auto-xy gap-xxsmall", LayoutOrder = var1.LayoutOrder }, tbl3)
    end

    return React.createElement(
        "Frame",
        {
            BackgroundTransparency = 1,
            AutomaticSize = Enum.AutomaticSize.X,
            Size = UDim2.new(),
            LayoutOrder = var1.LayoutOrder
        },
        {
            Buttons = React.createElement(
                "Frame",
                {
                    BackgroundTransparency = 1,
                    AutomaticSize = Enum.AutomaticSize.XY,
                    AnchorPoint = Vector2.new(0, 0.5),
                    Position = UDim2.fromScale(0, 0.5),
                    Size = UDim2.new()
                },
                Cryo.Dictionary.join(tbl3, {
                    Layout = React.createElement("UIListLayout", {
                        FillDirection = Enum.FillDirection.Horizontal,
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        Padding = UDim.new(0, var2.Gap.XXSmall)
                    })
                })
            )
        }
    )
end

return React.memo(Options)
