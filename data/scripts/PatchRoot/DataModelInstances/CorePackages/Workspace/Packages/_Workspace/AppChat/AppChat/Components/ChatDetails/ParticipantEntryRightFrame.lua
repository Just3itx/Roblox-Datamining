-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:01:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Cryo = require(AppChatParent.Cryo)
local Foundation = require(AppChatParent.Foundation)
local React = require(AppChatParent.React)
local memo = React.memo
local useStyle = require(AppChatParent.UIBlox).Core.Style.useStyle

local Label = require(AppChat.Components.Label.Label)
local FFlagDebugAppChatEnableDomLocators = require(AppChat.Flags.FFlagDebugAppChatEnableDomLocators)

local ButtonVariant = Foundation.Enums.ButtonVariant
local IconButton = Foundation.IconButton
local IconName = Foundation.Enums.IconName
local IconSize = Foundation.Enums.IconSize

local tbl1 = {
    onDotsActivated = function() end,
    shouldShowDots = false
}

function ParticipantEntryRightFrame(tbl2)
    local var1 = Cryo.Dictionary.join(tbl1, tbl2)
    local var2 = useStyle()
    local var3 = var1.style or var2

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl3 = {
        AutomaticSize = Enum.AutomaticSize.X,
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 0, 1, 0),
        [React.Change.AbsoluteSize] = var1[React.Change.AbsoluteSize]
    }
    local tbl4 = {
        UIListLayout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            Padding = UDim.new(0, 22),
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Center
        }),
        UIPadding = React.createElement("UIPadding", { PaddingLeft = UDim.new(0, 22), PaddingRight = UDim.new(0, 22) }),
        label = if var1.labelText then React.createElement(Label, {
            backgroundColor3 = var3.Theme.BackgroundContrast.Color,
            backgroundTransparency = var3.Theme.BackgroundContrast.Transparency,
            bodyText = var1.labelText,
            layoutOrder = 1
        }) else nil,
        dots = 0
    }
    local var4

    if var1.shouldShowDots then
        local createElement2 = React.createElement
        local str2 = "Frame"
        local tbl5 = {
            Size = UDim2.new(0, 20, 1, 0),
            BackgroundTransparency = 1,
            LayoutOrder = 2,
            Name = "dots"
        }

        local tbl6 = {
            Dots = React.createElement(IconButton, {
                AnchorPoint = Vector2.new(0.5, 0.5),
                icon = IconName.ThreeDotsHorizontal,
                onActivated = var1.onDotsActivated,
                Position = UDim2.fromScale(0.5, 0.5),
                ref = var1.dotsRef,
                Size = UDim2.new(0, 36, 0, 36),
                testId = if FFlagDebugAppChatEnableDomLocators then var1.testId else nil,
                size = IconSize.Medium,
                variant = ButtonVariant.Utility
            })
        }
        var4 = createElement2(str2, tbl5, tbl6)
    else
        var4 = nil
    end

    tbl4.dots = var4
    return createElement(str1, tbl3, tbl4)
end

return memo(ParticipantEntryRightFrame)
