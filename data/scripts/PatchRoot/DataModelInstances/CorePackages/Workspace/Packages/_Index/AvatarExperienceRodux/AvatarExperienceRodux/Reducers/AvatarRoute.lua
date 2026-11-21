-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:20:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceRodux = script:FindFirstAncestor("AvatarExperienceRodux")
local AvatarExperienceRoduxParent = AvatarExperienceRodux.Parent
local Rodux = require(AvatarExperienceRoduxParent.Rodux)

local SetAvatarSceneRoute = require(AvatarExperienceRodux.Actions.SetAvatarSceneRoute)
local var1 = require(AvatarExperienceRoduxParent.AvatarExperienceNavigation).AvatarRoute.AvatarRoute.new({})

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[SetAvatarSceneRoute.name] = function(_, arg1)
    return arg1.avatarRoute
end

return createReducer(var1, tbl1)
