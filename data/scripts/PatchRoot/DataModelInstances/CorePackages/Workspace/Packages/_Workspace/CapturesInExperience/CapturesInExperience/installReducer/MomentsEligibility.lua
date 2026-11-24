-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:01:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local Cryo = require(scriptParentParentParent.Cryo)
local Rodux = require(scriptParentParentParent.Rodux)

local MomentsEligibilityReceived = require(scriptParentParent.Actions.MomentsEligibilityReceived)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[MomentsEligibilityReceived.name] = function(tbl2, arg1)
    local tbl3 = {
        byUniverseId = Cryo.Dictionary.join(tbl2.byUniverseId, { [arg1.universeId] = arg1.isEligible })
    }
    return tbl3
end

return createReducer({ byUniverseId = {} }, tbl1)
