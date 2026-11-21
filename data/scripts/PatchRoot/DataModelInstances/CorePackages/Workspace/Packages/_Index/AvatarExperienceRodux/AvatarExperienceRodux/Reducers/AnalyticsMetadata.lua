-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:20:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceRodux = script:FindFirstAncestor("AvatarExperienceRodux")
local AvatarExperienceRoduxParent = AvatarExperienceRodux.Parent
local Cryo = require(AvatarExperienceRoduxParent.Cryo)
local Rodux = require(AvatarExperienceRoduxParent.Rodux)

local AddAnalyticsMetadata = require(AvatarExperienceRodux.Actions.AddAnalyticsMetadata)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[AddAnalyticsMetadata.name] = function(tbl2, arg1)
    return Cryo.Dictionary.join(tbl2, arg1.metadata)
end

return createReducer({}, tbl1)
