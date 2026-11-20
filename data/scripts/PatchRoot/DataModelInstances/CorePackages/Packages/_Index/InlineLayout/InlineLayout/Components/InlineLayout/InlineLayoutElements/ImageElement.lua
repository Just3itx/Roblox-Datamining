-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:31:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ComponentsParentParent = script:FindFirstAncestor("Components").Parent.Parent
local InlineLayoutElements = script:FindFirstAncestor("InlineLayoutElements")

local Foundation = require(ComponentsParentParent.Foundation)
local Dash = require(ComponentsParentParent.Dash)

local RenderableInlineElement = require(InlineLayoutElements.RenderableInlineElement)
local Image = Foundation.Image

local module = {}

local function mapProps(arg1)
    return Dash.omit(arg1, { "id" })
end

function module.new(tbl1)
    return RenderableInlineElement.new(Image, tbl1, mapProps)
end

return module
