-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:30:59Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local CommonMark = script:FindFirstAncestor("CommonMark")
local Node = require(CommonMark.node.Node)

local module = {}

function module.new(str1: string)
    local node = Node.new(str1, true)
    node.tight = false
    return node
end

return module
