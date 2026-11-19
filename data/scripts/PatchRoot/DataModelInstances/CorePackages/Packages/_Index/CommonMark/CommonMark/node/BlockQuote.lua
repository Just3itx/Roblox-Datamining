-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:21:20Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local CommonMark = script:FindFirstAncestor("CommonMark")
local Node = require(CommonMark.node.Node)

local function BlockQuote()
    return Node.new("BlockQuote", true)
end

return BlockQuote
