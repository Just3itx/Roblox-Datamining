-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:21:21Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local CommonMark = script:FindFirstAncestor("CommonMark")
local ListBlock = require(CommonMark.node.ListBlock)

local function BulletList()
    local listBlock = ListBlock.new("BulletList")
    listBlock.marker = nil
    return listBlock
end

return BulletList
