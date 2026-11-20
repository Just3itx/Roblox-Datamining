-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T02:51:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CommonMark = script:FindFirstAncestor("CommonMark")
local AbstractBlockParser = require(CommonMark.parser.block.AbstractBlockParser)
local AsciiMatcher = require(CommonMark.text.AsciiMatcher)
local BlockContent = require(CommonMark.internal.BlockContent)
local BlockContinue = require(CommonMark.parser.block.BlockContinue)
local _BlockParserFactory = require(CommonMark.parser.block.BlockParserFactory)
local BlockStart = require(CommonMark.parser.block.BlockStart)
local _CharMatcher = require(CommonMark.text.CharMatcher)
local HtmlInlineParser = require(CommonMark.internal.inline.HtmlInlineParser)
local _MatchedBlockParser = require(CommonMark.parser.block.MatchedBlockParser)
local Nodes = require(CommonMark.node.Nodes)
local _ParserState = require(CommonMark.parser.block.ParserState)
local Scanner = require(CommonMark.parser.beta.Scanner)
local SourceLine = require(CommonMark.parser.SourceLine)

local byte = string.byte
local find = string.find
local gsub = string.gsub
local lower = string.lower
local sub = string.sub

local function isWhitespace(num1: number?): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return num1 == 32 or num1 == 9 or num1 == 10 or num1 == 11 or num1 == 12 or num1 == 13
end

local tbl1 = {
    ["\n"] = true,
    ["\r"] = true,
    ["\r\n"] = true,
    ["\194\133"] = true,
    [" "] = true,
    [" "] = true
}

local function isDollar(str1: string, num1: number) -- Luacid: unused: defined but never referenced
    if num1 == #str1 then
        return true
    end
    if byte(str1, num1 + 1) == 10 and num1 > 0 and byte(str1, num1 - 1 + 1) == 13 then
        return false
    end
    return tbl1[sub(str1, num1 + 1)] == true
end

local function nameAt(str1: string, num1: number) -- Luacid: Inlined by compiler; 1 call site recovered
    local _, var1 = find(str1, "^[A-Za-z0-9]*", num1 + 1)

    return lower((sub(str1, num1 + 1, var1))), var1
end

local tbl2 = { script = true, pre = true, style = true, textarea = true }

local function isType1Opener(str1: string)
    if byte(str1, 1) ~= 60 then
        return false
    end

    local _, var1 = find(str1, "^[A-Za-z0-9]*", 2)

    local var2 = lower((sub(str1, 2, var1)))

    if not tbl2[var2] then
        return false
    end
    local var3 = byte(str1, var1 + 1)
    local bool1 = isWhitespace(var3)

    if not bool1 then
        if var3 == 62 then
            bool1 = true
        else
            if var1 == #str1 then
                return true
            end
            if byte(str1, var1 + 1) == 10 and var1 > 0 and byte(str1, var1 - 1 + 1) == 13 then
                return false
            end
            bool1 = tbl1[sub(str1, var1 + 1)] == true
        end
    end

    return bool1
end

local function findType1Closer(str1: string): boolean
    local var1 = lower(str1)
    return find(var1, "</script>", 1, true) ~= nil
        or find(var1, "</pre>", 1, true) ~= nil
        or find(var1, "</style>", 1, true) ~= nil
        or find(var1, "</textarea>", 1, true) ~= nil
end

local function isType2Opener(str1: string): boolean
    return sub(str1, 1, 4) == "<!--"
end

local function findType2Closer(str1: string): boolean
    return find(str1, "-->", 1, true) ~= nil
end

local function isType3Opener(str1: string): boolean
    return sub(str1, 1, 2) == "<?"
end

local function findType3Closer(str1: string): boolean
    return find(str1, "?>", 1, true) ~= nil
end

local function isType4Opener(str1: string): boolean
    return find(str1, "^<![A-Z]") ~= nil
end

local function findType4Closer(str1: string): boolean
    return find(str1, ">", 1, true) ~= nil
end

local function isType5Opener(str1: string): boolean
    return sub(str1, 1, 9) == "<![CDATA["
end

local function findType5Closer(str1: string): boolean
    return find(str1, "]]>", 1, true) ~= nil
end

local tbl3 = ({})

for _, value in {
    "address",
    "article",
    "aside",
    "base",
    "basefont",
    "blockquote",
    "body",
    "caption",
    "center",
    "col",
    "colgroup",
    "dd",
    "details",
    "dialog",
    "dir",
    "div",
    "dl",
    "dt",
    "fieldset",
    "figcaption",
    "figure",
    "footer",
    "form",
    "frame",
    "frameset",
    "h1",
    "h2",
    "h3",
    "h4",
    "h5",
    "h6",
    "head",
    "header",
    "hr",
    "html",
    "iframe",
    "legend",
    "li",
    "link",
    "main",
    "menu",
    "menuitem",
    "nav",
    "noframes",
    "ol",
    "optgroup",
    "option",
    "p",
    "param",
    "search",
    "section",
    "summary",
    "table",
    "tbody",
    "td",
    "tfoot",
    "th",
    "thead",
    "title",
    "tr",
    "track",
    "ul"
} do
    tbl3[value] = true
end

local var1 = AsciiMatcher.builder():range(65, 90):range(97, 122):build()

local var2 = AsciiMatcher.builder():range(0, 32):anyOf("\"'=<>`"):build()

local _BLOCK_PATTERNS = {
    { opener = isType1Opener, closer = findType1Closer },
    { opener = isType2Opener, closer = findType2Closer },
    { opener = isType3Opener, closer = findType3Closer },
    { opener = isType4Opener, closer = findType4Closer },
    { opener = isType5Opener, closer = findType5Closer },
    {
        opener = function(str1: string) -- name: isType6Opener
            if byte(str1, 1) ~= 60 then
                return false
            end
            local var3, var4 = nameAt(str1, if byte(str1, 2) == 47 then 2 else 1)

            if not tbl3[var3] then
                return false
            end
            local var5 = byte(str1, var4 + 1)
            local bool1 = isWhitespace(var5)

            if not bool1 then
                if var5 == 62 or var5 == 47 and byte(str1, var4 + 1 + 1) == 62 then
                    bool1 = true
                else
                    if var4 == #str1 then
                        return true
                    end
                    if byte(str1, var4 + 1) == 10 and var4 > 0 and byte(str1, var4 - 1 + 1) == 13 then
                        return false
                    end
                    bool1 = tbl1[sub(str1, var4 + 1)] == true
                end
            end

            return bool1
        end,
        closer = nil
    },
    {
        opener = function(str1: string) -- name: isType7Opener
            if byte(str1, 1) ~= 60 then
                return false
            end
            if find(str1, "\0", 1, true) ~= nil then
                str1 = gsub(str1, "%z", "\1")
            end

            local scanner = Scanner.new({ SourceLine.of(str1, nil) }, 0, 1)
            local var3 = scanner:peek()

            if not (if var1:matches(var3) then HtmlInlineParser.tryOpenTag(scanner, var2) else var3 == 47 and HtmlInlineParser.tryClosingTag(scanner)) then
                return false
            end
            scanner:whitespace()
            local index = scanner:position().index

            if index == #str1 then
                return true
            end
            local var4 = index + 1

            if byte(str1, var4) == 10 and index > 0 and byte(str1, index - 1 + 1) == 13 then
                return false
            end
            return tbl1[sub(str1, index + 1)] == true
        end,
        closer = nil
    }
}

local var3 = setmetatable({}, { __index = AbstractBlockParser })
var3.__index = var3

function var3.new(_closingPattern: ((...any) -> (...any))?)
    return (setmetatable(
        {
            _block = Nodes.HtmlBlock(),
            _closingPattern = _closingPattern,
            _finished = false,
            _content = BlockContent.new()
        },
        var3
    ))
end

function var3:getBlock()
    return self._block
end

function var3:tryContinue(arg1)
    if self._finished or arg1:isBlank() and self._closingPattern == nil then
        return BlockContinue.none()
    end

    return BlockContinue.atIndex(arg1:getIndex())
end

function var3:addLine(arg1)
    self._content:add(arg1:getContent())

    local _closingPattern = self._closingPattern
    if _closingPattern ~= nil and _closingPattern(arg1:getContent()) then
        self._finished = true
    end
end

function var3:closeBlock()
    self._block.literal = self._content:getString()
    self._content = nil
end

local Factory = {}
Factory.__index = Factory

function Factory.new()
    return (setmetatable({}, Factory))
end

function Factory.tryStart(_, arg1, arg2)
    local nextNonSpaceIndex = arg1:getNextNonSpaceIndex()
    local content = arg1:getLine():getContent()

    if arg1:getIndent() < 4 and byte(content, nextNonSpaceIndex + 1) == 60 then
        for i = 1, 7 do
            if i == 7
                and (arg2:getMatchedBlockParser():getBlock().kind == "Paragraph"
                    or arg1:getActiveBlockParser():canHaveLazyContinuationLines())
            then
                continue
            end

            local opener = _BLOCK_PATTERNS[i].opener
            local closer = _BLOCK_PATTERNS[i].closer
            if opener((sub(content, nextNonSpaceIndex + 1))) then
                return BlockStart.of(var3.new(closer)):atIndex(arg1:getIndex())
            end
        end
    end
    return BlockStart.none()
end

var3.Factory = Factory

var3._BLOCK_PATTERNS = _BLOCK_PATTERNS

return var3
