-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:01:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CommonMark = script:FindFirstAncestor("CommonMark")
local _Delimited = require(CommonMark.node.Delimited)
local Node = require(CommonMark.node.Node)

local function Emphasis(str1: string?)
    local node = Node.new("Emphasis", false)
    node.openingDelimiter = str1
    node.closingDelimiter = str1
    return node
end

return Emphasis
