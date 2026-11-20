-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:31:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MarkdownParent = script:FindFirstAncestor("Markdown").Parent
local CommonMark = require(MarkdownParent.CommonMark)

local module = {}

function module.new(tagName: string)
    local customNode = CommonMark.Node.CustomNode.new("FormattingTag")
    customNode.tagName = tagName
    return customNode
end

function module.text(literal: string)
    local customNode = CommonMark.Node.CustomNode.new("FormattingTagText")
    customNode.literal = literal
    return customNode
end

module.TAGS = table.freeze({
    ["<b>"] = table.freeze({ name = "b", closing = false }),
    ["</b>"] = table.freeze({ name = "b", closing = true }),
    ["<i>"] = table.freeze({ name = "i", closing = false }),
    ["</i>"] = table.freeze({ name = "i", closing = true }),
    ["<u>"] = table.freeze({ name = "u", closing = false }),
    ["</u>"] = table.freeze({ name = "u", closing = true }),
    ["<s>"] = table.freeze({ name = "s", closing = false }),
    ["</s>"] = table.freeze({ name = "s", closing = true })
})

return module
