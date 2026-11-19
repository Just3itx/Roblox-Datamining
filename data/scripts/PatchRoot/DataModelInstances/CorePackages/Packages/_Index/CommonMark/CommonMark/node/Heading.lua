-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:30:49Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local CommonMark = script:FindFirstAncestor("CommonMark")
local Node = require(CommonMark.node.Node)

local function Heading()
    local node = Node.new("Heading", true)
    node.level = 0
    return node
end

return Heading
