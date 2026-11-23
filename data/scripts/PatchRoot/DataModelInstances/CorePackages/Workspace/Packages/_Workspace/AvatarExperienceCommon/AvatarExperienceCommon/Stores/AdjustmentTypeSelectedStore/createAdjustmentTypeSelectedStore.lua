-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:41:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommon = script:FindFirstAncestor("AvatarExperienceCommon")
local AvatarExperienceCommonParent = AvatarExperienceCommon.Parent

local _Signals = require(AvatarExperienceCommonParent.Signals)
local createSessionScopedSignal = require(AvatarExperienceCommonParent.SignalsUtils).createSessionScopedSignal
local AdjustmentTypePosition = require(AvatarExperienceCommon.Enums.AdjustmentType).Position

local function createAdjustmentTypeSelectedStore()
    local getAdjustmentTypeSelected, var2 = createSessionScopedSignal(AdjustmentTypePosition)

    return {
        getAdjustmentTypeSelected = getAdjustmentTypeSelected,
        setAdjustmentType = function(arg1)
            var2(arg1)
        end,
        reset = function()
            var2(AdjustmentTypePosition)
        end
    }
end
return createAdjustmentTypeSelectedStore
