-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:30:35Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local CommonMark = script:FindFirstAncestor("CommonMark")
local Node = require(CommonMark.node.Node)

local function Code(literal: string?)
    local node = Node.new("Code", false)
    node.literal = literal
    return node
end

return Code
