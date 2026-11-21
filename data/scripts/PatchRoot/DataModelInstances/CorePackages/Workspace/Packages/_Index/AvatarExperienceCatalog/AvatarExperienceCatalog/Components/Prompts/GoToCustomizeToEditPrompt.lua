-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:00:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalogParent = script:FindFirstAncestor("AvatarExperienceCatalog").Parent

local React = require(AvatarExperienceCatalogParent.React)
local RoactNavigation = require(AvatarExperienceCatalogParent.RoactNavigation)
local useLocalization = require(AvatarExperienceCatalogParent.Localization).Hooks.useLocalization
local AXPartialPageModal = require(AvatarExperienceCatalogParent.AvatarExperienceCommon).Components.AXPartialPageModal
local Foundation = require(AvatarExperienceCatalogParent.Foundation)
local View = Foundation.View
local FoundationText = Foundation.Text
local ButtonVariant = Foundation.Enums.ButtonVariant
local InputSize = Foundation.Enums.InputSize

local function GoToCustomizeToEditPrompt(tbl1)
    local var1 = useLocalization({
        confirmButtonText = "Feature.Catalog.Action.Checkout.GoToCustomize",
        cancelButtonText = "Feature.Avatar.Action.Stay",
        titleText = "Feature.Catalog.Title.Checkout.GoToCustomizeTitle",
        bodyText = "Feature.Catalog.Label.Checkout.GoToCustomizeBody"
    })

    local var2 = React.useCallback(function()
        tbl1.navigation.dispatch(RoactNavigation.Actions.back(nil))
    end, { tbl1.navigation })

    local onActivated = React.useCallback(function()
        var2()
        tbl1.onConfirm()
    end, { tbl1.onConfirm, var2 })

    local var4 = React.useCallback(function()
        var2()
    end, { var2 })

    return React.createElement(AXPartialPageModal, {
        onBackgroundPress = var4,
        buttonStackProps = {
            rowLayout = false,
            buttons = {
                {
                    props = {
                        onActivated = onActivated,
                        text = var1.confirmButtonText,
                        variant = ButtonVariant.Emphasis,
                        size = InputSize.Medium
                    }
                },
                {
                    props = {
                        onActivated = var4,
                        text = var1.cancelButtonText,
                        variant = ButtonVariant.Standard,
                        size = InputSize.Medium
                    }
                }
            }
        }
    }, ((function()
        return {
            ViewFrame = React.createElement(
                View,
                { tag = "auto-y size-full-0 padding-bottom-xxlarge col align-x-left align-y-top" },
                {
                    PromptBodyTitle = React.createElement(FoundationText, {
                        tag = "auto-xy padding-bottom-small text-align-x-left text-heading-small text-wrap",
                        Text = var1.titleText,
                        LayoutOrder = 2
                    }),
                    PromptBodyText = React.createElement(
                        FoundationText,
                        {
                            tag = "auto-xy text-align-x-left text-truncate-end text-body-large text-wrap",
                            Text = var1.bodyText,
                            LayoutOrder = 3
                        }
                    )
                }
            )
        }
    end)()))
end

return GoToCustomizeToEditPrompt
