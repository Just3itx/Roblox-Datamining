-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:40:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AccountUpgradeParent = script:FindFirstAncestor("AccountUpgrade").Parent

local React = require(AccountUpgradeParent.React)
local Foundation = require(AccountUpgradeParent.Foundation)

local View = Foundation.View
local FoundationText = Foundation.Text
local Checkbox = Foundation.Checkbox

local InputSize = Foundation.Enums.InputSize
local StateLayerAffordance = Foundation.Enums.StateLayerAffordance

local function MarketingConsentCheckbox(tbl1)
    local bool1 = tbl1.size == InputSize.Small or tbl1.size == InputSize.XSmall
    local bool2 = tbl1.smallGap == true
    local onToggled = tbl1.onToggled
    local isDisabled = tbl1.isDisabled
    local onActivated = React.useCallback(function(_: boolean)
        onToggled()
    end, { onToggled })
    local var1 = React.useCallback(function()
        if not isDisabled then
            onToggled()
        end
    end, { onToggled, isDisabled })

    return React.createElement(View, {
        tag = {
            ["row align-y-top size-full-0 auto-y"] = true,
            ["gap-small"] = bool2,
            ["gap-medium"] = not bool2
        },
        LayoutOrder = tbl1.LayoutOrder,
        testId = "AccountUpgradeMarketingConsent"
    }, {
        Box = React.createElement(Checkbox, {
            label = "",
            isChecked = tbl1.isChecked,
            isDisabled = isDisabled,
            onActivated = onActivated,
            size = tbl1.size,
            LayoutOrder = 1,
            testId = "AccountUpgradeMarketingConsentBox"
        }),
        Text = React.createElement(View, {
            tag = { ["fill size-full-0 auto-y"] = true, ["padding-top-xxsmall"] = bool1 },
            GroupTransparency = if isDisabled then 0.5 else 0,
            LayoutOrder = 2,
            testId = "AccountUpgradeMarketingConsentText"
        }, {
            Text = React.createElement(FoundationText, {
                Text = tbl1.text,
                tag = {
                    ["size-full-0 auto-y text-wrap text-align-x-left content-emphasis"] = true,
                    ["text-body-small"] = bool1,
                    ["text-body-medium"] = not bool1
                },
                onActivated = var1,
                isDisabled = isDisabled,
                stateLayer = {
                    affordance = StateLayerAffordance.None
                },
                selection = { Selectable = false }
            })
        })
    })
end

return MarketingConsentCheckbox
