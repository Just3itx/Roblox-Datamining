-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:51:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local Rodux = require(ExpChatParent.Rodux)
local Dictionary = require(ExpChatParent.llama).Dictionary

local Actions = ExpChat.Actions
local ChatLayoutHorizontalAlignmentChanged = require(Actions.ChatLayoutHorizontalAlignmentChanged)
local ChatLayoutVerticalAlignmentChanged = require(Actions.ChatLayoutVerticalAlignmentChanged)

local guiInsetY = GuiService:GetGuiInset().Y

local tbl1 = {
    Position = UDim2.new(0, 8, 0, 4),
    AnchorPoint = Vector2.new(0, 0),
    UIListLayoutVerticalAlignment = Enum.VerticalAlignment.Top
}

local createReducer = Rodux.createReducer
local tbl2 = {}
tbl2[ChatLayoutHorizontalAlignmentChanged.name] = function(arg1, arg2)
    local position = arg1.Position
    local anchorPoint = arg1.AnchorPoint

    if arg2.value == Enum.HorizontalAlignment.Left then
        position = UDim2.new(0, 8, position.Y.Scale, position.Y.Offset)
        anchorPoint = Vector2.new(0, anchorPoint.Y)
    elseif arg2.value == Enum.HorizontalAlignment.Center then
        position = UDim2.new(0.5, 0, position.Y.Scale, position.Y.Offset)
        anchorPoint = Vector2.new(0.5, anchorPoint.Y)
    elseif arg2.value == Enum.HorizontalAlignment.Right then
        position = UDim2.new(1, -8, position.Y.Scale, position.Y.Offset)
        anchorPoint = Vector2.new(1, anchorPoint.Y)
    end

    return Dictionary.join(arg1, { Position = position, AnchorPoint = anchorPoint })
end

tbl2[ChatLayoutVerticalAlignmentChanged.name] = function(arg1, arg2)
    local position = arg1.Position
    local anchorPoint = arg1.AnchorPoint

    if arg2.value == Enum.VerticalAlignment.Top then
        position = UDim2.new(position.X.Scale, position.X.Offset, 0, 4)
        anchorPoint = Vector2.new(anchorPoint.X, 0)
    elseif arg2.value == Enum.VerticalAlignment.Center then
        position = UDim2.new(position.X.Scale, position.X.Offset, 0.5, -guiInsetY)
        anchorPoint = Vector2.new(anchorPoint.X, 0.5)
    elseif arg2.value == Enum.VerticalAlignment.Bottom then
        position = UDim2.new(position.X.Scale, position.X.Offset, 1, -4)
        anchorPoint = Vector2.new(anchorPoint.X, 1)
    end

    return Dictionary.join(arg1, { Position = position, AnchorPoint = anchorPoint, UIListLayoutVerticalAlignment = arg2.value })
end

return createReducer(tbl1, tbl2)
