-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:00:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalog = script:FindFirstAncestor("AvatarExperienceCatalog")
local AvatarExperienceCatalogParent = AvatarExperienceCatalog.Parent

local React = require(AvatarExperienceCatalogParent.React)
local RoactNavigation = require(AvatarExperienceCatalogParent.RoactNavigation)
local useLocalization = require(AvatarExperienceCatalogParent.Localization).Hooks.useLocalization
local withMappedNavigationParams = require(AvatarExperienceCatalogParent.AvatarExperienceNavigation).withMappedNavigationParams
local AXPartialPageModal = require(AvatarExperienceCatalogParent.AvatarExperienceCommon).Components.AXPartialPageModal
local Foundation = require(AvatarExperienceCatalogParent.Foundation)
local View = Foundation.View
local FoundationText = Foundation.Text
local Checkbox = Foundation.Checkbox
local ButtonVariant = Foundation.Enums.ButtonVariant
local InputSize = Foundation.Enums.InputSize
local useMultiItemShoppingFtux = require(AvatarExperienceCatalog.Hooks.useMultiItemShoppingFtux)

return (withMappedNavigationParams(function(tbl1) -- name: WearAvatarReplaceAllItemsPrompt
    local var1 = useLocalization({
        confirmButtonText = "Feature.Catalog.Action.Checkout.Wear",
        cancelButtonText = "Feature.Avatar.Action.Cancel",
        titleText = "Feature.Catalog.Title.Checkout.WearAvatarReplaceAllItemsTitle",
        bodyText = "Feature.Catalog.Label.Checkout.WearAvatarReplaceAllItemsBody",
        checkboxText = "Feature.Catalog.Label.Checkout.DontWarnAgainText"
    })

    local var2 = useMultiItemShoppingFtux()

    local isChecked, var4 = React.useState(false)

    local var5 = React.useCallback(function()
        tbl1.navigation.dispatch(RoactNavigation.Actions.back(nil))

        var2.incrementWearAvatarReplaceAllItemsPromptCount()
    end, { tbl1.navigation })

    local onActivated = React.useCallback(function()
        var5()
        tbl1.onConfirm(isChecked)
    end, { tbl1.onConfirm, var5, isChecked })

    local var7 = React.useCallback(function()
        var5()
    end, { var5 })

    return React.createElement(AXPartialPageModal, {
        onBackgroundPress = var7,
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
                        onActivated = var7,
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
                        LayoutOrder = 1
                    }),
                    PromptBodyText = React.createElement(FoundationText, {
                        tag = "auto-xy padding-bottom-xxlarge text-align-x-left text-truncate-end text-body-large text-wrap",
                        Text = var1.bodyText,
                        LayoutOrder = 2
                    }),
                    DontWarnCheckbox = React.createElement(Checkbox, {
                        isChecked = isChecked,
                        onActivated = function()
                            var4(not isChecked)
                        end,
                        size = InputSize.Medium,
                        label = var1.checkboxText,
                        LayoutOrder = 3
                    })
                }
            )
        }
    end)()))
end))
