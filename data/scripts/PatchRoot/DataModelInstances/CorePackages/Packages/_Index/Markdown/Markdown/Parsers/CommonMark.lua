-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:21:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Markdown = script:FindFirstAncestor("Markdown")
local MarkdownParent = Markdown.Parent
local _Adapter = require(Markdown.Adapter)
local CommonMark = require(MarkdownParent.CommonMark)
local Flags = require(Markdown.Flags)
local FormattingTagsExtension = require(Markdown.Parsers.FormattingTags.FormattingTagsExtension)
local _Types = require(Markdown.Types)
local createParser = require(Markdown.Adapter.createParser)

local formattingTagsExtension = table.freeze(FormattingTagsExtension.create({ maxNesting = 100 }))

local extensions = table.freeze(Flags.FFlagMarkdownFormattingTags and { formattingTagsExtension } or {})

local parser = createParser({ extensions = extensions })

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
