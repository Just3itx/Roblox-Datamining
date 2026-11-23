-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:51:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Cryo = require(AppChatParent.Cryo)
local React = require(AppChatParent.React)
local memo = React.memo
local IconWithTextCell = require(AppChat.Components.Cells.IconWithTextCell)
local RoactFitComponents = require(AppChatParent.LuaSocialLibrariesDeps).RoactFitComponents

local FFlagDebugAppChatEnableDomLocators = require(AppChat.Flags.FFlagDebugAppChatEnableDomLocators)
local DomLocators = require(AppChat.Utils.DomLocators)

local tbl1 = {
    leaveGroupText = "leaveGroupText",
    onActivated = nil,
    iconImage = nil,
    cellHeight = 64,
    iconCellWidth = 60,
    marginTop = 12,
    LayoutOrder = 0,
    style = nil
}

function LeaveGroupCell(tbl2)
    local var1 = Cryo.Dictionary.join(tbl1, tbl2)

    local createElement = React.createElement
    local fitFrameVertical = RoactFitComponents.FitFrameVertical
    local tbl3 = {
        BackgroundTransparency = 1,
        LayoutOrder = var1.LayoutOrder,
        width = UDim.new(1, 0),
        margin = {
            top = var1.marginTop,
            left = 0,
            right = 0,
            bottom = 0
        }
    }

    local tbl4 = {
        LeaveGroupRow = React.createElement(IconWithTextCell, {
            LayoutOrder = var1.LayoutOrder,
            onActivated = var1.onActivated,
            primaryIcon = var1.iconImage,
            showDivider = false,
            Size = UDim2.new(1, 0, 0, var1.cellHeight),
            style = var1.style,
            Text = var1.leaveGroupText,
            iconCellWidth = var1.iconCellWidth,
            testId = if FFlagDebugAppChatEnableDomLocators then DomLocators.chatDetailsListActionButton(var1.leaveGroupText) else nil
        })
    }
    return createElement(fitFrameVertical, tbl3, tbl4)
end

return memo(LeaveGroupCell)
