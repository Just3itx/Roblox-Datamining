-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:51:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)
local setTimeout = LuauPolyfill.setTimeout
local clearTimeout = LuauPolyfill.clearTimeout

local tbl1 = {
    runAfterInteractions = function(_, callback: (...any) -> (...any))
        callback()
        return nil
    end
}

local module = ({})
module.__index = module

function module.new(_callback: (...any) -> (...any), _delay: number)
    local self = setmetatable({}, module)
    self._delay = _delay
    self._callback = _callback
    return self
end

function module:dispose(tbl2)
    local var1 = tbl2 or { abort = false }

    if not self._taskHandle then
        return
    end

    self._taskHandle.cancel()
    if not var1.abort then
        self._callback()
    end
    self._taskHandle = nil
end

function module:schedule()
    if self._taskHandle then
        return
    end

    local var1 = setTimeout(function()
        self._taskHandle = tbl1:runAfterInteractions(function()
            self._taskHandle = nil
            self._callback()
        end)
    end, self._delay)

    self._taskHandle = {
        cancel = function()
            return clearTimeout(var1)
        end
    }
end

return module
