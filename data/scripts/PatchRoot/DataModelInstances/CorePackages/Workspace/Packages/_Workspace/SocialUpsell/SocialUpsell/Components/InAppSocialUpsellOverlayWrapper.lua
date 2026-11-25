-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:31:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialUpsell = script:FindFirstAncestor("SocialUpsell")
local SocialUpsellParent = SocialUpsell.Parent

local Cryo = require(SocialUpsellParent.Cryo)
local React = require(SocialUpsellParent.React)

local SocialUpsellType = require(SocialUpsell.Enum.SocialUpsellType)
local UpsellEntrySurfaceType = require(SocialUpsell.Analytics.Enum.UpsellEntrySurfaceType)
local FAEUpsellOverlay = require(SocialUpsell.Components.FAEUpsellOverlay)

local FFlagEnableAEGIS2CommsFAEUpsell = require(SocialUpsellParent.SharedFlags).FFlagEnableAEGIS2CommsFAEUpsell

local tbl1 = {
    isInExperience = false,
    upsellEntrySurface = UpsellEntrySurfaceType.Unknown,
    upsellType = SocialUpsellType.Unknown
}

return function(tbl2)
    return (React.useMemo(function()
        local element = nil
        local var1 = Cryo.Dictionary.union(tbl1, tbl2.data or {})
        var1.containerRef = tbl2.containerRef

        if not FFlagEnableAEGIS2CommsFAEUpsell then
            var1.isInExperience = false
        end

        if tbl2.upsellType == SocialUpsellType.FacialAgeEstimation then
            element = React.createElement(FAEUpsellOverlay, var1)
        end

        return element
    end, { tbl2.upsellType, tbl2.data }))
end
