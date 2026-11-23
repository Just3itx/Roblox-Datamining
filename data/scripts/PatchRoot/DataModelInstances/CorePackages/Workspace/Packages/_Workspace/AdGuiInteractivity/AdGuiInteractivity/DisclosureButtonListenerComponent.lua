-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T05:11:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AdService = game:GetService("AdService")

local AdGuiInteractivity = script:FindFirstAncestor("AdGuiInteractivity")
local AdGuiInteractivityParent = AdGuiInteractivity.Parent
local React = require(AdGuiInteractivityParent.React)
local t = require(AdGuiInteractivityParent.t)

local getScreenPositionFromGuiObjectInput = require(AdGuiInteractivity.getScreenPositionFromGuiObjectInput)
local ImmersiveBrandedAdMenu = require(AdGuiInteractivity.ImmersiveBrandedAdMenu)
local AdsInteractivityTelemetry = require(AdGuiInteractivity.AdsInteractivityTelemetry)

local var1 = t.interface({
    disclosureButton = t.instanceIsA("GuiButton"),
    inputObject = t.instanceIsA("InputObject"),
    advertiserName = t.string,
    campaignId = t.string,
    immersiveBrandedAdId = t.string
})

return function()
    local var2, var3 = React.useState(nil)

    React.useEffect(function()
        function AdService.OnImmersiveBrandedAdDisclosureButtonActivated(data)
            local var4, _ = var1(data)
            if not var4 then
                return
            end

            AdsInteractivityTelemetry.logImmersiveBrandedAdButtonClickCounter("disclosure")
            var3({
                menuScreenPosition = getScreenPositionFromGuiObjectInput(data.disclosureButton, data.inputObject),
                advertiserName = data.advertiserName,
                campaignId = data.campaignId,
                immersiveBrandedAdId = data.immersiveBrandedAdId
            })
        end

        return function()
            function AdService.OnImmersiveBrandedAdDisclosureButtonActivated() end
        end
    end, {})

    local onDismiss = React.useCallback(function()
        var3(nil)
    end, {})

    if not var2 then
        return nil
    end

    return React.createElement(ImmersiveBrandedAdMenu, {
        screenPosition = var2.menuScreenPosition,
        advertiserName = var2.advertiserName,
        campaignId = var2.campaignId,
        immersiveBrandedAdId = var2.immersiveBrandedAdId,
        onDismiss = onDismiss
    })
end
