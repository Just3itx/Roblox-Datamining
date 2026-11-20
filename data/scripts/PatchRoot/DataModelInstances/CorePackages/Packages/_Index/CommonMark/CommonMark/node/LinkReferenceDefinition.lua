-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:10:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CommonMark = script:FindFirstAncestor("CommonMark")
local Node = require(CommonMark.node.Node)

local function LinkReferenceDefinition(label: string?, destination: string?, title: string?)
    local node = Node.new("LinkReferenceDefinition", true)
    node.label = label
    node.destination = destination
    node.title = title
    return node
end

return LinkReferenceDefinition
