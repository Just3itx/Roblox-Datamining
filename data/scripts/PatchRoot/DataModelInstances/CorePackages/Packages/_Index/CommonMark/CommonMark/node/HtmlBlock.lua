-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:30:51Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local CommonMark = script:FindFirstAncestor("CommonMark")
local Node = require(CommonMark.node.Node)

local function HtmlBlock()
    local node = Node.new("HtmlBlock", true)
    node.literal = nil
    return node
end

return HtmlBlock
