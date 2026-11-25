-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:41:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialUpsell = script:FindFirstAncestor("SocialUpsell")
local SocialUpsellParent = SocialUpsell.Parent

local SetCentralOverlay = require(SocialUpsellParent.CentralOverlay).Actions.SetCentralOverlay
local SocialUpsellType = require(SocialUpsell.Enum.SocialUpsellType)
local CentralOverlayType = require(SocialUpsellParent.RobloxAppEnums).CentralOverlayType

return function(tbl1)
    return function(arg1)
        arg1:dispatch(
            SetCentralOverlay(
                CentralOverlayType.SocialUpsellOverlay,
                {
                    data = tbl1,
                    upsellType = SocialUpsellType.FacialAgeEstimation
                }
            )
        )
    end
end
