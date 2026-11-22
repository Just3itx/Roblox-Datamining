-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:11:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InlineRichTextParent = script:FindFirstAncestor("InlineRichText").Parent

local Cryo = require(InlineRichTextParent.Cryo)
local InlineLayout = require(InlineRichTextParent.InlineLayout)
local Foundation = require(InlineRichTextParent.Foundation)

local RenderableInlineElement = InlineLayout.Components.InlineLayoutElements.RenderableInlineElement
local Icon = Foundation.Icon

local module = {}

local function mapProps(arg1)
    return Cryo.Dictionary.omit(arg1, "id", "Size")
end

function module.new(tbl1)
    return RenderableInlineElement.new(
        Icon,
        Cryo.Dictionary.join(tbl1, { Size = UDim2.fromOffset(tbl1.size, tbl1.size) }),
        mapProps
    )
end

return module
