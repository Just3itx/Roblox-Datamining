-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:20:57Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local CommonMark = script:FindFirstAncestor("CommonMark")
local Escaping = require(CommonMark.internal.util.Escaping)
local LinkScanner = require(CommonMark.internal.util.LinkScanner)
local Nodes = require(CommonMark.node.Nodes)
local _Position = require(CommonMark.parser.beta.Position)
local Scanner = require(CommonMark.parser.beta.Scanner)
local _SourceLine = require(CommonMark.parser.SourceLine)
local SourceLines = require(CommonMark.parser.SourceLines)
local _SourceSpan = require(CommonMark.node.SourceSpan)

local byte = string.byte
local gsub = string.gsub
local sub = string.sub

local module = {}
module.__index = module

module.State = table.freeze({
    START_DEFINITION = "START_DEFINITION",
    LABEL = "LABEL",
    DESTINATION = "DESTINATION",
    START_TITLE = "START_TITLE",
    TITLE = "TITLE",
    PARAGRAPH = "PARAGRAPH"
})

local State = module.State

function module.new(bool1: boolean?)
    return (setmetatable({
        _state = if bool1 == false then State.PARAGRAPH else State.START_DEFINITION,
        _paragraphLines = {},
        _definitions = {},
        _sourceSpans = {},
        _label = nil,
        _destination = nil,
        _titleDelimiter = 0,
        _title = nil,
        _referenceValid = false
    }, module))
end

function module:parse(arg1)
    table.insert(self._paragraphLines, arg1)
    if self._state == State.PARAGRAPH then
        return
    end

    local var1 = Scanner.of(SourceLines.of(arg1))
    while var1:hasNext() do
        local var2 = nil

        local _state = self._state
        if _state == State.START_DEFINITION then
            var2 = self:startDefinition(var1)
        elseif _state == State.LABEL then
            var2 = self:label(var1)
        elseif _state == State.DESTINATION then
            var2 = self:destination(var1)
        elseif _state == State.START_TITLE then
            var2 = self:startTitle(var1)
        elseif _state == State.TITLE then
            var2 = self:title(var1)
        else
            error(`Unknown parsing state: {_state}`)
        end

        if not var2 then
            self._state = State.PARAGRAPH

            self:finishReference()
            return
        end
    end
end

function module:addSourceSpan(arg1)
    table.insert(self._sourceSpans, arg1)
end

function module:getParagraphLines()
    return SourceLines.ofList(self._paragraphLines)
end

function module:getParagraphSourceSpans()
    return self._sourceSpans
end

function module:getDefinitions()
    self:finishReference()
    return self._definitions
end

function module:getState()
    return self._state
end

local function removeLast(num1: number, tbl1)
    if #tbl1 <= num1 then
        table.clear(tbl1)
        return
    end
    for _ = 0, num1 - 1 do
        table.remove(tbl1)
    end
end

function module:removeLines(num1: number)
    local _sourceSpans = self._sourceSpans

    local var1 = table.freeze(table.move(_sourceSpans, math.max(#_sourceSpans - num1, 0) + 1, #_sourceSpans, 1, {}))
    removeLast(num1, self._paragraphLines)
    removeLast(num1, _sourceSpans)
    return var1
end

function module:startDefinition(arg1): boolean
    self:finishReference()

    arg1:whitespace()
    if not arg1:nextChar(91) then
        return false
    end

    self._state = State.LABEL
    local _label = {}
    self._label = _label

    if not arg1:hasNext() then
        table.insert(_label, "\n")
    end
    return true
end

local function codePointCount(str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
    local _, var1 = gsub(str1, "[^\128-\191]", "")
    return var1
end

function module:label(arg1): boolean
    local var1 = arg1:position()
    if not LinkScanner.scanLinkLabelContent(arg1) then
        return false
    end

    local _label = self._label
    table.insert(_label, arg1:getSource(var1, arg1:position()):getContent())

    if not arg1:hasNext() then
        table.insert(_label, "\n")
        return true
    end

    if not arg1:nextChar(93) then
        return false
    end

    if not arg1:nextChar(58) then
        return false
    end

    local str1 = table.concat(_label)

    if codePointCount(str1) > 999 then
        return false
    end

    if Escaping.normalizeLabelContent(str1) == "" then
        return false
    end

    self._state = State.DESTINATION

    arg1:whitespace()
    return true
end

function module:destination(arg1)
    arg1:whitespace()
    local var1 = arg1:position()
    if not LinkScanner.scanLinkDestination(arg1) then
        return false
    end

    local content = arg1:getSource(var1, arg1:position()):getContent()
    if byte(content, 1) == 60 then
        content = sub(content, 2, #content - 1)
    end

    self._destination = content

    local var2 = arg1:whitespace()
    if not arg1:hasNext() then
        self._referenceValid = true
        table.clear(self._paragraphLines)
    elseif var2 == 0 then
        return false
    end

    self._state = State.START_TITLE
    return true
end

function module:startTitle(arg1): boolean
    arg1:whitespace()
    if not arg1:hasNext() then
        self._state = State.START_DEFINITION
        return true
    end

    self._titleDelimiter = 0
    local _titleDelimiter = arg1:peek()
    if _titleDelimiter == 34 or _titleDelimiter == 39 then
        self._titleDelimiter = _titleDelimiter
    elseif _titleDelimiter == 40 then
        self._titleDelimiter = 41
    end

    if self._titleDelimiter ~= 0 then
        self._state = State.TITLE
        local _title = {}
        self._title = _title
        arg1:next()
        if not arg1:hasNext() then
            table.insert(_title, "\n")
        end
    else
        self._state = State.START_DEFINITION
    end
    return true
end

function module:title(arg1): boolean
    local var1 = arg1:position()
    if not LinkScanner.scanLinkTitleContent(arg1, self._titleDelimiter) then
        self._title = nil
        return false
    end

    local _title = self._title
    table.insert(_title, arg1:getSource(var1, arg1:position()):getContent())

    if not arg1:hasNext() then
        table.insert(_title, "\n")
        return true
    end

    arg1:next()
    arg1:whitespace()
    if arg1:hasNext() then
        self._title = nil
        return false
    end
    self._referenceValid = true
    table.clear(self._paragraphLines)

    self._state = State.START_DEFINITION
    return true
end

function module:finishReference()
    if not self._referenceValid then
        return
    end

    local var1 = Escaping.unescapeString(self._destination)
    local var2 = if self._title == nil then nil else Escaping.unescapeString(table.concat(self._title))
    local var3 = Nodes.LinkReferenceDefinition(table.concat(self._label), var1, var2)
    var3:setSourceSpans(self._sourceSpans)
    table.clear(self._sourceSpans)
    table.insert(self._definitions, var3)

    self._label = nil
    self._referenceValid = false
    self._destination = nil
    self._title = nil
end

return module
