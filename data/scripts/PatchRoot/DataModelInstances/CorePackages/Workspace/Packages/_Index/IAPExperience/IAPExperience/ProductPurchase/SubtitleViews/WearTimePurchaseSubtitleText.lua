-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:11:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local IAPExperienceParent = script:FindFirstAncestor("IAPExperience").Parent

local React = require(IAPExperienceParent.React)
local Foundation = require(IAPExperienceParent.Foundation)
local useLocalization = require(IAPExperienceParent.Localization).Hooks.useLocalization

local View = Foundation.View
local FoundationText = Foundation.Text
local Icon = Foundation.Icon
local Enums = Foundation.Enums

local function WearTimePurchaseSubtitleText(tbl1)
    local timedOptionDays = tbl1.timedOptionDays

    local var1 = useLocalization({
        timedOptionText = {
            "Feature.Durables.UnifiedBuyModal.Subtitle.TimedOptionText",
            days = timedOptionDays or 0
        },
        infinite = "Feature.Durables.ItemDetails.WearTimeOptions.Button.Infinite"
    })

    local createElement = React.createElement
    local var2 = View
    local tbl2 = { tag = "row auto-xy align-y-center gap-xsmall", LayoutOrder = 2 }

    local tbl3 = {
        ClockIcon = if timedOptionDays then React.createElement(Icon, { LayoutOrder = 1, name = Enums.IconName.Clock, size = Enums.IconSize.Small }) else nil,
        DurationText = React.createElement(FoundationText, {
            LayoutOrder = 2,
            Text = if timedOptionDays and timedOptionDays ~= 0 then var1.timedOptionText else var1.infinite,
            tag = "auto-xy text-title-small content-default"
        })
    }
    return createElement(var2, tbl2, tbl3)
end

return WearTimePurchaseSubtitleText
