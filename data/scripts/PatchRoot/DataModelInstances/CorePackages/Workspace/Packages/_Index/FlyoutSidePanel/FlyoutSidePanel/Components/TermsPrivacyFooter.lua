-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T13:40:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FlyoutSidePanelParent = script:FindFirstAncestor("FlyoutSidePanel").Parent
local React = require(FlyoutSidePanelParent.React)
local Foundation = require(FlyoutSidePanelParent.Foundation)
local View = Foundation.View
local FoundationText = Foundation.Text
local useLocalization = require(FlyoutSidePanelParent.Localization).Hooks.useLocalization

local FlyoutContentSettings = require(script.Parent.Parent.Config.FlyoutContentSettings)
local useFlyoutItemNavigation = require(script.Parent.Parent.Hooks.useFlyoutItemNavigation)

local function TermsPrivacyFooter(tbl1)
    local var1 = FlyoutContentSettings.ItemInfo[FlyoutContentSettings.ItemType.Terms]
    local var2 = FlyoutContentSettings.ItemInfo[FlyoutContentSettings.ItemType.Privacy]

    local onActivated = useFlyoutItemNavigation(var1, tbl1.closeDrawer)
    local var3 = useFlyoutItemNavigation(var2, tbl1.closeDrawer)

    local var5 = useLocalization({ termsText = var1.textKey, privacyText = var2.textKey })

    return React.createElement(
        View,
        {
            tag = "row align-x-center align-y-center gap-xxlarge size-full-500 padding-x-xlarge",
            LayoutOrder = tbl1.layoutOrder
        },
        {
            Terms = React.createElement(
                View,
                {
                    tag = "auto-xy",
                    onActivated = onActivated,
                    testId = "--core-ui-flyout-terms",
                    LayoutOrder = 1
                },
                {
                    Label = React.createElement(FoundationText, { tag = "auto-xy text-label-medium content-default", Text = var5.termsText })
                }
            ),
            Privacy = React.createElement(
                View,
                {
                    tag = "auto-xy",
                    onActivated = var3,
                    testId = "--core-ui-flyout-privacy",
                    LayoutOrder = 2
                },
                {
                    Label = React.createElement(FoundationText, { tag = "auto-xy text-label-medium content-default", Text = var5.privacyText })
                }
            )
        }
    )
end
return TermsPrivacyFooter
