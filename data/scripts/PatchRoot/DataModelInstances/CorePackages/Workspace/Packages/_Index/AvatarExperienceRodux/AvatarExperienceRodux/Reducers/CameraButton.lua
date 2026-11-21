-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:20:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceRodux = script:FindFirstAncestor("AvatarExperienceRodux")
local AvatarExperienceRoduxParent = AvatarExperienceRodux.Parent
local Cryo = require(AvatarExperienceRoduxParent.Cryo)
local Rodux = require(AvatarExperienceRoduxParent.Rodux)

local _RoduxTypes = require(AvatarExperienceRodux.Types.RoduxTypes)
local SetCameraButtonStatus = require(AvatarExperienceRodux.Actions.SetCameraButtonStatus)
local SetCameraButtonErrorOccurred = require(AvatarExperienceRodux.Actions.SetCameraButtonErrorOccurred)

local createReducer = Rodux.createReducer

local tbl1 = {}
tbl1[SetCameraButtonStatus.name] = function(arg1, arg2)
    return (Cryo.Dictionary.join(arg1, { enabled = arg2.status }))
end

tbl1[SetCameraButtonErrorOccurred.name] = function(arg1, arg2)
    return (Cryo.Dictionary.join(arg1, { errorOccurred = arg2.errorOccurred }))
end

return (createReducer({ enabled = false, errorOccurred = false }, tbl1))
