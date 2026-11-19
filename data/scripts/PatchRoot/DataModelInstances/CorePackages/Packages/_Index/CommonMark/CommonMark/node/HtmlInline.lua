-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:30:52Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local CommonMark = script:FindFirstAncestor("CommonMark")
local Node = require(CommonMark.node.Node)

local function HtmlInline()
    local node = Node.new("HtmlInline", false)
    node.literal = nil
    return node
end

return HtmlInline
