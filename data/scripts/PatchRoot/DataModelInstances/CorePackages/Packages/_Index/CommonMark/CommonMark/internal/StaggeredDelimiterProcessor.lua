-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:21:10Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local CommonMark = script:FindFirstAncestor("CommonMark")
local _DelimiterProcessor = require(CommonMark.parser.delimiter.DelimiterProcessor)
local _DelimiterRun = require(CommonMark.parser.delimiter.DelimiterRun)

local module = {}
module.__index = module

function module.new(_delim: number)
    return (setmetatable({ _delim = _delim, _minLength = 0, _processors = {}, _rejectsByMultipleOf3Rule = false }, module))
end

function module:getOpeningCharacter()
    return self._delim
end

function module:getClosingCharacter()
    return self._delim
end

function module:getMinLength()
    return self._minLength
end

function module:add(arg1)
    local _minLength = arg1:getMinLength()
    local bool1 = false
    for i, _processor in ipairs(self._processors) do
        local minLength2 = _processor:getMinLength()
        if minLength2 < _minLength then
            table.insert(self._processors, i, arg1)
            bool1 = true
            break
        end

        if _minLength == minLength2 then
            local str1 = string.char(self._delim)
            error(
                `Cannot add two delimiter processors for char '{str1}' and minimum length {_minLength}; ` .. `conflicting processors: {tostring(_processor)}, {tostring(arg1)}`
            )
        end
    end
    if not bool1 then
        table.insert(self._processors, arg1)
        self._minLength = _minLength
    end
    local bool2 = true
    for _, _processor in ipairs(self._processors) do
        if _processor._rejectsByMultipleOf3Rule ~= true then
            bool2 = false
        end
    end

    self._rejectsByMultipleOf3Rule = bool2
end

function module:findProcessor(num1: number)
    for _, _processor in ipairs(self._processors) do
        if _processor:getMinLength() <= num1 then
            return _processor
        end
    end
    return self._processors[1]
end

function module.process(arg1, arg2, arg3)
    return arg1:findProcessor(arg2:length()):process(arg2, arg3)
end

return module
