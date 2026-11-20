-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:31:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MarkdownParent = script:FindFirstAncestor("Markdown").Parent
local CommonMark = require(MarkdownParent.CommonMark)

local function Mention(id: string, name: string?)
    local customNode = CommonMark.Node.CustomNode.new("Mention")
    customNode.id = id
    customNode.name = name
    return customNode
end

return Mention
