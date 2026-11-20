-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:31:31Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local _Adapter = require(scriptParent.Adapter)
local _CommonMark = require(scriptParentParent.CommonMark)
local _FormattingTag = require(scriptParent.Parsers.FormattingTags.FormattingTag)
local _Mention = require(scriptParent.Parsers.RobloxMarkdown.Mention.Mention)
local _Underline = require(scriptParent.Parsers.RobloxMarkdown.Underline.Underline)
local _createParser = require(scriptParent.Adapter.createParser)

return {
    ParserDocument = nil,
    ParserNode = nil,
    Mention = nil,
    FormattingTag = nil,
    FormattingTagText = nil,
    Underline = nil,
    Parser = nil,
    ParserConfig = nil,
    Extension = nil,
    AdapterAsName = nil,
    AdapterAttributes = nil,
    AdapterBlockName = nil,
    AdapterBlockRule = nil,
    AdapterBuilder = nil,
    AdapterContext = nil,
    AdapterEntryOptions = nil,
    AdapterExtension = nil,
    AdapterFallback = nil,
    AdapterFlattenOptions = nil,
    AdapterGap = nil,
    AdapterGapKind = nil,
    AdapterHandler = nil,
    AdapterInlineName = nil,
    AdapterInlineRule = nil,
    AdapterListOptions = nil,
    AdapterPassName = nil,
    AdapterQuoteOptions = nil,
    AdapterRendererName = nil,
    AdapterStyle = nil
}
