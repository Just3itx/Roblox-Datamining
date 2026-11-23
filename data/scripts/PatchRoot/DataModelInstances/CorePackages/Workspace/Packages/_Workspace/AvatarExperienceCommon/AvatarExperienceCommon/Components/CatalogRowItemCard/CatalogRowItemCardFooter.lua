-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:20:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommon = script:FindFirstAncestor("AvatarExperienceCommon")
local AvatarExperienceCommonParent = AvatarExperienceCommon.Parent
local React = require(AvatarExperienceCommonParent.React)
local Foundation = require(AvatarExperienceCommonParent.Foundation)
local useTokens = Foundation.Hooks.useTokens
local FoundationText = Foundation.Text
local VerifiedBadges = require(AvatarExperienceCommonParent.VerifiedBadges)
local AvatarExperienceUIKit = require(AvatarExperienceCommonParent.AvatarExperienceUIKit)
local ItemCardPriceLine = AvatarExperienceUIKit.ItemCardComponents.ItemCardPriceLine
local ItemCardTitle = AvatarExperienceUIKit.ItemCardComponents.ItemCardTitle
local Cryo = require(AvatarExperienceCommonParent.Cryo)
local _TimedOptionType = require(AvatarExperienceCommon.Types.TimedOptionType)

local AvatarExperienceFlags = require(AvatarExperienceCommonParent.AvatarExperienceFlags)
local FFlagAXEnableTimedOptionsForCatalogRowCard = AvatarExperienceFlags.FFlagAXEnableTimedOptionsForCatalogRowCard
local FFlagAXDurablesForMIS = AvatarExperienceFlags.FFlagAXDurablesForMIS
local FFlagAXMISSmallUIChanges = AvatarExperienceFlags.FFlagAXMISSmallUIChanges
local FFlagAXMISWithOffers = AvatarExperienceFlags.FFlagAXMISWithOffers
local FFlagAXDurables2Option = AvatarExperienceFlags.FFlagAXDurables2Option
local FFlagAXGifting = AvatarExperienceFlags.FFlagAXGifting
local FFlagAXMISOffersChip = AvatarExperienceFlags.FFlagAXMISOffersChip

local Icon = Foundation.Icon
local IconSize = Foundation.Enums.IconSize

local function CatalogRowItemCardFooter(tbl1)
    local var1 = useTokens()

    local selectedTimedOptionPrice = nil
    local setSelectedTimedOptionPrice = nil
    if FFlagAXDurablesForMIS or FFlagAXEnableTimedOptionsForCatalogRowCard then
        selectedTimedOptionPrice = tbl1.selectedTimedOptionPrice
        setSelectedTimedOptionPrice = tbl1.setSelectedTimedOptionPrice
    end

    local var2 = React.useMemo(function()
        local result = ({})
        if tbl1.priceLineContent and #tbl1.priceLineContent > 0 then
            for layoutOrder, value2 in tbl1.priceLineContent do
                local var2 = Cryo.Dictionary.omit(value2, { "strikethrough" })

                if (FFlagAXDurablesForMIS or FFlagAXEnableTimedOptionsForCatalogRowCard)
                    and selectedTimedOptionPrice
                    and value2.type == "price"
                then
                    if value2.isOriginalPrice and tbl1.timedOptions then
                        local var3 = selectedTimedOptionPrice

                        for _, timedOption in tbl1.timedOptions do
                            if timedOption.price ~= selectedTimedOptionPrice or not timedOption.discountInformation then
                                continue
                            end
                            var3 = timedOption.discountInformation.originalPrice
                            break
                        end

                        var2 = Cryo.Dictionary.join(var2, { price = var3 })

                        if var3 == selectedTimedOptionPrice
                            and (not FFlagAXMISWithOffers or FFlagAXMISWithOffers and not value2.shouldShowOriginalPrice)
                        then
                            continue
                        end
                    else
                        var2 = Cryo.Dictionary.join(var2, { price = selectedTimedOptionPrice })
                    end
                end

                if FFlagAXMISWithOffers and value2.priceInRobuxDiscountedByOffers then
                    var2 = Cryo.Dictionary.join(var2, { price = value2.priceInRobuxDiscountedByOffers })
                end

                if (FFlagAXDurablesForMIS or FFlagAXEnableTimedOptionsForCatalogRowCard) and value2.strikethrough then
                    var2 = Cryo.Dictionary.join(
                        var2,
                        {
                            colorStyle = var1.Color.Content.Muted,
                            iconSize = IconSize.XSmall,
                            fontStyle = var1.Typography.BodySmall
                        }
                    )
                end
                local str1 = `PriceLine{layoutOrder}`
                local createElement = React.createElement
                local view = Foundation.View
                local tbl2 = { tag = "auto-xy", LayoutOrder = layoutOrder }
                local tbl3 = {
                    ItemCardPriceLine = React.createElement(ItemCardPriceLine, { content = var2 }),
                    Strikethrough = if value2.strikethrough then React.createElement(Foundation.View, {
                        tag = "bg-system-neutral anchor-center-center position-center-center size-full-50",
                        Size = if FFlagAXMISSmallUIChanges then UDim2.new(1, 0, 0, 1) else nil
                    }) else nil
                }
                result[str1] = createElement(view, tbl2, tbl3)
            end
        end

        return result
    end, {
        tbl1.priceLineContent,
        if FFlagAXDurablesForMIS or FFlagAXEnableTimedOptionsForCatalogRowCard then selectedTimedOptionPrice else nil,
        if FFlagAXDurablesForMIS or FFlagAXEnableTimedOptionsForCatalogRowCard then tbl1.timedOptions else nil,
        if FFlagAXDurablesForMIS or FFlagAXEnableTimedOptionsForCatalogRowCard then var1 else nil
    })

    local var3 = if FFlagAXDurablesForMIS or FFlagAXEnableTimedOptionsForCatalogRowCard then if tbl1.priceLineContent and #tbl1.priceLineContent > 0 then true else tbl1.timedOptions else nil
    local createElement = React.createElement
    local view = Foundation.View
    local tbl2 = {
        Size = tbl1.Size,
        AutomaticSize = tbl1.AutomaticSize,
        LayoutOrder = tbl1.LayoutOrder,
        tag = "fill self-stretch"
    }
    local tbl3 = { TopSection = 0, BottomPrice = 0, BottomContent = 0 }
    local var4 = if FFlagAXGifting then tbl1.onRemove or tbl1.giftButton else FFlagAXDurables2Option and tbl1.onRemove
    local var5

    if var4 then
        local createElement2 = React.createElement
        local view2 = Foundation.View
        local tbl4 = { tag = "row size-full-0 auto-y" }

        local tbl5 = { Left = 0, Right = 0 }
        local createElement3 = React.createElement
        local view3 = Foundation.View
        local tbl6 = {
            tag = "col align-x-left fill gap-xsmall size-full-0 auto-y",
            LayoutOrder = 1
        }

        local tbl7 = {
            ItemCardFooterTitle = React.createElement(ItemCardTitle, { title = tbl1.title or "", LayoutOrder = 1 }),
            ItemCardFooterInfo = 0,
            BundleParts = 0
        }
        local var6

        if tbl1.itemSubType or tbl1.creatorName then
            local createElement4 = React.createElement
            local view4 = Foundation.View
            local tbl8 = {
                tag = "row align-x-left gap-xxsmall size-full-0 auto-y",
                LayoutOrder = 2
            }

            local tbl9 = { ItemSubType = 0, Spacer = 0, Divider = 0, CreatorName = 0 }
            local element

            if tbl1.itemSubType then
                element = React.createElement(FoundationText, {
                    textStyle = var1.Color.Content.Default,
                    fontStyle = var1.Typography.BodyMedium,
                    LayoutOrder = 1,
                    Text = tbl1.itemSubType,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    AutomaticSize = Enum.AutomaticSize.XY,
                    TextTruncate = Enum.TextTruncate.SplitWord
                })
            else
                element = nil
            end

            tbl9.ItemSubType = element

            tbl9.Spacer = if tbl1.itemSubType and not FFlagAXMISSmallUIChanges then React.createElement(Icon, { name = "icons/controls/keys/period", size = IconSize.Small, LayoutOrder = 2 }) else nil

            tbl9.Divider = if tbl1.creatorName and FFlagAXMISSmallUIChanges then React.createElement(Icon, { name = "icons/controls/keys/period", size = IconSize.Small, LayoutOrder = 2 }) else nil
            local element2

            if tbl1.creatorName then
                element2 = React.createElement(FoundationText, {
                    tag = "fill self-stretch",
                    textStyle = var1.Color.Content.Default,
                    fontStyle = var1.Typography.BodyMedium,
                    LayoutOrder = 3,
                    Text = if tbl1.creatorHasVerifiedBadge then `{tbl1.creatorName}{VerifiedBadges.emoji.verified}` else tbl1.creatorName,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    AutomaticSize = Enum.AutomaticSize.XY,
                    TextTruncate = Enum.TextTruncate.SplitWord
                })
            else
                element2 = nil
            end

            tbl9.CreatorName = element2
            var6 = createElement4(view4, tbl8, tbl9)
        else
            var6 = nil
        end

        tbl7.ItemCardFooterInfo = var6
        local element

        if tbl1.bundlePartsText and not tbl1.timedOptions then
            element = React.createElement(
                Foundation.View,
                { tag = "auto-xy padding-xsmall radius-small bg-surface-100", LayoutOrder = 3 },
                {
                    Text = React.createElement(FoundationText, {
                        textStyle = var1.Color.Content.Default,
                        fontStyle = var1.Typography.BodySmall,
                        Text = tbl1.bundlePartsText,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        AutomaticSize = Enum.AutomaticSize.XY,
                        TextTruncate = Enum.TextTruncate.SplitWord
                    })
                }
            )
        else
            element = nil
        end

        tbl7.BundleParts = element
        tbl5.Left = createElement3(view3, tbl6, tbl7)
        local var7

        if tbl1.onRemove or FFlagAXGifting and tbl1.giftButton then
            local createElement4 = React.createElement
            local view4 = Foundation.View
            local tbl8 = {
                tag = FFlagAXGifting and {
                    ["auto-xy"] = true,
                    ["row gap-small"] = tbl1.giftButton ~= nil
                } or "auto-xy",
                LayoutOrder = 2
            }
            local element2

            if FFlagAXGifting then
                element2 = {
                    GiftButton = if tbl1.giftButton == nil then nil else React.createElement(
                        Foundation.View,
                        {
                            tag = "auto-xy",
                            LayoutOrder = 1,
                            testId = "catalogRowItemCardGiftButton"
                        },
                        tbl1.giftButton
                    ),
                    RemoveButton = if tbl1.onRemove then React.createElement(Foundation.IconButton, {
                        icon = "x",
                        isCircular = true,
                        variant = Foundation.Enums.ButtonVariant.Standard,
                        onActivated = tbl1.onRemove,
                        testId = "catalogRowItemCardRemoveButton",
                        LayoutOrder = 2
                    }) else nil
                }
            elseif tbl1.onRemove then
                element2 = React.createElement(Foundation.IconButton, {
                    icon = "x",
                    isCircular = true,
                    variant = Foundation.Enums.ButtonVariant.Standard,
                    onActivated = tbl1.onRemove,
                    testId = "catalogRowItemCardRemoveButton"
                })
            else
                element2 = nil
            end

            var7 = createElement4(view4, tbl8, element2)
        else
            var7 = nil
        end

        tbl5.Right = var7
        var5 = createElement2(view2, tbl4, tbl5)
    else
        local createElement2 = React.createElement
        local str1 = "Frame"
        local tbl4 = {
            AutomaticSize = Enum.AutomaticSize.XY,
            BackgroundTransparency = 1,
            BorderSizePixel = 0
        }

        local tbl5 = {
            TopLayout = React.createElement("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                FillDirection = Enum.FillDirection.Vertical,
                HorizontalAlignment = Enum.HorizontalAlignment.Left,
                Padding = UDim.new(0, var1.Gap.XSmall)
            }),
            ItemCardFooterTitle = React.createElement(ItemCardTitle, { title = tbl1.title or "", LayoutOrder = 1 }),
            ItemCardFooterInfo = 0,
            BundleParts = 0
        }
        local var6

        if tbl1.itemSubType or tbl1.creatorName then
            local createElement3 = React.createElement
            local str2 = "Frame"
            local tbl6 = {
                Size = UDim2.fromScale(1, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                LayoutOrder = 2
            }

            local tbl7 = {
                ItemCardFooterInfoLayout = React.createElement("UIListLayout", {
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    FillDirection = Enum.FillDirection.Horizontal,
                    HorizontalAlignment = Enum.HorizontalAlignment.Left,
                    Padding = UDim.new(0, var1.Gap.XXSmall)
                }),
                ItemSubType = 0,
                Spacer = 0,
                Divider = 0,
                CreatorName = 0
            }
            local element

            if tbl1.itemSubType then
                element = React.createElement(FoundationText, {
                    textStyle = var1.Color.Content.Default,
                    fontStyle = var1.Typography.BodyMedium,
                    LayoutOrder = 1,
                    Text = tbl1.itemSubType,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    AutomaticSize = Enum.AutomaticSize.XY,
                    TextTruncate = Enum.TextTruncate.SplitWord
                })
            else
                element = nil
            end

            tbl7.ItemSubType = element

            tbl7.Spacer = if tbl1.itemSubType and not FFlagAXMISSmallUIChanges then React.createElement(Icon, { name = "icons/controls/keys/period", size = IconSize.Small, LayoutOrder = 2 }) else nil

            tbl7.Divider = if tbl1.creatorName and FFlagAXMISSmallUIChanges then React.createElement(Icon, { name = "icons/controls/keys/period", size = IconSize.Small, LayoutOrder = 2 }) else nil
            local element2

            if tbl1.creatorName then
                element2 = React.createElement(FoundationText, {
                    tag = "fill self-stretch",
                    textStyle = var1.Color.Content.Default,
                    fontStyle = var1.Typography.BodyMedium,
                    LayoutOrder = 3,
                    Text = if tbl1.creatorHasVerifiedBadge then `{tbl1.creatorName}{VerifiedBadges.emoji.verified}` else tbl1.creatorName,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    AutomaticSize = Enum.AutomaticSize.XY,
                    TextTruncate = Enum.TextTruncate.SplitWord
                })
            else
                element2 = nil
            end

            tbl7.CreatorName = element2
            var6 = createElement3(str2, tbl6, tbl7)
        else
            var6 = nil
        end

        tbl5.ItemCardFooterInfo = var6
        local element

        if tbl1.bundlePartsText then
            element = React.createElement("Frame", {
                LayoutOrder = 3,
                BackgroundColor3 = var1.Color.Surface.Surface_100.Color3,
                BackgroundTransparency = var1.Color.Surface.Surface_100.Transparency,
                AutomaticSize = Enum.AutomaticSize.XY
            }, {
                UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(0, var1.Radius.Small) }),
                UIPadding = React.createElement("UIPadding", {
                    PaddingTop = UDim.new(0, var1.Padding.XSmall),
                    PaddingLeft = UDim.new(0, var1.Padding.XSmall),
                    PaddingRight = UDim.new(0, var1.Padding.XSmall),
                    PaddingBottom = UDim.new(0, var1.Padding.XSmall)
                }),
                Text = React.createElement(FoundationText, {
                    textStyle = var1.Color.Content.Default,
                    fontStyle = var1.Typography.BodySmall,
                    Text = tbl1.bundlePartsText,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    AutomaticSize = Enum.AutomaticSize.XY,
                    TextTruncate = Enum.TextTruncate.SplitWord
                })
            })
        else
            element = nil
        end

        tbl5.BundleParts = element
        var5 = createElement2(str1, tbl4, tbl5)
    end

    tbl3.TopSection = var5

    tbl3.BottomPrice = if FFlagAXDurablesForMIS
        or FFlagAXEnableTimedOptionsForCatalogRowCard
        or not (tbl1.priceLineContent and #tbl1.priceLineContent > 0) then nil else React.createElement(Foundation.View, { tag = "auto-xy row gap-xsmall position-bottom-left anchor-bottom-left" }, var2)
    local var6

    if (FFlagAXDurablesForMIS or FFlagAXEnableTimedOptionsForCatalogRowCard) and var3 then
        local createElement2 = React.createElement
        local view2 = Foundation.View
        local tbl4 = {
            tag = if FFlagAXDurables2Option and tbl1.hideTimedOptionSelections then "auto-x row gap-xsmall align-y-center position-bottom-left anchor-bottom-left" else "auto-xy row gap-xsmall align-y-center position-bottom-left anchor-bottom-left",
            Size = if FFlagAXMISOffersChip then UDim2.fromOffset(0, var1.Size.Size_800) else nil
        }
        local join = Cryo.Dictionary.join
        local var7 = FFlagAXDurables2Option
            and tbl1.hideTimedOptionSelections
            and tbl1.timedOptions
            and (not tbl1.isOwned or tbl1.expirationTime)
            and tbl1.itemStatusInCheckout == nil
            and {}
            or var2

        local tbl5 = { WearTimeOptions = 0, Badge = 0, OfferAppliedBadge = 0 }
        local var8

        if FFlagAXDurables2Option and tbl1.hideTimedOptionSelections
            or not tbl1.timedOptions
            or tbl1.isOwned and not tbl1.expirationTime
        then
            var8 = nil
        else
            local createElement3 = React.createElement
            local view3 = Foundation.View
            local tbl6 = { tag = "auto-xy padding-left-small", LayoutOrder = 100 }

            local tbl7 = { WearTimeSelectedOptionInList = 0 }
            local var9

            if tbl1.wearTimeSelectedOptionInList then
                local createElement4 = React.createElement
                local wearTimeSelectedOptionInList = tbl1.wearTimeSelectedOptionInList
                local tbl8 = {
                    options = tbl1.timedOptions,
                    selectedTimedOptionIndexInReducer = if FFlagAXDurablesForMIS then tbl1.selectedTimedOptionIndexInReducer else nil,
                    onOptionActivated = 0
                }

                function tbl8.onOptionActivated(arg1)
                    local timedOption = tbl1.timedOptions[arg1]
                    if not timedOption then
                        return
                    end

                    if setSelectedTimedOptionPrice then
                        setSelectedTimedOptionPrice(timedOption.price)
                    end
                    if tbl1.onTimedOptionPriceChanged then
                        local days = if timedOption.days == 0 then nil else timedOption.days
                        tbl1.onTimedOptionPriceChanged(timedOption.price, days)
                    end
                end

                var9 = createElement4(wearTimeSelectedOptionInList, tbl8)
            else
                var9 = nil
            end

            tbl7.WearTimeSelectedOptionInList = var9
            var8 = createElement3(view3, tbl6, tbl7)
        end

        tbl5.WearTimeOptions = var8
        local element

        if FFlagAXDurables2Option and tbl1.offerApplied then
            element = React.createElement(Foundation.Popover.Root, {
                isOpen = tbl1.showOfferPillTooltip or false
            }, {
                Anchor = React.createElement(Foundation.Popover.Anchor, { LayoutOrder = 101 }, {
                    Badge = React.createElement(Foundation.Badge, {
                        icon = {
                            name = Foundation.Enums.IconName.TagSparkle,
                            position = Foundation.Enums.IconPosition.Left
                        },
                        text = tbl1.offersLocalized and tbl1.offersLocalized.OfferApplied,
                        variant = Foundation.Enums.BadgeVariant.Neutral,
                        shape = Foundation.Enums.BadgeShape.Pill,
                        size = Foundation.Enums.BadgeSize.XSmall
                    })
                }),
                Content = React.createElement(Foundation.Popover.Content, {
                    align = Foundation.Enums.PopoverAlign.Center,
                    side = Foundation.Enums.PopoverSide.Top,
                    radius = Foundation.Enums.Radius.Medium,
                    backgroundStyle = var1.Color.System.Contrast
                }, {
                    TooltipContent = React.createElement(
                        Foundation.View,
                        { tag = "col gap-xsmall auto-xy padding-x-medium padding-y-small" },
                        {
                            TooltipText = React.createElement(FoundationText, {
                                Text = tbl1.offersLocalized and tbl1.offersLocalized.OfferAppliedTooltip,
                                tag = "auto-xy text-title-medium text-truncate-end content-inverse-emphasis"
                            })
                        }
                    )
                })
            })
        else
            element = nil
        end

        tbl5.Badge = element
        local element2

        if FFlagAXMISOffersChip
            and not FFlagAXDurables2Option
            and tbl1.offerApplied
            and (not tbl1.timedOptions or tbl1.isOwned and not tbl1.expirationTime)
        then
            element2 = React.createElement(Foundation.Badge, {
                icon = {
                    name = Foundation.Enums.IconName.TagSparkle,
                    position = Foundation.Enums.IconPosition.Left
                },
                text = tbl1.offersLocalized and tbl1.offersLocalized.OfferApplied,
                variant = Foundation.Enums.BadgeVariant.Neutral,
                shape = Foundation.Enums.BadgeShape.Pill,
                size = Foundation.Enums.BadgeSize.XSmall,
                LayoutOrder = 101
            })
        else
            element2 = nil
        end

        tbl5.OfferAppliedBadge = element2
        var6 = createElement2(view2, tbl4, join(var7, tbl5))
    else
        var6 = nil
    end

    tbl3.BottomContent = var6
    return createElement(view, tbl2, tbl3)
end

return CatalogRowItemCardFooter
