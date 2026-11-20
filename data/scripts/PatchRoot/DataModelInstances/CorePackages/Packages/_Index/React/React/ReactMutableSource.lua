-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:11:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local ReactGlobals = require(scriptParentParent.ReactGlobals)
local _Shared = require(scriptParentParent.Shared)

local function createMutableSource(_source, _getVersion)
    local tbl1 = {
        _getVersion = _getVersion,
        _source = _source,
        _workInProgressVersionPrimary = nil,
        _workInProgressVersionSecondary = nil
    }

    if ReactGlobals.__DEV__ then
        tbl1._currentPrimaryRenderer = nil
        tbl1._currentSecondaryRenderer = nil
    end

    return tbl1
end

return createMutableSource
