-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:21:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitives = script:FindFirstAncestor("ChatUIPrimitives")

local _Types = require(ChatUIPrimitives.Types)

local function resolveDisplayText(arg1, bool1: boolean)
    return if bool1 and arg1.translation ~= nil and arg1.translation ~= "" then arg1.translation else arg1.content
end

return resolveDisplayText
