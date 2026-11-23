-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:01:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Foundation = require(BuildExperienceParent.Foundation)
local FoundationCloudAssets = require(BuildExperienceParent.FoundationCloudAssets)
local React = require(BuildExperienceParent.React)
local useLocalization = require(BuildExperienceParent.Localization).Hooks.useLocalization
local LocalizationStrings = require(BuildExperience.LocalizationStrings)

local OverflowMenuPageShell = require(BuildExperience.Components.BuildPillMenu.OverflowMenuPageShell)
local ChatActions = require(BuildExperience.Components.Chat.ChatActions)
local FFlagBuildExperienceMonetizationNativeUI = require(BuildExperience.Flags.FFlagBuildExperienceMonetizationNativeUI)
local FFlagBuildExperienceMonetizationMultiKind = require(BuildExperience.Flags.FFlagBuildExperienceMonetizationMultiKind)
local FFlagBuildCheckGamePermissions = require(BuildExperience.Flags.FFlagBuildCheckGamePermissions)
local FFlagBuildExperienceDeveloperProductContext = require(BuildExperience.Flags.FFlagBuildExperienceDeveloperProductContext)
local FFlagBuildExperienceMonetizationPageFixes = require(BuildExperience.Flags.FFlagBuildExperienceMonetizationPageFixes)

local Badge = Foundation.Badge
local Button = Foundation.Button
local Dialog = Foundation.Dialog
local Icon = Foundation.Icon
local IconButton = Foundation.IconButton
local Image = Foundation.Image
local ScrollView = Foundation.ScrollView
local FoundationText = Foundation.Text
local TextArea = Foundation.TextArea
local TextInput = Foundation.TextInput
local Toggle = Foundation.Toggle
local View = Foundation.View
local Menu = Foundation.Menu
local Skeleton = Foundation.Skeleton

local BadgeShape = Foundation.Enums.BadgeShape
local BadgeSize = Foundation.Enums.BadgeSize
local BadgeVariant = Foundation.Enums.BadgeVariant
local ButtonVariant = Foundation.Enums.ButtonVariant
local DialogSize = Foundation.Enums.DialogSize
local FillBehavior = Foundation.Enums.FillBehavior
local IconName = Foundation.Enums.IconName
local IconSize = Foundation.Enums.IconSize
local InputSize = Foundation.Enums.InputSize
local Radius = Foundation.Enums.Radius
local StateLayerAffordance = Foundation.Enums.StateLayerAffordance
local useTokens = Foundation.Hooks.useTokens
local assetId = if FFlagBuildExperienceMonetizationNativeUI then FoundationCloudAssets.Assets["pictograms/robux"].assetId else nil
local uDim2 = UDim2.new(1 / 3, -8, 0, 0)

local function ProductActionsMenu(tbl1)
    local isOpen, var2 = React.useState(false)
    local onPressedOutside = React.useCallback(function()
        var2(false)
    end, {})
    local var4 = useLocalization({ archive = LocalizationStrings.ARCHIVE_GAME_ARCHIVE })
    local items = React.useMemo(function()
        return {
            {
                id = "edit",
                text = tbl1.editLabel,
                icon = IconName.Pencil,
                isDisabled = tbl1.isDisabled
            },
            {
                id = "archive",
                text = var4.archive,
                icon = IconName.TrashCan,
                isDisabled = true
            }
        }
    end, { var4.archive, tbl1.editLabel, tbl1.isDisabled })
    return React.createElement(Menu, {
        align = Foundation.Enums.PopoverAlign.End,
        isOpen = isOpen,
        items = items,
        onActivated = function(arg1)
            onPressedOutside()
            if arg1 == "edit" and not tbl1.isDisabled then
                tbl1.onEdit()
            end
        end,
        onPressedOutside = onPressedOutside,
        side = Foundation.Enums.PopoverSide.Bottom,
        testId = "monetization-product-actions-menu"
    }, {
        Trigger = React.createElement(IconButton, {
            icon = IconName.ThreeDotsHorizontal,
            isCircular = true,
            isDisabled = tbl1.isDisabled,
            onActivated = function()
                var2(not isOpen)
            end,
            size = InputSize.Medium,
            testId = "monetization-product-actions",
            variant = ButtonVariant.Utility
        })
    })
end

local function ProductCard(tbl1)
    local product = tbl1.product
    local var1 = useTokens()
    local image = product.image

    if not image then
        if FFlagBuildExperienceMonetizationNativeUI then
            image = assetId
        else
            image = nil
        end
    end

    local var2 = product.identity or product.id

    local createElement = React.createElement
    local var3 = View
    local tbl2 = {
        LayoutOrder = tbl1.LayoutOrder,
        onActivated = tbl1.onActivated,
        selection = { Selectable = true },
        Size = if tbl1.tileWidth ~= nil then UDim2.new(0, tbl1.tileWidth, 0, 0) else uDim2,
        stateLayer = {
            affordance = StateLayerAffordance.None
        },
        tag = "col auto-y radius-medium",
        testId = `monetization-product-{var2}`
    }
    local tbl3 = { Media = 0, Title = 0, Kind = 0, Metadata = 0 }
    local createElement2 = React.createElement
    local var4 = View
    local tbl4 = { LayoutOrder = 1, Size = 0, aspectRatio = 1, tag = 0 }
    local var5

    if tbl1.tileWidth ~= nil then
        var5 = UDim2.fromOffset(tbl1.tileWidth, tbl1.tileWidth)
    elseif FFlagBuildExperienceMonetizationNativeUI and not FFlagBuildExperienceMonetizationMultiKind then
        var5 = UDim2.fromOffset(var1.Size.Size_2800, var1.Size.Size_2800)
    elseif FFlagBuildExperienceMonetizationMultiKind then
        var5 = UDim2.fromScale(1, 0)
    else
        var5 = UDim2.new(1, 0, 0, 109)
    end

    tbl4.Size = var5

    tbl4.tag = if tbl1.tileWidth == nil then "radius-medium clip bg-surface-200" else "radius-medium clip bg-shift-200"

    local tbl5 = { SaleStatus = 0, Image = 0 }
    local element

    if product.saleStatus == nil
        or not FFlagBuildExperienceMonetizationMultiKind and FFlagBuildExperienceMonetizationNativeUI and product.isForSale ~= true
    then
        element = nil
    else
        element = React.createElement(Badge, {
            Position = UDim2.fromOffset(var1.Gap.Small, var1.Gap.Small),
            shape = BadgeShape.Pill,
            size = BadgeSize.Small,
            text = product.saleStatus,
            testId = `monetization-product-sale-status-{var2}`,
            variant = BadgeVariant.OverMedia,
            ZIndex = 2
        })
    end

    tbl5.SaleStatus = element
    local element2 = if image == nil then nil else React.createElement(Image, {
        Image = image,
        imageStyle = if FFlagBuildExperienceMonetizationNativeUI and product.image == nil then var1.Color.Content.Emphasis else nil,
        ScaleType = Enum.ScaleType.Fit,
        tag = if FFlagBuildExperienceMonetizationNativeUI then "size-full radius-medium" else "size-full",
        testId = `monetization-product-image-{var2}`
    })
    tbl5.Image = element2
    tbl3.Media = createElement2(var4, tbl4, tbl5)

    tbl3.Title = React.createElement(FoundationText, {
        LayoutOrder = 2,
        Text = product.name,
        sizeConstraint = FFlagBuildExperienceMonetizationNativeUI
            and {
                MaxSize = Vector2.new(var1.Size.Size_2800, var1.Size.Size_1000 + var1.Gap.Small)
            }
            or nil,
        tag = {
            ["size-full-0 auto-y padding-top-small text-title-medium text-align-x-left text-truncate-end content-emphasis"] = true,
            ["text-wrap"] = FFlagBuildExperienceMonetizationNativeUI
        },
        testId = if FFlagBuildExperienceMonetizationNativeUI then `monetization-product-title-{var2}` else nil
    })

    tbl3.Kind = if FFlagBuildExperienceMonetizationMultiKind and product.kind ~= nil and tbl1.tileWidth == nil then React.createElement(
        FoundationText,
        {
            LayoutOrder = 3,
            Text = product.kind,
            tag = "size-full-0 auto-y padding-top-xsmall text-body-small text-wrap text-align-x-left content-muted",
            testId = `monetization-product-kind-{var2}`
        }
    ) else nil

    tbl3.Metadata = React.createElement(View, {
        LayoutOrder = 4,
        sizeConstraint = FFlagBuildExperienceMonetizationNativeUI and {
            MaxSize = Vector2.new(var1.Size.Size_2800, math.huge)
        } or nil,
        tag = {
            ["row align-y-center gap-xsmall size-full-0 auto-y"] = true,
            ["padding-top-xsmall"] = FFlagBuildExperienceMonetizationNativeUI
        }
    }, {
        Kind = if FFlagBuildExperienceMonetizationNativeUI or product.kind == nil then nil else React.createElement(
            FoundationText,
            {
                LayoutOrder = 1,
                Text = product.kind,
                tag = "auto-xy text-body-medium content-default"
            }
        ),
        PriceIcon = if FFlagBuildExperienceMonetizationMultiKind and product.showRobuxIcon == false then nil else React.createElement(Icon, { LayoutOrder = 2, name = IconName.Robux, size = IconSize.Small }),
        Price = React.createElement(FoundationText, {
            LayoutOrder = 3,
            Text = product.price,
            tag = if FFlagBuildExperienceMonetizationNativeUI then "fill auto-y text-body-medium text-wrap text-align-x-left content-default" else "auto-xy text-body-medium content-default"
        }),
        Spacer = if FFlagBuildExperienceMonetizationNativeUI then nil else React.createElement(View, { LayoutOrder = 4, tag = "fill" }),
        Age = if FFlagBuildExperienceMonetizationNativeUI or product.age == nil then nil else React.createElement(
            FoundationText,
            {
                LayoutOrder = 5,
                Text = product.age,
                tag = "auto-xy text-body-medium content-default"
            }
        )
    })
    return createElement(var3, tbl2, tbl3)
end

local function ProductRow(tbl1)
    local tbl2 = ({})
    local startIndex = tbl1.startIndex
    local var1 = tbl1.startIndex + 2
    local productsLen = #tbl1.products

    for i = startIndex, math.min(var1, productsLen) do
        local product = tbl1.products[i]
        local var2 = product.identity or product.id
        local createElement = React.createElement
        local func1 = ProductCard
        local tbl3 = {
            LayoutOrder = i - tbl1.startIndex + 1,
            product = product,
            onActivated = 0
        }

        function tbl3.onActivated()
            tbl1.onProductActivated(var2)
        end

        tbl2[var2] = createElement(func1, tbl3)
    end

    return React.createElement(View, { LayoutOrder = tbl1.LayoutOrder, tag = "row gap-medium size-full-0 auto-y" }, tbl2)
end

local function OptionRow(tbl1)
    local createElement = React.createElement
    local var1 = View
    local tbl2 = {
        LayoutOrder = tbl1.LayoutOrder,
        tag = "row align-y-center gap-large size-full-0 auto-y padding-x-large padding-y-medium"
    }
    local tbl3 = {
        Copy = React.createElement(View, {
            LayoutOrder = 1,
            tag = if FFlagBuildExperienceMonetizationNativeUI then "col fill gap-xsmall auto-y" else "col fill gap-xxsmall auto-y"
        }, {
            Title = React.createElement(FoundationText, {
                LayoutOrder = 1,
                Text = tbl1.title,
                tag = {
                    ["size-full-0 auto-y text-title-medium text-align-x-left content-emphasis"] = true,
                    ["text-wrap"] = FFlagBuildExperienceMonetizationNativeUI
                }
            }),
            Description = React.createElement(FoundationText, {
                LayoutOrder = 2,
                Text = tbl1.description,
                tag = "size-full-0 auto-y text-body-medium text-wrap text-align-x-left content-default"
            }),
            Supporting = if tbl1.supportingText == nil then nil else React.createElement(FoundationText, {
                LayoutOrder = 3,
                Text = tbl1.supportingText,
                tag = "size-full-0 auto-y text-body-small text-wrap text-align-x-left content-muted"
            })
        }),
        Toggle = React.createElement(Toggle, {
            LayoutOrder = 2,
            isChecked = tbl1.isChecked,
            isDisabled = tbl1.isDisabled,
            label = "",
            onActivated = tbl1.onActivated,
            size = InputSize.Medium,
            testId = tbl1.testId
        })
    }
    return createElement(var1, tbl2, tbl3)
end

local function OptionsStatusContent(tbl1)
    if tbl1.optionsLoadStatus == "NotReady" then
        return React.createElement(FoundationText, {
            Text = tbl1.labels.loading,
            tag = "size-full-0 auto-y padding-large text-body-medium text-align-x-center content-muted",
            testId = "monetization-options-loading"
        })
    elseif tbl1.optionsLoadStatus == "Failed" then
        return React.createElement(
            View,
            {
                tag = "col align-x-center gap-medium size-full-0 auto-y padding-large",
                testId = "monetization-options-error"
            },
            {
                Message = React.createElement(FoundationText, {
                    LayoutOrder = 1,
                    Text = tbl1.labels.optionsLoadError,
                    tag = "size-full-0 auto-y text-body-medium text-wrap text-align-x-center content-default"
                }),
                Retry = React.createElement(Button, {
                    LayoutOrder = 2,
                    onActivated = tbl1.onRetryOptions,
                    size = InputSize.Medium,
                    text = tbl1.labels.retry,
                    variant = ButtonVariant.Standard
                })
            }
        )
    end
    return nil
end

local function OptionsContent(tbl1)
    local var1 = OptionsStatusContent(tbl1)
    if var1 ~= nil then
        return var1
    end

    local managedPricingSupportingText = tbl1.managedPricingSupportingText

    if not managedPricingSupportingText then
        if tbl1.managedPricingState == "Mixed" then
            managedPricingSupportingText = tbl1.labels.mixed
        elseif tbl1.managedPricingState == "Unavailable" then
            managedPricingSupportingText = tbl1.labels.unavailable
        else
            managedPricingSupportingText = nil
        end
    end

    local tbl2 = {
        actions = {
            {
                text = tbl1.labels.agree,
                variant = ButtonVariant.Emphasis,
                onActivated = tbl1.onConfirmManagedPricing,
                isDisabled = false,
                isLoading = tbl1.isOptionsManagedPricingPending
            },
            {
                text = tbl1.labels.cancel,
                variant = ButtonVariant.Standard,
                onActivated = tbl1.onCancelManagedPricing,
                isDisabled = tbl1.isOptionsManagedPricingPending,
                isLoading = false
            }
        }
    }

    local createElement = React.createElement
    local var2 = View
    local tbl3 = {
        tag = "col gap-xxlarge size-full-0 auto-y padding-y-medium",
        testId = "monetization-options"
    }

    local tbl4 = {
        Permission = if tbl1.canMonetize then nil else React.createElement(FoundationText, {
            LayoutOrder = 1,
            Text = tbl1.labels.permissionDenied,
            tag = "size-full-0 auto-y padding-medium text-body-medium text-wrap radius-medium bg-surface-100 content-default"
        }),
        Pricing = 0,
        Shop = 0,
        Acknowledgement = 0
    }

    local createElement2 = React.createElement
    local var3 = View
    local tbl5 = { LayoutOrder = 2, tag = "col gap-large size-full-0 auto-y" }

    local tbl6 = {
        Header = React.createElement(View, {
            LayoutOrder = 1,
            tag = "col gap-xsmall size-full-0 auto-y"
        }, {
            Title = React.createElement(FoundationText, {
                LayoutOrder = 1,
                Text = tbl1.labels.pricingOptions,
                tag = {
                    ["size-full-0 auto-y text-title-large text-align-x-left content-emphasis"] = true,
                    ["text-wrap"] = FFlagBuildExperienceMonetizationNativeUI
                }
            }),
            Description = React.createElement(FoundationText, {
                LayoutOrder = 2,
                Text = tbl1.labels.pricingOptionsDescription,
                tag = {
                    ["size-full-0 auto-y text-body-small text-align-x-left content-default"] = true,
                    ["text-wrap"] = FFlagBuildExperienceMonetizationNativeUI
                }
            })
        }),
        Rows = React.createElement(
            View,
            {
                LayoutOrder = 2,
                tag = "col size-full-0 auto-y stroke-standard stroke-default radius-large clip"
            },
            {
                ManagedPricing = React.createElement(OptionRow, {
                    LayoutOrder = 1,
                    description = tbl1.labels.managedPricingDescription,
                    isChecked = tbl1.managedPricingState == "AllOn",
                    isDisabled = not tbl1.canChangeManagedPricing or tbl1.isOptionsManagedPricingPending,
                    onActivated = tbl1.onManagedPricingChanged,
                    supportingText = managedPricingSupportingText,
                    testId = "monetization-managed-pricing",
                    title = tbl1.labels.managedPricing
                }),
                Error = if tbl1.managedPricingError == nil then nil else React.createElement(FoundationText, {
                    LayoutOrder = 2,
                    Text = tbl1.managedPricingError,
                    tag = "size-full-0 auto-y padding-x-large padding-bottom-medium text-body-small text-wrap content-alert"
                })
            }
        )
    }
    tbl4.Pricing = createElement2(var3, tbl5, tbl6)

    local createElement3 = React.createElement
    local var4 = View
    local tbl7 = { LayoutOrder = 3, tag = "col gap-large size-full-0 auto-y" }

    local tbl8 = {
        Header = React.createElement(FoundationText, {
            LayoutOrder = 1,
            Text = tbl1.labels.shopUI,
            tag = {
                ["size-full-0 auto-y text-title-large text-align-x-left content-emphasis"] = true,
                ["text-wrap"] = FFlagBuildExperienceMonetizationNativeUI
            }
        }),
        Rows = React.createElement(
            View,
            {
                LayoutOrder = 2,
                tag = "col size-full-0 auto-y stroke-standard stroke-default radius-large clip"
            },
            {
                ShopButton = React.createElement(OptionRow, {
                    LayoutOrder = 1,
                    description = tbl1.labels.shopButtonDescription,
                    isChecked = tbl1.shopButtonEnabled,
                    isDisabled = not tbl1.canMonetize or tbl1.isShopButtonPending,
                    onActivated = tbl1.onShopButtonChanged,
                    testId = "monetization-shop-button",
                    title = tbl1.labels.shopButton
                }),
                Error = if tbl1.shopButtonError == nil then nil else React.createElement(FoundationText, {
                    LayoutOrder = 2,
                    Text = tbl1.shopButtonError,
                    tag = "size-full-0 auto-y padding-x-large padding-bottom-medium text-body-small text-wrap content-alert"
                })
            }
        )
    }
    tbl4.Shop = createElement3(var4, tbl7, tbl8)
    local element

    if tbl1.showManagedPricingAcknowledgement then
        element = React.createElement(Dialog.Root, {
            disablePortal = tbl1.disableDialogPortal == true,
            hasBackdrop = tbl1.disableDialogPortal ~= true,
            size = DialogSize.Small
        }, {
            Title = React.createElement(Dialog.Title, { LayoutOrder = 1, text = tbl1.labels.acknowledgementTitle }),
            Content = React.createElement(
                Dialog.Content,
                { LayoutOrder = 2 },
                {
                    Description = React.createElement(Dialog.Text, { Text = tbl1.labels.acknowledgementDescription })
                }
            ),
            Actions = React.createElement(Dialog.Actions, tbl2)
        })
    else
        element = nil
    end

    tbl4.Acknowledgement = element
    return createElement(var2, tbl3, tbl4)
end

local function ProductCarousel(tbl1)
    local size2800 = useTokens().Size.Size_2800

    local tbl2 = ({})
    for layoutOrder, product in tbl1.products do
        local var1 = product.identity or product.id
        tbl2[var1] = React.createElement(ProductCard, {
            LayoutOrder = layoutOrder,
            product = product,
            tileWidth = size2800,
            onActivated = function()
                tbl1.onProductActivated(var1)
            end
        })
    end

    return React.createElement(ScrollView, {
        LayoutOrder = tbl1.LayoutOrder,
        Size = UDim2.fromScale(1, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        testId = tbl1.testId,
        scroll = {
            AutomaticSize = Enum.AutomaticSize.Y,
            AutomaticCanvasSize = Enum.AutomaticSize.XY,
            CanvasSize = UDim2.new(),
            ScrollingDirection = Enum.ScrollingDirection.X,
            scrollBarVisibility = Foundation.Enums.Visibility.None
        }
    }, {
        Row = React.createElement(View, { tag = "row gap-medium auto-xy" }, tbl2)
    })
end

local tbl1 = {
    GamePass = {
        icon = IconName.Tag,
        title = LocalizationStrings.MONETIZATION_EMPTY_PASSES_TITLE,
        description = LocalizationStrings.MONETIZATION_EMPTY_PASSES_DESCRIPTION
    },
    DeveloperProduct = {
        icon = IconName.ShoppingCart,
        title = LocalizationStrings.MONETIZATION_EMPTY_DEVELOPER_PRODUCTS_TITLE,
        description = LocalizationStrings.MONETIZATION_EMPTY_DEVELOPER_PRODUCTS_DESCRIPTION
    },
    Subscription = {
        icon = IconName.CircleStar,
        title = LocalizationStrings.MONETIZATION_EMPTY_SUBSCRIPTIONS_TITLE,
        description = LocalizationStrings.MONETIZATION_EMPTY_SUBSCRIPTIONS_DESCRIPTION
    }
}

local function EmptyKindCard(tbl2)
    local var1 = tbl1[tbl2.kind]
    local var2 = useLocalization({ title = var1.title, description = var1.description })

    return React.createElement(View, {
        LayoutOrder = tbl2.LayoutOrder,
        tag = "col align-x-center gap-small size-full-0 auto-y padding-large bg-surface-0 stroke-standard stroke-default radius-large",
        testId = `monetization-empty-{tbl2.kind}`
    }, {
        Icon = React.createElement(Icon, { LayoutOrder = 1, name = var1.icon, size = IconSize.XLarge }),
        Title = React.createElement(FoundationText, {
            LayoutOrder = 2,
            Text = var2.title,
            tag = "size-full-0 auto-y text-title-small text-wrap text-align-x-center content-emphasis"
        }),
        Description = React.createElement(FoundationText, {
            LayoutOrder = 3,
            Text = var2.description,
            tag = "size-full-0 auto-y text-body-small text-wrap text-align-x-center content-default"
        })
    })
end

local function KindLoadingTiles(tbl2)
    local var1 = useTokens()
    local size2800 = var1.Size.Size_2800
    local tbl3 = ({})
    for layoutOrder = 1, 3 do
        local str1 = `tile-{layoutOrder}`
        local createElement = React.createElement
        local var2 = View
        local tbl4 = {
            LayoutOrder = layoutOrder,
            Size = UDim2.fromOffset(size2800, 0),
            tag = "col gap-small auto-y"
        }
        local tbl5 = {
            Media = React.createElement(Skeleton, { LayoutOrder = 1, Size = UDim2.fromOffset(size2800, size2800), radius = Radius.Medium }),
            Title = React.createElement(
                Skeleton,
                {
                    LayoutOrder = 2,
                    Size = UDim2.new(0.7, 0, 0, var1.Size.Size_400),
                    radius = Radius.Small
                }
            ),
            Price = React.createElement(
                Skeleton,
                {
                    LayoutOrder = 3,
                    Size = UDim2.new(0.4, 0, 0, var1.Size.Size_300),
                    radius = Radius.Small
                }
            )
        }
        tbl3[str1] = createElement(var2, tbl4, tbl5)
    end

    return React.createElement(View, {
        LayoutOrder = tbl2.LayoutOrder,
        tag = "row gap-medium size-full-0 auto-y clip",
        testId = `monetization-section-loading-{tbl2.kind}`
    }, tbl3)
end

local function getKindProducts(products, productKind: string)
    local kindProducts = {}
    for _, product in products do
        if product.productKind == productKind then
            table.insert(kindProducts, product)
        end
    end
    return kindProducts
end

local function EmptyKindSection(tbl2)
    return React.createElement(View, {
        LayoutOrder = tbl2.LayoutOrder,
        tag = "col gap-medium size-full-0 auto-y",
        testId = `monetization-empty-section-{tbl2.kind}`
    }, {
        Title = React.createElement(FoundationText, {
            LayoutOrder = 1,
            Text = tbl2.label,
            tag = "size-full-0 auto-y text-title-large text-align-x-left content-emphasis",
            testId = `monetization-section-title-{tbl2.kind}`
        }),
        Card = React.createElement(EmptyKindCard, { kind = tbl2.kind, LayoutOrder = 2 })
    })
end

local function KindLoadFailure(tbl2)
    local onRetryCatalogSource = tbl2.page.onRetryCatalogSource
    return React.createElement(View, {
        LayoutOrder = tbl2.LayoutOrder,
        tag = "col gap-small size-full-0 auto-y padding-medium radius-medium bg-surface-100",
        testId = `monetization-catalog-source-{tbl2.kind}`
    }, {
        Message = React.createElement(FoundationText, {
            LayoutOrder = 1,
            Text = tbl2.page.labels.loadErrorDescription,
            tag = "size-full-0 auto-y text-body-medium text-wrap text-align-x-left content-default"
        }),
        Retry = if onRetryCatalogSource == nil then nil else React.createElement(Button, {
            LayoutOrder = 2,
            onActivated = function()
                onRetryCatalogSource(tbl2.kind)
            end,
            size = InputSize.Medium,
            text = tbl2.page.labels.retry,
            variant = ButtonVariant.Standard,
            testId = `monetization-button-retry-{tbl2.kind}`
        })
    })
end

local function hasLoadingSource(catalogSources) -- Luacid: Inlined by compiler; 1 call site recovered
    for _, value in catalogSources do
        if value.status == "NotReady" then
            return true
        end
    end
    return false
end

local function createEmptyKindSection(_, tbl2, layoutOrder: number) -- Luacid: Inlined by compiler; 2 call sites recovered
    return React.createElement(EmptyKindSection, { kind = tbl2.kind, label = tbl2.label, LayoutOrder = layoutOrder })
end

local function GroupedCatalogContent(page)
    local tbl2 = ({})
    local num1 = 0
    local tbl3 = {}
    if page.catalogSources ~= nil then
        local var1 = FFlagBuildExperienceMonetizationPageFixes and hasLoadingSource(page.catalogSources)
        for value, value2 in page.catalogSources do
            local kind = value2.kind
            local products = getKindProducts(page.products, kind)

            local bool1 = FFlagBuildExperienceMonetizationPageFixes

            if bool1 then
                if #products == 0 then
                    bool1 = value2.status == "NotReady"
                else
                    bool1 = false
                end
            end

            local var2 = FFlagBuildExperienceMonetizationPageFixes and value2.status == "Failed"
            if #products ~= 0 or bool1 or var2 then
                num1 += 1
                local tbl4 = {
                    Title = React.createElement(FoundationText, {
                        LayoutOrder = 1,
                        Text = value2.label,
                        tag = "size-full-0 auto-y text-title-large text-align-x-left content-emphasis",
                        testId = `monetization-section-title-{kind}`
                    }),
                    Products = if FFlagBuildExperienceMonetizationPageFixes and #products == 0 then if bool1 then React.createElement(KindLoadingTiles, { kind = kind, LayoutOrder = 2 }) else nil else React.createElement(
                        ProductCarousel,
                        {
                            LayoutOrder = 2,
                            onProductActivated = page.onProductActivated,
                            products = products,
                            testId = `monetization-section-products-{kind}`
                        }
                    ),
                    Failure = if var2 then React.createElement(KindLoadFailure, { page = page, kind = kind, LayoutOrder = 3 }) else nil
                }

                local str1 = `section-{kind}`
                local createElement = React.createElement
                local var3 = View
                local tbl5 = {
                    LayoutOrder = 0,
                    tag = "col gap-medium size-full-0 auto-y",
                    testId = 0
                }

                if not var1 then
                    value = num1
                end

                tbl5.LayoutOrder = value

                tbl5.testId = `monetization-section-{kind}`
                tbl2[str1] = createElement(var3, tbl5, tbl4)
            elseif value2.status == "Ready" and not value2.isIncomplete then
                if var1 then
                    local str1 = `empty-section-{kind}`
                    tbl2[str1] = createEmptyKindSection(nil, value2, value)
                else
                    table.insert(tbl3, value2)
                end
            end
        end
        for _, value in tbl3 do
            num1 += 1
            local str1 = `empty-section-{value.kind}`
            tbl2[str1] = createEmptyKindSection(nil, value, num1)
        end
    end

    return React.createElement(
        View,
        {
            tag = "col gap-large size-full-0 auto-y padding-top-medium",
            testId = "MonetizationPageView"
        },
        tbl2
    )
end

local function CatalogContent(tbl2)
    if FFlagBuildExperienceMonetizationMultiKind and tbl2.catalogSources ~= nil and #tbl2.catalogSources > 0 then
        return React.createElement(GroupedCatalogContent, tbl2)
    end

    local tbl3 = ({})
    local num1 = 0
    for startIndex = 1, #tbl2.products, 3 do
        num1 += 1
        local str1 = `row-{num1}`
        tbl3[str1] = React.createElement(
            ProductRow,
            {
                LayoutOrder = num1,
                onProductActivated = tbl2.onProductActivated,
                products = tbl2.products,
                startIndex = startIndex
            }
        )
    end
    return React.createElement(View, {
        tag = if FFlagBuildExperienceMonetizationNativeUI then "col gap-large size-full-0 auto-y padding-top-medium" else "col gap-large size-full-0 auto-y padding-y-medium",
        testId = "MonetizationPageView"
    }, tbl3)
end

local function EmptyContent(tbl2)
    local var1 = if FFlagBuildExperienceMonetizationNativeUI then useTokens() else nil
    local emphasis = if FFlagBuildExperienceMonetizationNativeUI then var1.Color.Content.Emphasis else nil
    local var2 = if FFlagBuildExperienceMonetizationNativeUI then var1.Config.UI.Scale else 1
    local createElement = React.createElement
    local var3 = View
    local tbl3 = {
        tag = if FFlagBuildExperienceMonetizationNativeUI then "col align-x-center align-y-center size-full auto-y" else "col align-x-center gap-xxlarge size-full-0 auto-y padding-y-medium",
        testId = "MonetizationPageView"
    }

    local tbl4 = {
        Illustration = React.createElement(Image, {
            Image = if FFlagBuildExperienceMonetizationNativeUI then assetId else "rbxasset://textures/ui/LuaApp/graphic/BuildExperience/NativeMonetization/EmptyCatalog.png",
            imageStyle = emphasis,
            LayoutOrder = 1,
            ScaleType = Enum.ScaleType.Fit,
            Size = if FFlagBuildExperienceMonetizationNativeUI then UDim2.fromOffset(320 * var2, 180 * var2) else UDim2.fromOffset(298, 168),
            testId = "monetization-empty-illustration"
        }),
        Copy = React.createElement(View, {
            LayoutOrder = 2,
            tag = if FFlagBuildExperienceMonetizationNativeUI then "col align-x-center size-full-0 auto-y padding-large" else "col align-x-center size-full-0 auto-y"
        }, {
            Title = React.createElement(FoundationText, {
                LayoutOrder = 1,
                Text = tbl2.emptyTitle,
                tag = if FFlagBuildExperienceMonetizationNativeUI then "size-full-0 auto-y text-heading-medium text-wrap text-align-x-center content-emphasis" else "size-full-0 auto-y text-title-medium text-wrap text-align-x-center content-emphasis"
            }),
            Description = React.createElement(FoundationText, {
                LayoutOrder = 2,
                Text = tbl2.emptyDescription,
                tag = if FFlagBuildExperienceMonetizationNativeUI then "size-full-0 auto-y text-body-large text-wrap text-align-x-center content-default" else "size-full-0 auto-y text-body-medium text-wrap text-align-x-center content-default"
            })
        })
    }
    local content = createElement(var3, tbl3, tbl4)

    if not FFlagBuildExperienceMonetizationNativeUI then
        return content
    end

    return React.createElement(ScrollView, {
        tag = "size-full",
        testId = "monetization-empty-scroll",
        scroll = {
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            CanvasSize = UDim2.new(1, 0, 0, 0),
            ScrollingDirection = Enum.ScrollingDirection.Y
        }
    }, { Content = content })
end

local function CatalogStatusContent(tbl2)
    if tbl2.catalogStatus == "NotReady" then
        return React.createElement(FoundationText, {
            Text = tbl2.labels.loading,
            tag = "size-full-0 auto-y padding-large text-body-medium text-align-x-center content-muted",
            testId = "monetization-catalog-loading"
        })
    end

    return React.createElement(
        View,
        {
            tag = "col align-x-center gap-large size-full-0 auto-y padding-large",
            testId = "monetization-catalog-error"
        },
        {
            Copy = React.createElement(View, {
                LayoutOrder = 1,
                tag = "col align-x-center gap-small size-full-0 auto-y"
            }, {
                Title = React.createElement(FoundationText, {
                    LayoutOrder = 1,
                    Text = tbl2.labels.loadErrorTitle,
                    tag = "size-full-0 auto-y text-title-medium text-wrap text-align-x-center content-emphasis"
                }),
                Description = React.createElement(FoundationText, {
                    LayoutOrder = 2,
                    Text = tbl2.labels.loadErrorDescription,
                    tag = "size-full-0 auto-y text-body-medium text-wrap text-align-x-center content-default"
                })
            }),
            Retry = React.createElement(Button, {
                LayoutOrder = 2,
                onActivated = tbl2.onRetryCatalog,
                size = InputSize.Medium,
                text = tbl2.labels.retry,
                variant = ButtonVariant.Standard
            })
        }
    )
end

local function CatalogRefreshWarning(tbl2)
    return React.createElement(View, {
        tag = "col align-x-center gap-medium size-full-0 auto-y padding-medium radius-medium bg-surface-100",
        testId = "monetization-catalog-refresh-error"
    }, {
        Message = React.createElement(FoundationText, {
            LayoutOrder = 1,
            Text = tbl2.labels.loadErrorDescription,
            tag = "size-full-0 auto-y text-body-medium text-wrap text-align-x-center content-default"
        }),
        Retry = React.createElement(Button, {
            LayoutOrder = 2,
            onActivated = tbl2.onRetryCatalog,
            size = InputSize.Medium,
            text = tbl2.labels.retry,
            variant = ButtonVariant.Standard
        })
    })
end

local function CatalogSourcesStatus(tbl2)
    local tbl3 = ({})
    local catalogSources = tbl2.catalogSources
    if catalogSources == nil then
        return nil
    end
    for layoutOrder, value2 in catalogSources do
        if value2.status == "Ready" then
            continue
        end

        local kind = value2.kind
        local createElement = React.createElement
        local var1 = View
        local tbl4 = {
            LayoutOrder = layoutOrder,
            tag = "col gap-small size-full-0 auto-y padding-medium radius-medium bg-surface-100",
            testId = `monetization-catalog-source-{value2.kind}`
        }
        local tbl5 = {
            Label = React.createElement(FoundationText, {
                LayoutOrder = 1,
                Text = value2.label,
                tag = "size-full-0 auto-y text-title-medium text-wrap text-align-x-left content-emphasis"
            }),
            Message = React.createElement(FoundationText, {
                LayoutOrder = 2,
                Text = if value2.status == "Failed" then tbl2.labels.loadErrorDescription else tbl2.labels.loading,
                tag = "size-full-0 auto-y text-body-medium text-wrap text-align-x-left content-default"
            }),
            Retry = 0
        }
        local var2

        if value2.status == "Failed" and tbl2.onRetryCatalogSource ~= nil then
            local createElement2 = React.createElement
            local var3 = Button

            local tbl6 = {
                LayoutOrder = 3,
                onActivated = function()
                    tbl2.onRetryCatalogSource(value2.kind)
                end,
                size = InputSize.Medium,
                text = tbl2.labels.retry,
                variant = ButtonVariant.Standard
            }

            var2 = createElement2(var3, tbl6)
        else
            var2 = nil
        end

        tbl5.Retry = var2
        tbl3[kind] = createElement(var1, tbl4, tbl5)
    end

    return React.createElement(
        View,
        {
            tag = "col gap-medium size-full-0 auto-y",
            testId = "monetization-catalog-sources-status"
        },
        tbl3
    )
end

local function DetailContent(tbl2)
    local emphasis = if FFlagBuildExperienceMonetizationNativeUI then useTokens().Color.Content.Emphasis else nil
    local selectedProduct = tbl2.selectedProduct
    if selectedProduct == nil then
        return React.createElement(View, { tag = "size-full", testId = "MonetizationPageView" })
    end

    local createElement = React.createElement
    local var1 = View
    local tbl3 = {
        tag = "col gap-xxlarge size-full-0 auto-y padding-y-large",
        testId = "MonetizationPageView"
    }

    local tbl4 = { Media = 0, Summary = 0 }
    local createElement2 = React.createElement
    local var2 = View
    local tbl5 = {
        LayoutOrder = 1,
        tag = if FFlagBuildExperienceMonetizationNativeUI then "row align-x-center size-full-0 auto-y padding-y-xlarge radius-medium bg-surface-200" else "row align-x-center size-full-0 auto-y padding-y-medium"
    }

    local tbl6 = { Image = 0 }
    local var3

    if selectedProduct.image == nil and not FFlagBuildExperienceMonetizationNativeUI then
        var3 = nil
    else
        local createElement3 = React.createElement
        local var4 = Image
        local tbl7 = {
            Image = selectedProduct.image or assetId,
            imageStyle = 0,
            ScaleType = 0,
            Size = 0,
            testId = "monetization-detail-image"
        }

        if selectedProduct.image ~= nil then
            emphasis = nil
        end

        tbl7.imageStyle = emphasis
        tbl7.ScaleType = Enum.ScaleType.Fit
        tbl7.Size = UDim2.fromOffset(195, 196)
        var3 = createElement3(var4, tbl7)
    end

    tbl6.Image = var3
    tbl4.Media = createElement2(var2, tbl5, tbl6)

    local createElement3 = React.createElement
    local var4 = View
    local tbl7 = { LayoutOrder = 2, tag = "col gap-xxlarge size-full-0 auto-y" }

    local tbl8 = { Title = 0, Description = 0, SaleStatus = 0, Pricing = 0 }
    local createElement4 = React.createElement
    local var5 = View
    local tbl9 = { LayoutOrder = 1, tag = "col size-full-0 auto-y" }

    local tbl10 = {
        Name = React.createElement(FoundationText, {
            LayoutOrder = 1,
            Text = selectedProduct.name,
            tag = {
                ["size-full-0 auto-y text-heading-small text-align-x-left content-emphasis"] = true,
                ["text-wrap"] = FFlagBuildExperienceMonetizationNativeUI
            }
        }),
        Kind = if FFlagBuildExperienceMonetizationMultiKind and selectedProduct.kind ~= nil then React.createElement(
            FoundationText,
            {
                LayoutOrder = 2,
                Text = selectedProduct.kind,
                tag = "size-full-0 auto-y padding-top-xsmall text-body-medium text-wrap text-align-x-left content-muted",
                testId = "monetization-detail-kind"
            }
        ) else nil,
        Price = React.createElement(View, {
            LayoutOrder = 3,
            tag = "row align-y-center gap-xsmall size-full-0 auto-y"
        }, {
            Icon = if FFlagBuildExperienceMonetizationMultiKind and selectedProduct.showRobuxIcon == false then nil else React.createElement(Icon, { LayoutOrder = 1, name = IconName.Robux, size = IconSize.Small }),
            Value = React.createElement(
                FoundationText,
                {
                    LayoutOrder = 2,
                    Text = selectedProduct.price,
                    tag = "auto-xy text-body-medium content-default"
                }
            )
        }),
        Status = if selectedProduct.canManage == false and selectedProduct.saleStatus ~= nil and tbl2.canChangeSaleStatus ~= true then React.createElement(
            FoundationText,
            {
                LayoutOrder = 4,
                Text = selectedProduct.saleStatus,
                tag = "size-full-0 auto-y padding-top-xsmall text-body-medium text-wrap text-align-x-left content-muted",
                testId = "monetization-detail-sale-status"
            }
        ) else nil
    }
    tbl8.Title = createElement4(var5, tbl9, tbl10)

    tbl8.Description = React.createElement(FoundationText, {
        LayoutOrder = 2,
        Text = selectedProduct.description,
        tag = "size-full-0 auto-y text-body-medium text-wrap text-align-x-left content-default"
    })
    local var6

    if tbl2.canManageProduct or tbl2.canChangeSaleStatus == true then
        local createElement5 = React.createElement
        local var7 = View
        local tbl11 = { LayoutOrder = 3, tag = "col gap-small size-full-0 auto-y" }

        local tbl12 = {
            Row = React.createElement(
                View,
                {
                    LayoutOrder = 1,
                    tag = "row align-y-center gap-large size-full-0 auto-y padding-y-large"
                },
                {
                    Label = React.createElement(FoundationText, {
                        LayoutOrder = 1,
                        Text = tbl2.labels.availableForPurchase,
                        tag = "fill auto-y text-body-medium text-align-x-left content-default"
                    }),
                    Toggle = React.createElement(Toggle, {
                        LayoutOrder = 2,
                        isChecked = selectedProduct.isForSale == true,
                        isDisabled = tbl2.isProductDisabled or tbl2.isProductSaleStatusPending or tbl2.isProductManagedPricingPending,
                        label = "",
                        onActivated = tbl2.onProductSaleStatusChanged,
                        size = InputSize.Medium,
                        testId = "monetization-detail-sale-status"
                    })
                }
            ),
            Error = 0
        }
        local var8

        if tbl2.productSaleStatusError then
            local createElement6 = React.createElement
            local var9 = FoundationText
            local tbl13 = {
                LayoutOrder = 2,
                Text = 0,
                tag = "size-full-0 auto-y text-body-small content-alert",
                testId = "monetization-sale-status-error"
            }
            local productSaleStatusErrorLabel = tbl2.productSaleStatusErrorLabel

            if not productSaleStatusErrorLabel then
                if selectedProduct.priceInRobux == nil then
                    productSaleStatusErrorLabel = tbl2.labels.priceRequiredForSale
                else
                    productSaleStatusErrorLabel = tbl2.labels.updateError
                end
            end

            tbl13.Text = productSaleStatusErrorLabel
            var8 = createElement6(var9, tbl13)
        else
            var8 = nil
        end

        tbl12.Error = var8
        var6 = createElement5(var7, tbl11, tbl12)
    else
        var6 = nil
    end

    tbl8.SaleStatus = var6
    local var7

    if selectedProduct.productKind == nil
        or selectedProduct.productKind == "DeveloperProduct"
        or tbl2.canChangeKindManagedPricing == true
    then
        local createElement5 = React.createElement
        local var8 = View
        local tbl11 = { LayoutOrder = 4, tag = "col size-full-0 auto-y" }

        local tbl12 = {
            Title = React.createElement(FoundationText, {
                LayoutOrder = 1,
                Text = tbl2.labels.pricing,
                tag = "size-full-0 auto-y padding-bottom-small text-heading-small text-align-x-left content-emphasis"
            }),
            Regional = React.createElement(
                View,
                {
                    LayoutOrder = 2,
                    tag = "row align-y-center gap-large size-full-0 auto-y padding-y-large"
                },
                {
                    Label = React.createElement(FoundationText, {
                        LayoutOrder = 1,
                        Text = tbl2.labels.regionalPricing,
                        tag = "fill auto-y text-body-medium text-align-x-left content-default"
                    }),
                    Toggle = React.createElement(Toggle, {
                        LayoutOrder = 2,
                        isChecked = selectedProduct.isManagedPricingEnabled == true,
                        isDisabled = tbl2.isProductDisabled
                            or tbl2.isProductManagedPricingPending
                            or tbl2.isProductSaleStatusPending
                            or not tbl2.canUpdateProductManagedPricing,
                        label = "",
                        onActivated = tbl2.onProductManagedPricingChanged,
                        size = InputSize.Medium,
                        testId = "monetization-detail-managed-pricing"
                    })
                }
            ),
            UpdateError = 0
        }
        local var9

        if tbl2.productManagedPricingError then
            local createElement6 = React.createElement
            local var10 = FoundationText
            local tbl13 = {
                LayoutOrder = 3,
                Text = 0,
                tag = "size-full-0 auto-y text-body-small content-alert",
                testId = "monetization-managed-pricing-error"
            }
            local productManagedPricingErrorLabel = tbl2.productManagedPricingErrorLabel

            if not productManagedPricingErrorLabel then
                if selectedProduct.priceInRobux == nil then
                    productManagedPricingErrorLabel = tbl2.labels.priceRequiredForSale
                else
                    productManagedPricingErrorLabel = tbl2.labels.updateError
                end
            end

            tbl13.Text = productManagedPricingErrorLabel
            var9 = createElement6(var10, tbl13)
        else
            var9 = nil
        end

        tbl12.UpdateError = var9
        var7 = createElement5(var8, tbl11, tbl12)
    else
        var7 = nil
    end

    tbl8.Pricing = var7
    tbl4.Summary = createElement3(var4, tbl7, tbl8)
    return createElement(var1, tbl3, tbl4)
end

local function EditContent(tbl2)
    local var1 = if FFlagBuildExperienceMonetizationNativeUI then useTokens() else nil
    local selectedProduct = tbl2.selectedProduct
    local createElement = React.createElement
    local var2 = View
    local tbl3 = {
        tag = "col gap-xlarge size-full-0 auto-y padding-y-large",
        testId = "monetization-product-edit"
    }

    local tbl4 = { Media = 0, Name = 0, Description = 0, Price = 0, Error = 0 }
    local var3

    if FFlagBuildExperienceMonetizationNativeUI and selectedProduct ~= nil then
        local createElement2 = React.createElement
        local var4 = View
        local tbl5 = {
            LayoutOrder = 0,
            tag = "row align-x-center size-full-0 auto-y padding-y-xlarge radius-medium bg-surface-200"
        }

        local tbl6 = {
            Image = React.createElement(Image, {
                Image = selectedProduct.image or assetId,
                imageStyle = if selectedProduct.image == nil then var1.Color.Content.Emphasis else nil,
                ScaleType = Enum.ScaleType.Fit,
                Size = UDim2.fromOffset(var1.Size.Size_3000, var1.Size.Size_3000),
                testId = "monetization-edit-image"
            })
        }
        var3 = createElement2(var4, tbl5, tbl6)
    else
        var3 = nil
    end

    tbl4.Media = var3

    tbl4.Name = if tbl2.canEditName == false then nil else React.createElement(TextInput, {
        LayoutOrder = 1,
        isDisabled = tbl2.isProductEditPending,
        label = tbl2.labels.name,
        onChanged = tbl2.onEditNameChanged,
        text = tbl2.editName,
        testId = "monetization-edit-name",
        width = UDim.new(1, 0)
    })

    tbl4.Description = React.createElement(TextArea, {
        LayoutOrder = 2,
        isDisabled = tbl2.isProductEditPending,
        label = tbl2.labels.description,
        numLines = 4,
        onChanged = tbl2.onEditDescriptionChanged,
        text = tbl2.editDescription,
        testId = "monetization-edit-description",
        width = UDim.new(1, 0)
    })
    local element

    if tbl2.canEditPrice == false then
        element = nil
    else
        element = React.createElement(TextInput, {
            LayoutOrder = 3,
            isDisabled = tbl2.isProductEditPending,
            label = tbl2.labels.price,
            onChanged = tbl2.onEditPriceChanged,
            text = tbl2.editPrice,
            textInputType = Enum.TextInputType.Number,
            testId = "monetization-edit-price",
            width = UDim.new(1, 0)
        })
    end

    tbl4.Price = element

    tbl4.Error = if tbl2.productEditError == nil then nil else React.createElement(FoundationText, {
        LayoutOrder = 4,
        Text = tbl2.productEditError,
        tag = "size-full-0 auto-y text-body-small text-wrap content-alert",
        testId = "monetization-product-edit-error"
    })
    return createElement(var2, tbl3, tbl4)
end

local function showsPageCreate(tbl2, bool1: boolean): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return not bool1 and (tbl2.mode == "empty" or tbl2.mode == "catalog")
end

local function MonetizationPageView(tbl2)
    local bool1 = tbl2.mode == "detail"
    local bool2 = tbl2.mode == "edit"
    local bool3 = tbl2.mode == "options"
    local bool4 = #tbl2.products > 0
    local bool5 = tbl2.catalogSources ~= nil
    local bool6 = true
    if bool5 then
        for _, value in tbl2.catalogSources do
            if value.status ~= "Ready" then
                bool6 = false
                break
            end
        end
    end

    local bool7 = not (bool1 or bool2 or bool3)

    if bool7 then
        if bool5 then
            bool7 = not (bool6 or bool4)
        elseif tbl2.catalogStatus == "Ready" then
            bool7 = false
        else
            bool7 = not (tbl2.catalogStatus == "Failed" and bool4)
        end
    end

    local bool8 = tbl2.mode == "empty" and not bool7
    local var1 = FFlagBuildExperienceMonetizationPageFixes
        and FFlagBuildExperienceMonetizationMultiKind
        and bool5
        and #tbl2.catalogSources > 0
    local bool9 = not (bool5 or bool1 or bool2 or bool3)

    if bool9 then
        if tbl2.catalogStatus == "Failed" then
            bool9 = bool4
        else
            bool9 = false
        end
    end

    local element

    if bool1 and (tbl2.canManageProduct or tbl2.canEditKindProduct == true) then
        if FFlagBuildExperienceMonetizationNativeUI then
            element = React.createElement(ProductActionsMenu, {
                isDisabled = tbl2.isProductDisabled or tbl2.isProductSaleStatusPending or tbl2.isProductManagedPricingPending,
                editLabel = tbl2.labels.edit,
                onEdit = tbl2.onOpenProductEdit
            })
        else
            element = React.createElement(Button, {
                isDisabled = tbl2.isProductDisabled or tbl2.isProductSaleStatusPending or tbl2.isProductManagedPricingPending,
                onActivated = tbl2.onOpenProductEdit,
                size = InputSize.Medium,
                testId = "monetization-edit-product",
                text = tbl2.labels.edit,
                variant = ButtonVariant.Standard
            })
        end
    elseif bool1 or bool2 or bool3 or bool7 or not tbl2.showOptions then
        element = nil
    else
        element = React.createElement(IconButton, {
            icon = if FFlagBuildExperienceMonetizationNativeUI then IconName.TwoSwitchesHorizontal else IconName.ThreeSlidersHorizontal,
            isCircular = true,
            onActivated = tbl2.onOpenOptions,
            size = InputSize.Medium,
            testId = "monetization-open-options",
            variant = ButtonVariant.Utility
        })
    end

    local element2

    if tbl2.isProductDisabled then
        element2 = React.createElement("CanvasGroup", {
            [React.Tag] = "data-testid=monetization-disabled-detail",
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            GroupTransparency = 0.55,
            Size = UDim2.new(1, 0, 0, 0)
        }, {
            Content = React.createElement(DetailContent, tbl2)
        })
    else
        element2 = React.createElement(DetailContent, tbl2)
    end
    if bool7 then
        if var1 then
            element2 = React.createElement(GroupedCatalogContent, tbl2)
        elseif bool5 then
            element2 = React.createElement(CatalogSourcesStatus, tbl2)
        else
            element2 = React.createElement(CatalogStatusContent, tbl2)
        end
    elseif not bool1 then
        if bool2 then
            element2 = React.createElement(EditContent, tbl2)
        elseif bool3 then
            element2 = React.createElement(OptionsContent, tbl2)
        elseif tbl2.mode == "empty" then
            element2 = React.createElement(EmptyContent, tbl2)
        else
            element2 = React.createElement(CatalogContent, tbl2)
        end
    end

    if bool5 and not var1 and not bool6 and bool4 and not (bool1 or bool2 or bool3) then
        element2 = React.createElement(
            View,
            { tag = "col gap-large size-full-0 auto-y" },
            {
                Status = React.createElement(CatalogSourcesStatus, tbl2),
                Content = element2
            }
        )
    end

    if bool9 then
        element2 = React.createElement(
            View,
            { tag = "col gap-medium size-full-0 auto-y" },
            {
                Warning = React.createElement(CatalogRefreshWarning, tbl2),
                Content = element2
            }
        )
    end

    local bool10 = showsPageCreate(tbl2, bool7)
    local element3

    if bool2 then
        element3 = React.createElement(View, {
            tag = {
                ["row gap-medium size-full-0 auto-y"] = true,
                ["padding-y-medium"] = FFlagBuildExperienceMonetizationNativeUI
            }
        }, {
            Cancel = React.createElement(Button, {
                LayoutOrder = 1,
                fillBehavior = FillBehavior.Fill,
                isDisabled = tbl2.isProductEditPending,
                onActivated = tbl2.onCancelProductEdit,
                size = InputSize.Large,
                testId = "monetization-cancel-product-edit",
                text = tbl2.labels.cancel,
                variant = ButtonVariant.Standard,
                width = UDim.new(0.5, -6)
            }),
            Save = React.createElement(Button, {
                LayoutOrder = 2,
                fillBehavior = FillBehavior.Fill,
                isLoading = tbl2.isProductEditPending,
                onActivated = tbl2.onSaveProductEdit,
                size = InputSize.Large,
                testId = "monetization-save-product-edit",
                text = tbl2.labels.save,
                variant = ButtonVariant.Emphasis,
                width = UDim.new(0.5, -6)
            })
        })
    elseif bool10 then
        local createElement = React.createElement
        local var2 = View
        local tbl3 = {
            tag = {
                ["row align-x-center size-full-0 auto-y"] = true,
                ["padding-y-medium"] = FFlagBuildExperienceMonetizationNativeUI
            }
        }
        local tbl4 = {
            Create = React.createElement(Button, {
                isDisabled = if FFlagBuildExperienceMonetizationMultiKind or FFlagBuildCheckGamePermissions then not tbl2.canCreateProduct else nil,
                onActivated = tbl2.onOpenCreate,
                size = if FFlagBuildExperienceMonetizationNativeUI then InputSize.Large else InputSize.Medium,
                testId = "monetization-create",
                text = tbl2.labels.emptyCreateProduct,
                variant = ButtonVariant.Emphasis,
                width = if FFlagBuildExperienceMonetizationNativeUI then UDim.new(1, 0) else UDim.new(0, 240)
            })
        }
        element3 = createElement(var2, tbl3, tbl4)
    else
        element3 = nil
    end

    if FFlagBuildExperienceDeveloperProductContext and bool1 and tbl2.chatActions ~= nil then
        element3 = React.createElement(
            View,
            { tag = "size-full-0 auto-y padding-y-medium", testId = "monetization-detail-composer" },
            {
                Composer = React.createElement(ChatActions, tbl2.chatActions)
            }
        )
    end
    local page = React.createElement(OverflowMenuPageShell, {
        closeIcon = IconName.ChevronLargeLeft,
        content = element2,
        footer = element3,
        footerDivider = false,
        disableScrolling = FFlagBuildExperienceMonetizationNativeUI and bool8,
        headerTrailing = element,
        onClose = tbl2.onClose,
        testId = "MonetizationPage",
        title = if bool1 then if tbl2.selectedProduct ~= nil then tbl2.selectedProduct.name else tbl2.labels.title elseif bool2 then tbl2.labels.editProduct elseif bool3 then tbl2.labels.options else tbl2.labels.title
    })

    if not FFlagBuildExperienceDeveloperProductContext then
        return page
    end

    return React.createElement(
        View,
        {
            tag = "size-full",
            padding = {
                bottom = UDim.new(0, tbl2.keyboardHeight or 0)
            }
        },
        { Page = page }
    )
end
return MonetizationPageView
