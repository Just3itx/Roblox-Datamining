-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:01:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CommonMark = script:FindFirstAncestor("CommonMark")
local Node = require(CommonMark.node.Node)

local module = {}

function module.new(str1: string)
    return Node.new(str1, true)
end

return module
