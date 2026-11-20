-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:31:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Markdown = script:FindFirstAncestor("Markdown")
local MarkdownParent = Markdown.Parent
local _AdapterTypes = require(Markdown.Adapter.AdapterTypes)
local _CommonMark = require(MarkdownParent.CommonMark)
local UnderlineDelimiterProcessor = require(script.Parent.UnderlineDelimiterProcessor)

local module = {}

function module.create()
    return {
        extendParser = function(arg1)
            arg1:customDelimiterProcessor(UnderlineDelimiterProcessor.new())
        end,
        extendHtmlRenderer = function(arg1)
            local underlineHtmlNodeRenderer = require(script.Parent.UnderlineHtmlNodeRenderer)
            arg1:nodeRendererFactory({
                create = function(_, arg2)
                    return (underlineHtmlNodeRenderer.new(arg2))
                end
            })
        end,
        extendAdapter = function(arg1)
            arg1:inline("Underline", { style = "UNDERLINE" })
        end
    }
end

return module
