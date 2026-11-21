-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:00:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalogParent = script:FindFirstAncestor("AvatarExperienceCatalog").Parent

local React = require(AvatarExperienceCatalogParent.React)
local RoactNavigation = require(AvatarExperienceCatalogParent.RoactNavigation)
local useLocalization = require(AvatarExperienceCatalogParent.Localization).Hooks.useLocalization
local withMappedNavigationParams = require(AvatarExperienceCatalogParent.AvatarExperienceNavigation).withMappedNavigationParams
local AXPartialPageModal = require(AvatarExperienceCatalogParent.AvatarExperienceCommon).Components.AXPartialPageModal
local Foundation = require(AvatarExperienceCatalogParent.Foundation)
local View = Foundation.View
local FoundationText = Foundation.Text
local ButtonVariant = Foundation.Enums.ButtonVariant
local InputSize = Foundation.Enums.InputSize

return (withMappedNavigationParams(function(tbl1) -- name: CartUnavailableItemsPrompt
    local var1 = useLocalization({
        confirmButtonText = "Feature.Catalog.Action.Checkout.UnavailableItems",
        titleText = "Feature.Catalog.Title.Checkout.UnavailableItems",
        bodyText = "Feature.Catalog.Message.Checkout.UnavailableItems"
    })

    local var2 = React.useCallback(function()
        tbl1.navigation.dispatch(RoactNavigation.Actions.back(nil))
    end, { tbl1.navigation })

    local var3 = React.useCallback(function()
        var2()
        if tbl1.onConfirm then
            tbl1.onConfirm()
        end
    end, { tbl1.onConfirm, var2 })

    return React.createElement(AXPartialPageModal, {
        onBackgroundPress = var3,
        buttonStackProps = {
            rowLayout = false,
            buttons = {{
                props = {
                    onActivated = var3,
                    text = var1.confirmButtonText,
                    variant = ButtonVariant.Standard,
                    size = InputSize.Medium
                }
            }}
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
                    })
                }
            )
        }
    end)()))
end))
