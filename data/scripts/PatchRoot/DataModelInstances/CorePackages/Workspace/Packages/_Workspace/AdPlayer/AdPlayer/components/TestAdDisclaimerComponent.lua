-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T05:30:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AdPlayerParent = script:FindFirstAncestor("AdPlayer").Parent
local useLocalization = require(AdPlayerParent.Localization).Hooks.useLocalization
local React = require(AdPlayerParent.React)
local Foundation = require(AdPlayerParent.Foundation)
local useTokens = Foundation.Hooks.useTokens
local FoundationText = Foundation.Text

local tbl1 = {
    eligibleDisclaimer = "CoreScripts.Ads.Label.RewardedVideoEligibleDisclaimer",
    ineligibleDisclaimer = "CoreScripts.Ads.Label.RewardedVideoIneligibleDisclaimer"
}

local function TestAdDisclaimerComponent(tbl2)
    local var1 = useLocalization(tbl1)
    local var2 = useTokens()

    return React.createElement(FoundationText, {
        tag = "bg-over-media-0 padding-medium radius-medium auto-xy text-body-large anchor-top-center",
        Position = UDim2.new(0.5, 0, 0, var2.Gap.XLarge),
        Text = if tbl2.isEligible then var1.eligibleDisclaimer else var1.ineligibleDisclaimer
    })
end

return TestAdDisclaimerComponent
