-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:01:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CommonMark = script:FindFirstAncestor("CommonMark")
local Node = require(CommonMark.node.Node)

local function Document()
    return Node.new("Document", true)
end

return Document
