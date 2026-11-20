-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:11:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local scriptParentParent = script.Parent.Parent
if require(scriptParentParent.Flags.FFlagTopBarDeprecateRespawnRodux) then
    return nil
end

local Rodux = require(CorePackages.Packages.Rodux)

local Actions = script.Parent.Parent.Actions

local SetRespawnBehaviour = require(Actions.SetRespawnBehaviour)

local createReducer = Rodux.createReducer

local tbl1 = {}
tbl1[SetRespawnBehaviour.name] = function(_, arg1)
    return {
        enabled = arg1.respawnEnabled,
        customCallback = arg1.customCallback
    }
end

return createReducer({ enabled = true, customCallback = nil }, tbl1)
