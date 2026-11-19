-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:31:04Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local CommonMark = script:FindFirstAncestor("CommonMark")
local ListBlock = require(CommonMark.node.ListBlock)

local function OrderedList()
    local listBlock = ListBlock.new("OrderedList")
    listBlock.markerDelimiter = nil
    listBlock.markerStartNumber = nil
    return listBlock
end

return OrderedList
