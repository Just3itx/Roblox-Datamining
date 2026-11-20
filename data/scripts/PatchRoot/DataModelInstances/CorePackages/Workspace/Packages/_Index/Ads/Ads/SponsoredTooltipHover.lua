-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T21:30:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AdsParent = script:FindFirstAncestor("Ads").Parent
local Cryo = require(AdsParent.Cryo)
local React = require(AdsParent.React)
local useLocalization = require(AdsParent.Localization).Hooks.useLocalization
local IconWithTooltip = require(AdsParent.AppBlox).IconWithTooltip

local function SponsoredTooltipHover(tbl1)
    local var1 = useLocalization({ SponsoredDisclosure = "CoreScripts.Ads.Label.SponsoredAdsDisclosureStatic" })

    return React.createElement(
        IconWithTooltip,
        Cryo.Dictionary.join(tbl1, { hoverText = var1.SponsoredDisclosure, triggerPointName = "SponsoredTooltip" })
    )
end

return SponsoredTooltipHover
