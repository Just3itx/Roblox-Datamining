-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:31:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MarkdownParent = script:FindFirstAncestor("Markdown").Parent
local CommonMark = require(MarkdownParent.CommonMark)
local Underline = require(script.Parent.Underline)

local module = {}

function module.new()
    return CommonMark.Parser.Delimiter.EmphasisLikeDelimiterProcessor.new(95, { minLength = 2, createStrongEmphasis = Underline })
end

return module
