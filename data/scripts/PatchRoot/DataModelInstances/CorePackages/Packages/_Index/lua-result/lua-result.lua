-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T10:50:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}
module.__index = module

local var1 = newproxy(true)

function module.new(_status: boolean, _value)
    assert(typeof(_status) == "boolean")

    local tbl1 = {
        _source = debug.traceback(),
        [var1] = true,
        _status = _status,
        _value = _value
    }

    setmetatable(tbl1, module)

    return tbl1
end

function module.success(arg1)
    return module.new(true, arg1)
end

function module.error(arg1)
    return module.new(false, arg1)
end

function module.is(arg1)
    return typeof(arg1) == "table" and arg1[var1]
end

function module:match(arg1, arg2)
    assert(
        typeof(arg1) == "function" or typeof(arg1) == "nil",
        string.format("Result:match expects successHandler to be a function or nil, got %s", typeof(arg1))
    )
    assert(
        typeof(arg2) == "function" or typeof(arg2) == "nil",
        string.format("Result:match expects errorHandler to be a function or nil, got %s", typeof(arg2))
    )
    local var2

    if self._status then
        if arg1 == nil then
            return self
        end

        var2 = arg1(self._value)
    else
        if arg2 == nil then
            return self
        end

        var2 = arg2(self._value)
    end

    if module.is(var2) then
        return var2
    end
    return module.success(var2)
end

function module.matchSuccess(arg1, arg2)
    return arg1:match(arg2, nil)
end

function module.matchError(arg1, arg2)
    return arg1:match(nil, arg2)
end

function module:unwrap()
    return self._status, self._value
end

return module
