-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:01:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local ServerType = require(scriptParentParent.Enums.ServerType)

local Rodux = require(scriptParentParentParent.Rodux)

local ServerTypeDetected = require(scriptParentParent.Actions.ServerTypeDetected)

local StandardServer = ServerType.StandardServer

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[ServerTypeDetected.name] = function(_, tbl2)
    return tbl2.serverType
end

return createReducer(StandardServer, tbl1)
