-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:31:27Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local module = {}
module.__index = module

local function new(_newIndex: number, _newColumn: number, _finalize: boolean) -- Luacid: Inlined by compiler; 3 call sites recovered
    return (setmetatable({ _newIndex = _newIndex, _newColumn = _newColumn, _finalize = _finalize }, module))
end

function module.none()
    return nil
end

function module.atIndex(_newIndex: number)
    return (new(_newIndex, -1, false))
end

function module.atColumn(_newColumn: number)
    return (new(-1, _newColumn, false))
end

function module.finished()
    return (new(-1, -1, true))
end

function module:getNewIndex()
    return self._newIndex
end

function module:getNewColumn()
    return self._newColumn
end

function module:isFinalize()
    return self._finalize
end

return module
