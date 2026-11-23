-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T16:51:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceModelParent = script:FindFirstAncestor("AvatarExperienceModel").Parent

local _Signals = require(AvatarExperienceModelParent.Signals)
local createSessionScopedSignal = require(AvatarExperienceModelParent.SignalsUtils).createSessionScopedSignal
local AvatarScreen = require(AvatarExperienceModelParent.AvatarExperienceNavigation).Enums.AvatarScreen

local function createLayeredClothingEntryPageStore()
    local getEntryPage, var2 = createSessionScopedSignal(AvatarScreen.None)

    return {
        getEntryPage = getEntryPage,
        setEntryPage = function(str1: string)
            var2(str1)
        end,
        reset = function()
            var2(AvatarScreen.None)
        end
    }
end
return createLayeredClothingEntryPageStore
