-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:31:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MarkdownParent = script:FindFirstAncestor("Markdown").Parent
local CommonMark = require(MarkdownParent.CommonMark)

local function Underline(str1: string)
    local customNode = CommonMark.Node.CustomNode.new("Underline")
    customNode.openingDelimiter = str1
    customNode.closingDelimiter = str1
    return customNode
end

return Underline
