-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:31:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Markdown = script:FindFirstAncestor("Markdown")

local _Types = require(Markdown.Types)

local function shouldUseTopPadding(arg1): boolean
    return arg1.offset ~= 0
end

return shouldUseTopPadding
