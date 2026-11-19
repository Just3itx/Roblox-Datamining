-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:31:08Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local CommonMark = script:FindFirstAncestor("CommonMark")
local SourceSpan = require(CommonMark.node.SourceSpan)

local module = {}
module.__index = module

function module.new()
    return (setmetatable({ _sourceSpans = nil }, module))
end

function module.empty()
    return module.new()
end

function module:getSourceSpans()
    return if self._sourceSpans == nil then {} else self._sourceSpans
end

function module.addAllFrom(arg1, tbl1)
    for _, value in ipairs(tbl1) do
        arg1:addAll(value:getSourceSpans())
    end
end

function module:addAll(tbl1)
    if #tbl1 == 0 then
        return
    end

    if self._sourceSpans == nil then
        self._sourceSpans = {}
    end
    local _sourceSpans = self._sourceSpans

    if #_sourceSpans == 0 then
        table.move(tbl1, 1, #tbl1, 1, _sourceSpans)
        return
    end
    local num1 = #_sourceSpans - 1
    local _sourceSpan = _sourceSpans[num1 + 1]
    local var1 = tbl1[1]
    if _sourceSpan:getInputIndex() + _sourceSpan:getLength() == var1:getInputIndex() then
        _sourceSpans[num1 + 1] = SourceSpan.of(
            _sourceSpan:getLineIndex(),
            _sourceSpan:getColumnIndex(),
            _sourceSpan:getInputIndex(),
            _sourceSpan:getLength() + var1:getLength()
        )
        table.move(tbl1, 2, #tbl1, #_sourceSpans + 1, _sourceSpans)
        return
    end
    table.move(tbl1, 1, #tbl1, #_sourceSpans + 1, _sourceSpans)
end

return module
