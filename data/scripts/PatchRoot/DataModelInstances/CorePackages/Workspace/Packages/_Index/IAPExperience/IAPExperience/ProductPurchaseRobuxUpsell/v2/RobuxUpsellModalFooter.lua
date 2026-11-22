-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:20:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent

local React = require(scriptParentParentParentParent.React)

local Foundation = require(scriptParentParentParentParent.Foundation)
local FoundationText = Foundation.Text
local useTokens = Foundation.Hooks.useTokens

local useLocalization = require(scriptParentParentParentParent.Localization).Hooks.useLocalization

local function RobuxUpsellModalFooter()
    local var1 = useLocalization({
        DisclosurePayment = "IAPExperience.RobuxUpsell.Text.DisclosurePayment",
        DisclosureTerms = "IAPExperience.RobuxUpsell.Text.DisclosureTerms"
    })

    local var2 = useTokens()
    return React.createElement(FoundationText, {
        Text = var1.DisclosurePayment .. " " .. var1.DisclosureTerms,
        tag = "content-muted text-caption-small size-full align-x-center padding-top-small"
    }, {
        UITextSizeConstraint = React.createElement("UITextSizeConstraint", { MaxTextSize = var2.Typography.CaptionSmall.FontSize })
    })
end

return RobuxUpsellModalFooter
