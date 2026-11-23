-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:51:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Cryo = require(AppChatParent.Cryo)
local React = require(AppChatParent.React)
local memo = React.memo

local IconWithTextCell = require(AppChat.Components.Cells.IconWithTextCell)
local FFlagDebugAppChatEnableDomLocators = require(AppChat.Flags.FFlagDebugAppChatEnableDomLocators)
local DomLocators = require(AppChat.Utils.DomLocators)

local tbl1 = {
    groupNameText = "groupName",
    iconImage = nil,
    onActivated = nil,
    LayoutOrder = 1,
    iconCellWidth = 60,
    isDisabled = false,
    cellHeight = 36,
    style = nil,
    paddingBottom = 12
}

function GroupNameEntryCell(tbl2)
    local var1 = Cryo.Dictionary.join(tbl1, tbl2)

    local offset = if var1.isDisabled then var1.style.Tokens.Size.Size_300 else 0

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl3 = {
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        LayoutOrder = var1.LayoutOrder,
        Size = UDim2.fromScale(1, 0)
    }
    local tbl4 = {
        padding = React.createElement("UIPadding", { PaddingLeft = UDim.new(0, offset), PaddingBottom = UDim.new(0, var1.paddingBottom) })
    }
    local tbl5 = {
        IconWithText = React.createElement(IconWithTextCell, {
            primaryIcon = if var1.isDisabled then nil else var1.iconImage,
            Text = var1.groupNameText,
            iconCellWidth = var1.iconCellWidth,
            showDivider = false,
            isDisabled = var1.isDisabled,
            onActivated = var1.onActivated,
            LayoutOrder = 1,
            Size = UDim2.new(1, -offset, 0, var1.cellHeight),
            style = var1.style,
            testId = if FFlagDebugAppChatEnableDomLocators then DomLocators.chatDetailsListActionButton(var1.groupNameText) else nil
        })
    }
    return createElement(str1, tbl3, tbl4, tbl5)
end

return memo(GroupNameEntryCell)
