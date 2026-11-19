-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:31:06Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local CommonMark = script:FindFirstAncestor("CommonMark")
local Node = require(CommonMark.node.Node)

local function SoftLineBreak()
    return Node.new("SoftLineBreak", false)
end

return SoftLineBreak
