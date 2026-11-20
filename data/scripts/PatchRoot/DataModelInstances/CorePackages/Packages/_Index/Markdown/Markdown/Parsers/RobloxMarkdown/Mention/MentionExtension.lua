-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:31:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Markdown = script:FindFirstAncestor("Markdown")
local MarkdownParent = Markdown.Parent
local _AdapterTypes = require(Markdown.Adapter.AdapterTypes)
local _CommonMark = require(MarkdownParent.CommonMark)
local _Mention = require(script.Parent.Mention)
local MentionInlineParser = require(script.Parent.MentionInlineParser)

local module = {}

local function mentionText(arg1): string
    return `@{arg1.name or arg1.id}`
end

function module.create()
    return {
        extendParser = function(arg1)
            arg1:customInlineContentParserFactory(MentionInlineParser.Factory.new())
        end,
        extendHtmlRenderer = function(arg1)
            local mentionHtmlNodeRenderer = require(script.Parent.MentionHtmlNodeRenderer)
            arg1:nodeRendererFactory({
                create = function(_, arg2)
                    return (mentionHtmlNodeRenderer.new(arg2))
                end
            })
        end,
        extendAdapter = function(arg1)
            arg1:inline("Mention", { text = mentionText })
        end
    }
end

return module
