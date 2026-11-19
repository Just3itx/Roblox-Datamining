-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:11:17Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local CommonMark = script:FindFirstAncestor("CommonMark")
local _NodeRenderer = require(CommonMark.renderer.NodeRenderer)

local module = {}
module.__index = module

function module.getNodeTypes(_): {string}
    return { "Strikethrough" }
end

return module
