-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:11:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InlineRichText = script:FindFirstAncestor("InlineRichText")
local InlineRichTextParent = InlineRichText.Parent

local Cryo = require(InlineRichTextParent.Cryo)
local TextElement = require(InlineRichTextParent.InlineLayout).Components.InlineLayoutElements.TextElement

local _Types = require(InlineRichText.Types)

return function(arg1, arg2)
    local var1 = arg2.processChildren(arg1, arg2)
    return Cryo.List.map(var1, function(arg3, layoutOrder)
        return TextElement.new({
            LayoutOrder = layoutOrder,
            EngineTags = arg3.engineTags,
            Text = arg3.text,
            fontStyle = arg2.styles.fontStyle,
            textStyle = arg2.styles.textStyle
        })
    end)
end
