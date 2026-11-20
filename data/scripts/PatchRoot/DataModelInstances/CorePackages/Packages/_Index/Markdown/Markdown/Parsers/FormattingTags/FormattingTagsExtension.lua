-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:31:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Markdown = script:FindFirstAncestor("Markdown")
local MarkdownParent = Markdown.Parent
local _AdapterTypes = require(Markdown.Adapter.AdapterTypes)
local _CommonMark = require(MarkdownParent.CommonMark)
local _FormattingTag = require(script.Parent.FormattingTag)
local FormattingTagInlineParser = require(script.Parent.FormattingTagInlineParser)
local FormattingTagPostProcessor = require(script.Parent.FormattingTagPostProcessor)

local var1 = table.freeze({ b = "BOLD_2", i = "ITALIC", u = "UNDERLINE", s = "STRIKE" })

local module = {}

local function adaptFormattingTag(arg1, arg2)
    if arg1:getFirstChild() == nil then
        return
    end
    arg2:adaptInlinesOf(arg1, (arg2:append(arg2.parent, "STYLED_TEXT", { style = var1[arg1.tagName] })))
end

local function literalOf(arg1)
    return arg1.literal
end

function module.create(tbl1)
    local bool1 = not (tbl1 == nil) and tbl1.parseTags == true
    local maxNesting = if tbl1 == nil then nil else tbl1.maxNesting

    return {
        extendParser = function(arg1)
            if bool1 then
                arg1:customInlineContentParserFactory(FormattingTagInlineParser.Factory.new())
            end
            arg1:postProcessor((FormattingTagPostProcessor.new(maxNesting)))
        end,
        extendHtmlRenderer = function(arg1)
            local formattingTagHtmlNodeRenderer = require(script.Parent.FormattingTagHtmlNodeRenderer)
            arg1:nodeRendererFactory({
                create = function(_, arg2)
                    return (formattingTagHtmlNodeRenderer.new(arg2))
                end
            })
        end,
        extendAdapter = function(arg1)
            arg1:inline("FormattingTag", adaptFormattingTag)
            arg1:inline("FormattingTagText", { text = literalOf })
        end
    }
end

return module
