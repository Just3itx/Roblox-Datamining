-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:40:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local SocialUpsell = script:FindFirstAncestor("SocialUpsell")
local SocialUpsellParent = SocialUpsell.Parent

local React = require(SocialUpsellParent.React)
local CentralOverlay = require(SocialUpsellParent.CentralOverlay)
local RobloxAppEnums = require(SocialUpsellParent.RobloxAppEnums)
local useDispatch = require(SocialUpsellParent.RoactUtils).Hooks.RoactRodux.useDispatch
local FFlagEnableAEGIS2CommsFAEUpsell = require(SocialUpsellParent.SharedFlags).FFlagEnableAEGIS2CommsFAEUpsell

local CentralOverlayType = RobloxAppEnums.CentralOverlayType

local SetCentralOverlay = CentralOverlay.Actions.SetCentralOverlay
local CloseCentralOverlay = CentralOverlay.Thunks.CloseCentralOverlay

local _SocialUpsellType = require(SocialUpsell.Enum.SocialUpsellType)

local getOverlayStore = require(SocialUpsell.Store.getOverlayStore)

local Constants = require(SocialUpsell.Constants)

local Cryo = require(SocialUpsellParent.Cryo)

local overlayStore = if FFlagEnableAEGIS2CommsFAEUpsell then getOverlayStore(false) else nil

return function(isInExperience: boolean)
    local var1 = useDispatch()

    local openSocialOverlay = React.useCallback(function(upsellType, arg1)
        if not isInExperience then
            var1(SetCentralOverlay(CentralOverlayType.SocialUpsellOverlay, { upsellType = upsellType, data = arg1 }))
            return
        end

        if not FFlagEnableAEGIS2CommsFAEUpsell or not overlayStore then
            return
        end

        overlayStore.setCurrentOverlay(
            Constants.OVERLAY_TYPES.SocialUpsell,
            {
                upsellType = upsellType,
                data = Cryo.Dictionary.join(arg1, { isInExperience = isInExperience })
            }
        )
    end, { isInExperience })

    local closeSocialOverlay = React.useCallback(function()
        if isInExperience then
            if FFlagEnableAEGIS2CommsFAEUpsell and overlayStore then
                overlayStore.dismissCurrentOverlay()
            end
        else
            var1(CloseCentralOverlay())
        end
    end, { isInExperience })

    return React.useMemo(function()
        return { openSocialOverlay = openSocialOverlay, closeSocialOverlay = closeSocialOverlay }
    end, { openSocialOverlay, closeSocialOverlay })
end
