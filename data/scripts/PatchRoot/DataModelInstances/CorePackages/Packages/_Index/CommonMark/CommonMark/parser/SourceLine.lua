-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:40:43Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local CommonMark = script:FindFirstAncestor("CommonMark")
local SourceSpan = require(CommonMark.node.SourceSpan)

local sub = string.sub

local module = {}
module.__index = module

local function new(_content: string, _sourceSpan) -- Luacid: Inlined by compiler; 1 call site recovered
    return (setmetatable({ _content = _content, _sourceSpan = _sourceSpan }, module))
end

function module.of(_content: string, _sourceSpan)
    return (new(_content, _sourceSpan))
end

function module:getContent()
    return self._content
end

function module:getSourceSpan()
    return self._sourceSpan
end

function module:substring(num1: number, num2: number)
    local _content = self._content

    if num1 < 0 or num2 < num1 or #_content < num2 then
        error(`begin {num1}, end {num2}, length {#_content}`)
    end
    local var1 = sub(_content, num1 + 1, num2)
    local var2 = nil
    local _sourceSpan = self._sourceSpan
    if _sourceSpan ~= nil then
        local num3 = num2 - num1
        if num3 ~= 0 then
            local var3 = _sourceSpan:getColumnIndex() + num1
            local var4 = _sourceSpan:getInputIndex() + num1
            var2 = SourceSpan.of(_sourceSpan:getLineIndex(), var3, var4, num3)
        end
    end
    return module.of(var1, var2)
end

return module
