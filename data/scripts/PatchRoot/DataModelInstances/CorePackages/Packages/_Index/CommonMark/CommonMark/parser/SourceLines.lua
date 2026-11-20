-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:20:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CommonMark = script:FindFirstAncestor("CommonMark")
local _SourceLine = require(CommonMark.parser.SourceLine)
local _SourceSpan = require(CommonMark.node.SourceSpan)

local module = {}
module.__index = module

function module.new()
    return (setmetatable({ _lines = {} }, module))
end

function module.empty()
    return module.new()
end

function module.of(arg1)
    local module2 = module.new()
    module2:addLine(arg1)
    return module2
end

function module.ofList(tbl1)
    local module2 = module.new()
    table.move(tbl1, 1, #tbl1, 1, module2._lines)
    return module2
end

function module:addLine(arg1)
    table.insert(self._lines, arg1)
end

function module:getLines()
    return self._lines
end

function module:isEmpty(): boolean
    return #self._lines == 0
end

function module:getContent(): string
    local var1 = table.create(#self._lines)
    for i, value in ipairs(self._lines) do
        var1[i] = value:getContent()
    end
    return table.concat(var1, "\n")
end

function module:getSourceSpans()
    local sourceSpans = {}
    for _, value in ipairs(self._lines) do
        local sourceSpan = value:getSourceSpan()
        if sourceSpan ~= nil then
            table.insert(sourceSpans, sourceSpan)
        end
    end
    return sourceSpans
end

return module
