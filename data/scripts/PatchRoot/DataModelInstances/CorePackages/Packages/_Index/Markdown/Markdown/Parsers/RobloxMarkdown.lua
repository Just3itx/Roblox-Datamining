-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:31:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Markdown = script:FindFirstAncestor("Markdown")
local MarkdownParent = Markdown.Parent
local _Adapter = require(Markdown.Adapter)
local CommonMark = require(MarkdownParent.CommonMark)
local Flags = require(Markdown.Flags)
local FormattingTagsExtension = require(Markdown.Parsers.FormattingTags.FormattingTagsExtension)
local MentionExtension = require(script.Mention.MentionExtension)
local NoNestedQuote = require(script.NoNestedQuote)
local _Types = require(Markdown.Types)
local UnderlineExtension = require(script.Underline.UnderlineExtension)
local createParser = require(Markdown.Adapter.createParser)

local enabledBlockTypes = table.freeze({ "Heading", "FencedCodeBlock", "IndentedCodeBlock", "ThematicBreak", "ListBlock" })

local enabledInlineTypes = table.freeze({ "Code", "BackslashEscape", "Emphasis", "Link", "Image", "HardLineBreak" })

local formattingTagsExtension = table.freeze(FormattingTagsExtension.create({ parseTags = true, maxNesting = 32 }))

local tbl1 = {
    table.freeze(NoNestedQuote.extension()),
    table.freeze(CommonMark.Ext.Gfm.Strikethrough.StrikethroughExtension.builder():requireTwoTildes(false):build()),
    table.freeze(UnderlineExtension.create()),
    table.freeze(MentionExtension.create())
}

if Flags.FFlagMarkdownFormattingTags then
    table.insert(tbl1, formattingTagsExtension)
end
local extensions = table.freeze(tbl1)

local parser = createParser({
    extensions = extensions,
    parserOptions = {
        enabledBlockTypes = enabledBlockTypes,
        enabledInlineTypes = enabledInlineTypes,
        linkReferenceDefinitions = false,
        maxOpenBlockParsers = 32,
        maxInlineNesting = 32
    }
})

local renderOptions = table.freeze({ extensions = extensions })

local module = {
    parseOptions = parser.parseOptions,
    renderOptions = renderOptions,
    formattingTagsExtension = formattingTagsExtension
}
function module.parse(str1: string)
    return parser.parseDocument(str1)
end

function module.toRendererAst(arg1, arg2)
    return parser.toRendererAst(arg1, arg2)
end

function module.safeParse(str1: string)
    return pcall(module.parse, str1)
end

function module.renderHtml(arg1)
    return CommonMark.renderHtml(arg1, renderOptions)
end

return module
