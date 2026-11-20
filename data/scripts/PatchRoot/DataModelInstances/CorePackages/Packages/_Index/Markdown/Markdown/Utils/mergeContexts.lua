-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:31:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Markdown = script:FindFirstAncestor("Markdown")
local MarkdownParent = Markdown.Parent

local Dash = require(MarkdownParent.Dash)
local _Types = require(Markdown.Types)

local function mergeContexts(arg1, arg2)
    return Dash.joinDeep(arg1, arg2)
end
return mergeContexts
