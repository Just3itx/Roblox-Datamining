-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:20:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MarkdownParent = script:FindFirstAncestor("Markdown").Parent
local _CommonMark = require(MarkdownParent.CommonMark)

local module = {}

function module.startNumber(arg1)
    return if arg1.kind == "OrderedList" then arg1.markerStartNumber or 1 else nil
end

function module.bulletPrefix(arg1): string
    return if (if arg1.kind == "BulletList" then arg1.marker else nil) == "*" then "* " else "- "
end

function module.orderedPrefix(num1: number): string
    return tostring(num1)
end

return module
