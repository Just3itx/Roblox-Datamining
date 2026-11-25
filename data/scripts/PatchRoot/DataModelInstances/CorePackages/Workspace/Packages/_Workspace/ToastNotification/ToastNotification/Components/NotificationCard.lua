-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:31:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent

local scriptParentParent = scriptParent.Parent
local constants = require(scriptParentParent.constants)
local dependencies = require(scriptParentParent.dependencies)
local context = scriptParentParent.context
local _type = require(scriptParentParent.type)
local NotificationActionsFrame = require(scriptParent.NotificationActionsFrame)
local NotificationContentFrame = require(scriptParent.NotificationContentFrame)
local useNotificationCardData = require(context.useNotificationCardData)
local useNotificationCardState = require(context.useNotificationCardState)

local UIBlox = dependencies.UIBlox

local scriptParentParentParent = scriptParentParent.Parent
local React = require(scriptParentParentParent.React)

local useStyle = UIBlox.Core.Style.useStyle
local Interactable = UIBlox.Core.Control.Interactable

local DefaultCardPadding = constants.Padding.DefaultCardPadding
local DefaultContentPadding = constants.DefaultContentPadding
local DefaultCardCornerRadius = constants.DefaultCardCornerRadius

return function(tbl1)
    local var1 = useNotificationCardData()
    local cardSize = var1.cardSize
    local backgroundTransparency = if var1.cardTransparency then var1.cardTransparency else constants.CardTransparency.Default
    local offset = if cardSize and cardSize.cardPadding then cardSize.cardPadding else DefaultCardPadding
    local var3 = useStyle()

    local handleActions = var1.handleActions
    local var4 = useNotificationCardState("textBody")
    local var5 = var4 and var4[1]
    local createElement = React.createElement
    local var6 = Interactable
    local tbl2 = {
        AutoButtonColor = false,
        BackgroundColor3 = var3.Theme.BackgroundUIDefault.Color,
        BackgroundTransparency = backgroundTransparency,
        BorderSizePixel = 0,
        AutomaticSize = Enum.AutomaticSize.Y,
        onStateChanged = function() end,
        Size = UDim2.new(1, 0, 0, 0)
    }

    tbl2[React.Event.Activated] = function()
        if handleActions and var5 then
            handleActions(var5)
        end
    end

    return createElement(var6, tbl2, {
        UICorner = React.createElement("UICorner", { CornerRadius = DefaultCardCornerRadius }),
        UIListLayout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            Padding = UDim.new(0, DefaultContentPadding),
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Center
        }),
        UIPadding = React.createElement("UIPadding", {
            PaddingBottom = UDim.new(0, offset),
            PaddingLeft = UDim.new(0, offset),
            PaddingRight = UDim.new(0, offset),
            PaddingTop = UDim.new(0, offset)
        }),
        NotificationContentFrame = React.createElement(
            NotificationContentFrame,
            {
                showHoldButton = tbl1.showHoldButton,
                shouldAutoFocus = tbl1.shouldAutoFocus,
                holdProgress = tbl1.holdProgress
            }
        ),
        NotificationActionsFrame = React.createElement(NotificationActionsFrame, { shouldAutoFocus = tbl1.shouldAutoFocus })
    })
end
