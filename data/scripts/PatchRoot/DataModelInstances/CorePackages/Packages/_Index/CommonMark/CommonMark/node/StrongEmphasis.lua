-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:31:10Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local CommonMark = script:FindFirstAncestor("CommonMark")
local _Delimited = require(CommonMark.node.Delimited)
local Node = require(CommonMark.node.Node)

local function StrongEmphasis(str1: string?)
    local node = Node.new("StrongEmphasis", false)
    node.openingDelimiter = str1
    node.closingDelimiter = str1
    return node
end

return StrongEmphasis
