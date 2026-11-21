-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:50:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceProfilePictureEditor = script:FindFirstAncestor("AvatarExperienceProfilePictureEditor")
local AvatarExperienceProfilePictureEditorParent = AvatarExperienceProfilePictureEditor.Parent

local AmpUpsell = require(AvatarExperienceProfilePictureEditorParent.AmpUpsell)
local OpenAmpWizardContainer = AmpUpsell.OpenAmpWizardContainer
local AccessResponseEnum = AmpUpsell.AmpEnums.AccessResponseEnum

local RobloxSubscriptionPurchaseApp = require(AvatarExperienceProfilePictureEditorParent.RobloxSubscriptionPurchaseApp)
local SurfaceName = RobloxSubscriptionPurchaseApp.SurfaceName
local SurfaceContext = RobloxSubscriptionPurchaseApp.SurfaceContext
local PurchaseClientSessionIdType = RobloxSubscriptionPurchaseApp.PurchaseClientSessionIdType

local ProfileFrameAmpConstants = require(AvatarExperienceProfilePictureEditor.Common.ProfileFrameAmpConstants)

local function openProfileFramesSubscriptionUpsell(tbl1)
    local dispatch = tbl1.dispatch
    local onGranted = tbl1.onGranted
    local onDenied = tbl1.onDenied

    local purchaseFlowUuid = tbl1.purchaseFlowUuid
    local tbl2 = {
        purchaseUIOptions = { showBackButton = false },
        surfaceName = SurfaceName.ProfileFramesUpsell,
        surfaceContext = SurfaceContext.InApp,
        analyticsContext = purchaseFlowUuid
            and purchaseFlowUuid ~= ""
            and {
                clientSessionId = {
                    clientSessionIdType = PurchaseClientSessionIdType.PurchaseFlowUUID,
                    clientSessionId = purchaseFlowUuid
                }
            }
            or nil
    }

    dispatch(OpenAmpWizardContainer(ProfileFrameAmpConstants.FEATURE_NAME, function(granted, _)
        if granted == AccessResponseEnum.Granted then
            if onGranted then
                onGranted()
            end
        elseif onDenied then
            onDenied()
        end
    end, tbl2, ProfileFrameAmpConstants.ENTRY_POINT_EVENT_CTX, nil, ProfileFrameAmpConstants.NAME_SPACE))
end

return openProfileFramesSubscriptionUpsell
