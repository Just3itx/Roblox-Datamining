-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:01:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent

local localizeStrings = require(ServerDrivenUiParent.Localization).localizeStrings
local CloseCentralOverlay = require(ServerDrivenUiParent.CentralOverlay).Thunks.CloseCentralOverlay
local Responsive = require(ServerDrivenUiParent.Responsive)
local GetInputModeStore = Responsive.GetInputModeStore
local OpenInfoPeekView = require(ServerDrivenUiParent.DiscoveryRouting).OpenInfoPeekView
local OpenCloseOnlyInteractiveAlert = require(ServerDrivenUiParent.DiscoveryRouting).OpenCloseOnlyInteractiveAlert

local SduiResponsiveHelpers = require(ServerDrivenUiParent.SduiCoreSystem).SduiResponsiveHelpers

return function(_, _, arg1)
    local dispatch = arg1.dependencies.dispatch
    local localization = arg1.dependencies.localization
    local var1 = localizeStrings(localization, {
        SponsoredDisclosure = "CoreScripts.Ads.Label.SponsoredAdsDisclosureStatic",
        SponsoredTitle = "CoreScripts.Ads.Label.SponsoredAds"
    })

    local var2 = SduiResponsiveHelpers.isPortraitOrientation()
    local var3 = GetInputModeStore(false).getLastInputType(false)
    local sponsoredDisclosure = var1.SponsoredDisclosure
    local sponsoredTitle = var1.SponsoredTitle
    if var3 == Responsive.Input.Touch and var2 then
        dispatch(OpenInfoPeekView(sponsoredTitle, sponsoredDisclosure))
        return
    end
    dispatch(OpenCloseOnlyInteractiveAlert(sponsoredTitle, sponsoredDisclosure, function()
        return dispatch(CloseCentralOverlay())
    end))
end
