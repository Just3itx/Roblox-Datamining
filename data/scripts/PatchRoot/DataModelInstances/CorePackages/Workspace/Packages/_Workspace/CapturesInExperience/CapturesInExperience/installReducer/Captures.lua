-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:01:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local Rodux = require(scriptParentParentParent.Rodux)

local CapturesRetrieved = require(scriptParentParent.Actions.CapturesRetrieved)
local _Types = require(scriptParentParent.Types)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[CapturesRetrieved.name] = function(_, arg1)
    return arg1.captures
end

return createReducer({}, tbl1)
