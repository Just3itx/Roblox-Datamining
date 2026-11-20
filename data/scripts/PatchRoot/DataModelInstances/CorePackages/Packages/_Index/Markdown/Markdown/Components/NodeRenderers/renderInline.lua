-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:21:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Markdown = script:FindFirstAncestor("Markdown")
local MarkdownParent = Markdown.Parent

local _Types = require(Markdown.Types)
local React = require(MarkdownParent.React)
local Dash = require(MarkdownParent.Dash)
local InlineLayout = require(MarkdownParent.InlineLayout)
local Flags = require(MarkdownParent.MarkdownCore).Flags

local InlineLayout2 = InlineLayout.Components.InlineLayout
local mergeContexts = require(Markdown.Utils.mergeContexts)
local isInlineElement = InlineLayout.Utils.isInlineElement

local function renderInline(arg1, arg2, horizontalAlignment)
    local createElement = React.createElement
    local var1 = InlineLayout2
    local tbl1 = { HorizontalAlignment = 0, VerticalPadding = 0, Elements = 0 }
    if not Flags.FFlagMarkdownTables then
        horizontalAlignment = nil
    end

    tbl1.HorizontalAlignment = horizontalAlignment
    tbl1.VerticalPadding = UDim.new(0, 0)
    tbl1.Elements = Dash.filter(arg2.processChildren(arg1, mergeContexts(arg2, { isInline = true })), isInlineElement)
    return createElement(var1, tbl1)
end

return renderInline
