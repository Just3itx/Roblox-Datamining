-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:41:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceProfilePictureEditor = script:FindFirstAncestor("AvatarExperienceProfilePictureEditor")
local AvatarExperienceProfilePictureEditorParent = AvatarExperienceProfilePictureEditor.Parent

local React = require(AvatarExperienceProfilePictureEditorParent.React)
local SharedFlags = require(AvatarExperienceProfilePictureEditorParent.SharedFlags)
local useAppPolicy = require(AvatarExperienceProfilePictureEditorParent.UniversalAppPolicy).useAppPolicy

local computeProfileFramesGating = require(AvatarExperienceProfilePictureEditor.Utils.computeProfileFramesGating)
local getProfileFrameAmpAccess = require(AvatarExperienceProfilePictureEditor.Utils.getProfileFrameAmpAccess)

local FFlagEditProfileFramesEnabled = SharedFlags.FFlagEditProfileFramesEnabled

local function useProfileFramesGating()
    local var1 = FFlagEditProfileFramesEnabled
    local plusPurchasingBlocked = useAppPolicy(function(arg1)
        return arg1.getDisableBlackbirdEntrypoints()
    end)

    local var3, var4 = React.useState(nil)
    local isAmpLoading, var6 = React.useState(false)

    local refetchAmpAccess = React.useCallback(function()
        if not var1 then
            var4(nil)
            var6(false)
            return
        end

        var6(true)
        var4(getProfileFrameAmpAccess())
        var6(false)
    end, { var1 })

    React.useEffect(function()
        refetchAmpAccess()
    end, { refetchAmpAccess })

    local access = if var3 then var3.access else nil
    local hasError = if var3 then var3.hasError else false
    local granted = if access then access.granted else false
    local canUpsell = if access then access.canUpsell else false
    local var8 = computeProfileFramesGating(var1, plusPurchasingBlocked, granted, canUpsell, hasError)

    return {
        shouldShowFrames = var8.shouldShowFrames,
        shouldShowUpsell = var8.shouldShowUpsell,
        canEquipFrame = var8.canEquipFrame,
        ampAccessError = var8.ampAccessError,
        plusPurchasingBlocked = plusPurchasingBlocked,
        ampAccess = access,
        isAmpLoading = isAmpLoading,
        refetchAmpAccess = refetchAmpAccess
    }
end

return useProfileFramesGating
