-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:01:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local Rodux = require(scriptParentParentParent.Rodux)
local Cryo = require(scriptParentParentParent.Cryo)
local _Types = require(scriptParentParent.Types)

local CapturesRetrieved = require(scriptParentParent.Actions.CapturesRetrieved)
local CaptureManagerClosed = require(scriptParentParent.Actions.CaptureManagerClosed)
local CaptureManagerOpened = require(scriptParentParent.Actions.CaptureManagerOpened)
local UpdateSelectedCaptures = require(scriptParentParent.Actions.UpdateSelectedCaptures)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[CaptureManagerClosed.name] = function(tbl2, _)
    return Cryo.Dictionary.join(tbl2, { IsOpen = false, SelectedCaptures = {} })
end

tbl1[CaptureManagerOpened.name] = function(tbl2, _)
    return Cryo.Dictionary.join(tbl2, { IsOpen = true })
end

tbl1[CapturesRetrieved.name] = function(tbl2, arg1)
    return Cryo.Dictionary.join(tbl2, { IsOpen = tbl2.IsOpen and #arg1.captures > 0, SelectedCaptures = {} })
end

tbl1[UpdateSelectedCaptures.name] = function(tbl2, arg1)
    return Cryo.Dictionary.join(tbl2, { SelectedCaptures = arg1.selectedCaptures })
end

return createReducer({ IsOpen = false, SelectedCaptures = {} }, tbl1)
