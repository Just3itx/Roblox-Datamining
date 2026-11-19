-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:31:11Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local CommonMark = script:FindFirstAncestor("CommonMark")
local Node = require(CommonMark.node.Node)

local function Text(literal: string?)
    local node = Node.new("Text", false)
    node.literal = literal
    return node
end

function Node.toStringAttributesByKind.Text(arg1)
    return "literal=" .. (if arg1.literal == nil then "null" else arg1.literal)
end

return Text
