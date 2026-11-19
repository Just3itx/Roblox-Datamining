-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:20:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Cryo = require(CorePackages.Packages.Cryo)
local Rodux = require(CorePackages.Packages.Rodux)
local scriptParentParent = script.Parent.Parent
local SetExperienceInfo = require(scriptParentParent.Actions.SetExperienceInfo)

local createReducer = Rodux.createReducer
local tbl1 = {}

tbl1[SetExperienceInfo.name] = function(arg1, arg2)
    local experienceInfo = arg2.experienceInfo
    local universeId = experienceInfo.universeId
    assert(universeId ~= nil, "Expected a universe id when setting an experiences's information.")

    local var1 = arg1[universeId] or {}
    local var2 = Cryo.Dictionary.join(var1, experienceInfo)
    return Cryo.Dictionary.join(arg1, { [universeId] = var2 })
end

return createReducer({}, tbl1)
