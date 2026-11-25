-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T02:11:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PhoneUpsell = script:FindFirstAncestor("PhoneUpsell")
local PhoneUpsellParent = PhoneUpsell.Parent

local React = require(PhoneUpsellParent.React)

local _PhoneVerificationUpsellOverlay = require(PhoneUpsell.Components.PhoneVerificationUpsellOverlay)
local UpsellContainer = require(PhoneUpsell.Components.UpsellContainer)
local PhoneVerificationStatusOverlay = require(PhoneUpsell.Components.PhoneVerificationStatusOverlay)

local Cryo = require(PhoneUpsellParent.Cryo)
local useLocalization = require(PhoneUpsellParent.Localization).Hooks.useLocalization
local mergeProps = require(PhoneUpsell.Utils.mergeProps)
local UIBlox = require(PhoneUpsellParent.UIBlox)
local Images = UIBlox.App.ImageSet.Images
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel

local FFlagFixUpsellVerificationToNavigateToOverlays = require(PhoneUpsell.Flags.FFlagFixUpsellVerificationToNavigateToOverlays)

local tbl1 = {
    onSuccess = function() end,
    closeUpsell = function() end
}

local function PhoneVerificationUpsellOverlayWrapper(arg1)
    local var1 = mergeProps(tbl1, arg1)

    local var2, var3 = React.useState(false)

    local image = React.createElement(
        ImageSetLabel,
        {
            Size = UDim2.fromOffset(40, 40),
            Image = Images["icons/status/success_large"],
            BackgroundTransparency = 1
        }
    )

    local function onSuccess()
        var3(true)
        task.delay(3, function()
            if FFlagFixUpsellVerificationToNavigateToOverlays then
                var1.closeUpsell()
                var1.onSuccess()
                return
            end
            var1.onSuccess()
            var1.closeUpsell()
        end)
    end

    local var4 = useLocalization({ verifySuccessKey = "Feature.VerificationUpsell.Heading.VerifiedSuccessfully.V2" })

    return React.createElement(React.Fragment, nil, {
        PhoneVerificationUpsellOverlay = React.createElement(UpsellContainer, Cryo.Dictionary.join(var1, { onSuccess = onSuccess })),
        SuccessOverlay = var2 and React.createElement(PhoneVerificationStatusOverlay, { image = image, text = var4.verifySuccessKey })
    })
end

return PhoneVerificationUpsellOverlayWrapper
