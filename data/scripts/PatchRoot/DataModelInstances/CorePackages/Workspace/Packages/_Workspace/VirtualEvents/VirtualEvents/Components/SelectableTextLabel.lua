-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:10:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VirtualEvents = script:FindFirstAncestor("VirtualEvents")

local Cryo = require(VirtualEvents.Parent.Cryo)
local React = require(VirtualEvents.Parent.React)
local useStyle = require(VirtualEvents.Parent.UIBlox).Core.Style.useStyle

local function SelectableTextLabel(tbl1)
    local baseSize = useStyle().Font.BaseSize
    local minTextSize = tbl1.fontStyle.RelativeMinSize * baseSize
    local maxTextSize = tbl1.fontStyle.RelativeSize * baseSize

    local var3 = Cryo.Dictionary.join({
        AutomaticSize = Enum.AutomaticSize.XY,
        BackgroundTransparency = 1,
        ClearTextOnFocus = false,
        Font = tbl1.fontStyle.Font,
        TextColor3 = tbl1.colorStyle.Color,
        TextEditable = false,
        TextTransparency = tbl1.colorStyle.Transparency,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top,
        ClipsDescendants = true
    }, tbl1, {
        fontStyle = Cryo.None,
        colorStyle = Cryo.None
    })

    return React.createElement("TextBox", var3, {
        TextSizeConstraint = React.createElement("UITextSizeConstraint", { MaxTextSize = maxTextSize, MinTextSize = minTextSize })
    })
end

return SelectableTextLabel
