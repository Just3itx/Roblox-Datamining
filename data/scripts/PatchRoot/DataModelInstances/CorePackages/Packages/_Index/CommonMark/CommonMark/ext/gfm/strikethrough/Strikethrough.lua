-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:11:18Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local CommonMark = script:FindFirstAncestor("CommonMark")
local CustomNode = require(CommonMark.node.CustomNode)
local _Delimited = require(CommonMark.node.Delimited)

local function Strikethrough(str1: string)
    local customNode = CustomNode.new("Strikethrough")
    customNode.openingDelimiter = str1
    customNode.closingDelimiter = str1
    return customNode
end

return Strikethrough
