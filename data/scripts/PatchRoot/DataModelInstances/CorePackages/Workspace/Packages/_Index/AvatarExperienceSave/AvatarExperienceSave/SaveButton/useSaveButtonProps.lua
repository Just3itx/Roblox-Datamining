-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:30:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceSave = script:FindFirstAncestor("AvatarExperienceSave")

local AvatarExperienceSaveParent = AvatarExperienceSave.Parent

local React = require(AvatarExperienceSaveParent.React)
local SignalsReact = require(AvatarExperienceSaveParent.SignalsReact)
local AvatarExperienceNavigation = require(AvatarExperienceSaveParent.AvatarExperienceNavigation)
local SlotBasedEditorAnalytics = require(AvatarExperienceSaveParent.AvatarExperienceAnalytics).Surfaces.SlotBasedEditorAnalytics

local SaveStatusEnum = require(AvatarExperienceSave.Enums.SaveStatusEnum)

local useAvatarSaveContext = require(AvatarExperienceSave.Context.useAvatarSaveContext)
local useAvatarRoute = AvatarExperienceNavigation.AvatarRoute.Hooks.useAvatarRoute

local function useSaveButtonProps()
    local var1 = useAvatarRoute()
    local var2 = useAvatarSaveContext()

    local getSaveEligibilityStatusSignal = var2.getSaveEligibilityStatusSignal
    local trySaveAvatar = var2.trySaveAvatar

    local var3 = SignalsReact.useSignalState(getSaveEligibilityStatusSignal)

    local disabled = React.useMemo(function()
        return var3 ~= SaveStatusEnum.Eligible or var1.isOverlayVisible
    end, { var3, var1.isOverlayVisible })

    return {
        disabled = disabled,
        onActivated = React.useCallback(function()
            if not disabled and trySaveAvatar then
                trySaveAvatar()
                SlotBasedEditorAnalytics.trackSaveClick()
            end
        end, { disabled, trySaveAvatar })
    }
end

return useSaveButtonProps
