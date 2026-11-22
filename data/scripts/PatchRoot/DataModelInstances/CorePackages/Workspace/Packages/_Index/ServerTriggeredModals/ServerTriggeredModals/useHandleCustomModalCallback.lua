-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T15:50:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerTriggeredModals = script:FindFirstAncestor("ServerTriggeredModals")
local ServerTriggeredModalsParent = ServerTriggeredModals.Parent

local React = require(ServerTriggeredModalsParent.React)
local SocialUpsell = require(ServerTriggeredModalsParent.SocialUpsell)

local CustomModalType = require(ServerTriggeredModals.CustomModalType)
local reportModalImpression = require(ServerTriggeredModals.reportModalImpression)
local sendModalImpressionEvent = require(ServerTriggeredModalsParent.ServerTriggeredModalImpressions).sendModalImpressionEvent

local SocialUpsellType = SocialUpsell.Enums.SocialUpsellType
local UpsellEntrySurfaceType = SocialUpsell.Analytics.Enum.UpsellEntrySurfaceType
local UpsellComponent = SocialUpsell.Analytics.Enum.UpsellComponent
local useSocialUpsellOverlayController = SocialUpsell.Hooks.useSocialUpsellOverlayController

return function<T>(arg1: T, arg2: T)
    local var1 = useSocialUpsellOverlayController(false)

    return React.useCallback(function(arg3)
        if arg3.modalType ~= CustomModalType.SocialFaceAgeEstimationUpsell then
            return
        end

        var1.openSocialOverlay(SocialUpsellType.FacialAgeEstimation, {
            upsellEntrySurface = UpsellEntrySurfaceType.Homepage,
            upsellEntryComponent = UpsellComponent.Modal,
            onMounted = function()
                reportModalImpression(arg2, arg3.modalId, arg3.modalType)
                sendModalImpressionEvent(arg3.modalId, arg3.modalType)
            end
        })
    end, { arg2, arg1, var1.openSocialOverlay })
end
