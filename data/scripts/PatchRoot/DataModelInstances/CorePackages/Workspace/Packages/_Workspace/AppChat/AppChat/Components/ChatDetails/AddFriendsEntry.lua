-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:50:57Z
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
    Text = "(translated 'add friends' text here)",
    iconImage = nil,
    iconSize = 36,
    iconCellWidth = 60,
    cellHeight = 64,
    onActivated = nil,
    LayoutOrder = 0,
    style = nil
}

function AddFriendsEntry(tbl2)
    local var1 = Cryo.Dictionary.join(tbl1, tbl2)
    return React.createElement(IconWithTextCell, {
        Size = UDim2.new(1, 0, 0, var1.cellHeight),
        primaryIcon = var1.iconImage,
        primaryIconSize = var1.iconSize,
        iconCellWidth = var1.iconCellWidth,
        Text = var1.Text,
        onActivated = var1.onActivated,
        LayoutOrder = var1.LayoutOrder,
        style = var1.style,
        showDivider = false,
        testId = if FFlagDebugAppChatEnableDomLocators then DomLocators.chatDetailsListActionButton(var1.Text) else nil
    })
end

return memo(AddFriendsEntry)
