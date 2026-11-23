-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:20:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommonParent = script:FindFirstAncestor("AvatarExperienceCommon").Parent
local Foundation = require(AvatarExperienceCommonParent.Foundation)
local Responsive = require(AvatarExperienceCommonParent.Responsive)

local useTokens = Foundation.Hooks.useTokens

local function useSelectedOverlayButton(bool1: boolean)
    local var1 = useTokens()
    local var2 = Responsive.useLastInput()
    local var3 = Responsive.useIsSpatial()
    local bool2 = var2 == Responsive.Input.Directional and not var3
    return {
        isVisible = bool1 and not bool2,
        height = var1.Size.Size_700,
        bottomOffset = var1.Gap.XXSmall,
        occupiedHeight = var1.Size.Size_700 + var1.Gap.XXSmall
    }
end

return useSelectedOverlayButton
