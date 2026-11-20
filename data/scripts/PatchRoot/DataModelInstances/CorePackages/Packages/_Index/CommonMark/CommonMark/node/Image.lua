-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:10:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CommonMark = script:FindFirstAncestor("CommonMark")
local Node = require(CommonMark.node.Node)

local function Image(destination: string?, title: string?)
    local node = Node.new("Image", false)
    node.destination = destination
    node.title = title
    return node
end

function Node.toStringAttributesByKind.Image(arg1)
    return "destination=" .. (if arg1.destination == nil then "null" else arg1.destination) .. ", title=" .. (if arg1.title == nil then "null" else arg1.title)
end

return Image
