-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:00:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalogParent = script:FindFirstAncestor("AvatarExperienceCatalog").Parent

local React = require(AvatarExperienceCatalogParent.React)
local BuilderIcons = require(AvatarExperienceCatalogParent.BuilderIcons)
local RoactNavigation = require(AvatarExperienceCatalogParent.RoactNavigation)
local useLocalization = require(AvatarExperienceCatalogParent.Localization).Hooks.useLocalization
local withMappedNavigationParams = require(AvatarExperienceCatalogParent.AvatarExperienceNavigation).withMappedNavigationParams
local AvatarExperienceCommon = require(AvatarExperienceCatalogParent.AvatarExperienceCommon)
local AXPartialPageModal = AvatarExperienceCommon.Components.AXPartialPageModal
local CatalogItemCard = AvatarExperienceCommon.Components.CatalogItemCard.CatalogItemCard
local ItemCardThumbnail = require(AvatarExperienceCatalogParent.AvatarExperienceUIKit).ItemCardComponents.ItemCardThumbnail
local Foundation = require(AvatarExperienceCatalogParent.Foundation)
local View = Foundation.View
local FoundationText = Foundation.Text
local ButtonVariant = Foundation.Enums.ButtonVariant
local InputSize = Foundation.Enums.InputSize
local IconSize = Foundation.Enums.IconSize

local function func1(itemId, thumbType): string -- Luacid: Inlined by compiler; 2 call sites recovered
    return `rbxthumb://type={thumbType}&id={itemId}&w=150&h=150`
end

return (withMappedNavigationParams(function(tbl1) -- name: ItemReplacedOnAvatarPrompt
    local var1 = useLocalization({
        confirmButtonText = "CommonUI.Controls.Action.OK",
        titleText = "Feature.Catalog.Title.Checkout.ItemReplacedOnAvatarTitle",
        bodyText = "Feature.Catalog.Label.Checkout.ItemReplacedOnAvatarBody"
    })

    local var2 = React.useCallback(function()
        tbl1.navigation.dispatch(RoactNavigation.Actions.back(nil))
    end, { tbl1.navigation })

    local var3 = React.useCallback(function()
        var2()
        tbl1.onConfirm()
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
                    GraphicContainer = React.createElement(
                        View,
                        {
                            tag = "row size-full-0 auto-y align-x-center padding-bottom-xxlarge",
                            LayoutOrder = 1
                        },
                        {
                            BeforeItem = React.createElement(CatalogItemCard, {
                                AutomaticSize = Enum.AutomaticSize.XY,
                                LayoutOrder = 1,
                                Selectable = false,
                                presentationSlot = React.createElement(
                                    View,
                                    {
                                        Size = UDim2.fromOffset(80, 80)
                                    },
                                    React.createElement(ItemCardThumbnail, { url = func1(tbl1.beforeItem.itemId, tbl1.beforeItem.thumbType) })
                                )
                            }),
                            ReplaceIcon = React.createElement(
                                View,
                                {
                                    Size = UDim2.fromOffset(60, 80),
                                    LayoutOrder = 2,
                                    tag = "row auto-x auto-y align-x-center align-y-center"
                                },
                                React.createElement(
                                    Foundation.Icon,
                                    {
                                        name = BuilderIcons.Icon.TwoArrowsSpinClockwise,
                                        size = IconSize.Large,
                                        variant = BuilderIcons.IconVariant.Regular
                                    }
                                )
                            ),
                            AfterItem = React.createElement(CatalogItemCard, {
                                AutomaticSize = Enum.AutomaticSize.XY,
                                LayoutOrder = 3,
                                Selectable = false,
                                presentationSlot = React.createElement(
                                    View,
                                    {
                                        Size = UDim2.fromOffset(80, 80)
                                    },
                                    React.createElement(ItemCardThumbnail, { url = func1(tbl1.afterItem.itemId, tbl1.afterItem.thumbType) })
                                )
                            })
                        }
                    ),
                    PromptBodyTitle = React.createElement(FoundationText, {
                        tag = "auto-xy padding-bottom-small padding-top-large text-align-x-left text-heading-small text-wrap",
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
end))
