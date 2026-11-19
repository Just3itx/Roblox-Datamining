-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:11:13Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local script = script
local AbstractBlockParser = require(script.parser.block.AbstractBlockParser)
local AbstractVisitor = require(script.node.AbstractVisitor)
local ApiOptions = require(script.internal.port.ApiOptions)
local AsciiMatcher = require(script.text.AsciiMatcher)
local AutolinkInlineParser = require(script.internal.inline.AutolinkInlineParser)
local BlockContinue = require(script.parser.block.BlockContinue)
local _BlockParser = require(script.parser.block.BlockParser)
local _BlockParserFactory = require(script.parser.block.BlockParserFactory)
local BlockQuoteParser = require(script.internal.BlockQuoteParser)
local BlockStart = require(script.parser.block.BlockStart)
local _CharMatcher = require(script.text.CharMatcher)
local Characters = require(script.text.Characters)
local CustomBlock = require(script.node.CustomBlock)
local CustomNode = require(script.node.CustomNode)
local _DelimiterProcessor = require(script.parser.delimiter.DelimiterProcessor)
local _DelimiterRun = require(script.parser.delimiter.DelimiterRun)
local EmphasisDelimiterProcessor = require(script.internal.inline.EmphasisDelimiterProcessor)
local _Extension = require(script.Extension)
local _IncludeSourceSpans = require(script.parser.IncludeSourceSpans)
local _InlineContentParser = require(script.parser.beta.InlineContentParser)
local _InlineContentParserFactory = require(script.parser.beta.InlineContentParserFactory)
local _InlineParser = require(script.parser.InlineParser)
local _InlineParserContext = require(script.parser.InlineParserContext)
local _InlineParserState = require(script.parser.beta.InlineParserState)
local _LinkInfo = require(script.parser.beta.LinkInfo)
local _LinkProcessor = require(script.parser.beta.LinkProcessor)
local LinkResult = require(script.parser.beta.LinkResult)
local LinkedHashMap = require(script.internal.port.LinkedHashMap)
local _MatchedBlockParser = require(script.parser.block.MatchedBlockParser)
local Nodes = require(script.node.Nodes)
local ParsedInline = require(script.parser.beta.ParsedInline)
local _ParserState = require(script.parser.block.ParserState)
local _Position = require(script.parser.beta.Position)
local Scanner = require(script.parser.beta.Scanner)
local SourceLine = require(script.parser.SourceLine)
local SourceLines = require(script.parser.SourceLines)
local SourceSpan = require(script.node.SourceSpan)
local SourceSpans = require(script.node.SourceSpans)
local StrikethroughExtension = require(script.ext.gfm.strikethrough.StrikethroughExtension)
local _Visitor = require(script.node.Visitor)

local module = {
    Node = table.freeze({
        AbstractVisitor = AbstractVisitor,
        CustomBlock = CustomBlock,
        CustomNode = CustomNode,
        Nodes = Nodes,
        SourceSpan = SourceSpan,
        SourceSpans = SourceSpans
    }),
    Parser = table.freeze({
        SourceLine = SourceLine,
        SourceLines = SourceLines,
        Beta = table.freeze({ LinkResult = LinkResult, ParsedInline = ParsedInline, Scanner = Scanner }),
        Block = table.freeze({ AbstractBlockParser = AbstractBlockParser, BlockContinue = BlockContinue, BlockStart = BlockStart }),
        Delimiter = table.freeze({ EmphasisLikeDelimiterProcessor = EmphasisDelimiterProcessor })
    }),
    Renderer = table.freeze({
        Html = (function<T>(arg1: T, tbl1): T -- name: freezeWithLazyMembers
            local var1 = table.clone(arg1)
            local function member(str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
                local var2 = var1[str1]
                if var2 == nil and tbl1[str1] ~= nil then
                    var2 = tbl1[str1]()
                    var1[str1] = var2
                end
                return var2
            end
            setmetatable(arg1, table.freeze({
                __index = function(_, arg2)
                    return (member(arg2))
                end,
                __iter = function()
                    for value in tbl1 do
                        if var1[value] == nil and tbl1[value] ~= nil then
                            local var2 = tbl1[value]()
                            var1[value] = var2
                        end
                    end
                    return next, var1
                end
            }))

            table.freeze(arg1)
            return arg1
        end)(
            { DefaultUrlSanitizer = nil, LinkedHashMap = LinkedHashMap },
            {
                DefaultUrlSanitizer = function()
                    return require(script.renderer.html.DefaultUrlSanitizer)
                end
            }
        )
    }),
    Text = table.freeze({ AsciiMatcher = AsciiMatcher, Characters = Characters }),
    Ext = table.freeze(
        {
            Gfm = table.freeze({ Strikethrough = table.freeze({ StrikethroughExtension = StrikethroughExtension }) })
        }
    ),
    Internal = table.freeze({ AutolinkInlineParser = AutolinkInlineParser, BlockQuoteParser = BlockQuoteParser })
}

function module.parse(str1: string, arg1)
    return ApiOptions.getParser(arg1):parse(str1)
end

function module.renderHtml(arg1, arg2)
    return ApiOptions.getHtmlRenderer(arg2):render(arg1)
end

return module
