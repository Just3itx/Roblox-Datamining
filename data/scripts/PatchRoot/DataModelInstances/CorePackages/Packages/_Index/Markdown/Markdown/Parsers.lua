-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:21:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local lazyMembers = require(script.Parent.lazyMembers)

local tbl1 = {
    CommonMark = nil,
    CommonMarkComplianceParser = require(script.CommonMarkComplianceParser),
    RobloxMarkdown = nil,
    WikiMarkdownParser = require(script.WikiMarkdownParser)
}

lazyMembers(tbl1, {
    CommonMark = function()
        return require(script.CommonMark.RendererParser)
    end,
    RobloxMarkdown = function()
        return require(script.RobloxMarkdown.RendererParser)
    end
})

return tbl1
