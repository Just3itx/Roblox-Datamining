-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:10:38Z
-- Luau bytecode version: 14 | Luau type version: 3
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
