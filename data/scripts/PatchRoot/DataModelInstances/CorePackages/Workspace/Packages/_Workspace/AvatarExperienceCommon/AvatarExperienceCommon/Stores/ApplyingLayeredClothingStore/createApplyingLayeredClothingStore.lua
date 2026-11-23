-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:41:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommonParent = script:FindFirstAncestor("AvatarExperienceCommon").Parent

local _Signals = require(AvatarExperienceCommonParent.Signals)
local createSessionScopedSignal = require(AvatarExperienceCommonParent.SignalsUtils).createSessionScopedSignal

local function createApplyingLayeredClothingStore()
    local getApplyingLayeredClothing, var2 = createSessionScopedSignal(false)

    return {
        getApplyingLayeredClothing = getApplyingLayeredClothing,
        startedApplyingLayeredClothing = function()
            var2(true)
        end,
        finishedApplyingLayeredClothing = function()
            var2(false)
        end,
        reset = function()
            var2(false)
        end
    }
end
return createApplyingLayeredClothingStore
