-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:30:55Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local CommonMark = script:FindFirstAncestor("CommonMark")
local Node = require(CommonMark.node.Node)

local function IndentedCodeBlock()
    local node = Node.new("IndentedCodeBlock", true)
    node.literal = nil
    return node
end

return IndentedCodeBlock
