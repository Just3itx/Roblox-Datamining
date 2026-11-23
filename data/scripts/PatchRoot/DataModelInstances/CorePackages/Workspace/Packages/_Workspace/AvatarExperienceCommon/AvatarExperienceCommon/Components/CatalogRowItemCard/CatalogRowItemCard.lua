-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:20:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommon = script:FindFirstAncestor("AvatarExperienceCommon")
local AvatarExperienceCommonParent = AvatarExperienceCommon.Parent
local React = require(AvatarExperienceCommonParent.React)
local Foundation = require(AvatarExperienceCommonParent.Foundation)

local useTokens = Foundation.Hooks.useTokens
local ItemCardComponents = require(AvatarExperienceCommonParent.AvatarExperienceUIKit).ItemCardComponents
local ItemCardHeader = ItemCardComponents.ItemCardHeader
local ItemCardBadge = ItemCardComponents.ItemCardBadge
local ItemCardStatus = ItemCardComponents.ItemCardStatus
local ItemCardHeaderCornersOverlay = ItemCardComponents.ItemCardHeaderCornersOverlay
local ItemCardIcon = ItemCardComponents.ItemCardIcon

local IndicatorStack = require(AvatarExperienceCommon.Components.IndicatorStack.IndicatorStack)
local shouldRenderIndicatorStack = require(AvatarExperienceCommon.Utils.shouldRenderIndicatorStack)
local LicensingBadge = require(AvatarExperienceCommon.Components.LicensingBadge.LicensingBadge)
local CatalogRowItemCardFooter = require(script.Parent.CatalogRowItemCardFooter)
local _CatalogItemCardItemTypeEnum = require(script.Parent.Parent.CatalogItemCard.Enums.CatalogItemCardItemTypeEnum)
local _CatalogItemCardItemInfoEnum = require(script.Parent.Parent.CatalogItemCard.Enums.CatalogItemCardItemInfoEnum)

local _CatalogItemCardStatusIconTypeEnum = require(script.Parent.Parent.CatalogItemCard.Enums.CatalogItemCardStatusIconTypeEnum)
local CatalogItemCardBadgeMaps = require(script.Parent.Parent.CatalogItemCard.CatalogItemCardBadgeMaps)

local AvatarExperienceFlags = require(AvatarExperienceCommonParent.AvatarExperienceFlags)
local FFlagAXDurablesForMIS = AvatarExperienceFlags.FFlagAXDurablesForMIS
local FFlagAXDurables2Option = AvatarExperienceFlags.FFlagAXDurables2Option
local FFlagAXMISOffersChip = AvatarExperienceFlags.FFlagAXMISOffersChip
local FFlagAXMarketplaceItemCardIndicatorStack = AvatarExperienceFlags.FFlagAXMarketplaceItemCardIndicatorStack
local FFlagAXMarketplaceLicensingItemCards = AvatarExperienceFlags.FFlagAXMarketplaceLicensingItemCards
local FFlagAXGifting = AvatarExperienceFlags.FFlagAXGifting

local _AvatarExperienceModel = require(AvatarExperienceCommonParent.AvatarExperienceModel)

local _TimedOptionType = require(AvatarExperienceCommon.Types.TimedOptionType)

local FFlagAXEnableTimedOptionsForCatalogRowCard = AvatarExperienceFlags.FFlagAXEnableTimedOptionsForCatalogRowCard
local FFlagAXRemoveDynamicHeadBadge = AvatarExperienceFlags.FFlagAXRemoveDynamicHeadBadge

local itemTypeToContentMap = CatalogItemCardBadgeMaps.itemTypeToContentMap
local itemInfoIconMap = CatalogItemCardBadgeMaps.itemInfoIconMap
local var1 = if FFlagAXMarketplaceItemCardIndicatorStack then CatalogItemCardBadgeMaps.itemStatusIconTypeToIconMap else CatalogItemCardBadgeMaps.rowItemStatusIconTypeToIconMap

local function buildItemStatusContent(itemStatus, icon: string?)
    if itemStatus.type == "text" then
        return {
            type = "text",
            text = itemStatus.text
        }
    end

    if itemStatus.type ~= "badge" then
        if icon then
            return { type = "icon", icon = icon }
        end

        return nil
    end

    return {
        type = "badge",
        content = {
            { type = "icon", icon = icon },
            {
                type = "text",
                text = itemStatus.text
            }
        }
    }
end

return (React.forwardRef(function(tbl1, ref)
    local var2 = useTokens()
    local icon = if tbl1.itemInfo then itemInfoIconMap[tbl1.itemInfo] else nil
    local var4 = if tbl1.itemType then itemTypeToContentMap[tbl1.itemType] else nil
    local var3 = if tbl1.itemStatus
        and tbl1.itemStatus.type ~= "text"
        and (tbl1.itemStatus.type == "icon" or FFlagAXMarketplaceItemCardIndicatorStack and tbl1.itemStatus.type == "badge") then var1[tbl1.itemStatus.iconType] else nil
    local topLeftSlot = if FFlagAXMarketplaceLicensingItemCards and tbl1.itemLicensingInfo then React.createElement(
        LicensingBadge,
        {
            itemLicensingInfo = tbl1.itemLicensingInfo,
            isInteractive = false,
            passiveSize = Foundation.Enums.BadgeSize.XSmall
        }
    ) else nil
    local element2

    if FFlagAXMarketplaceItemCardIndicatorStack then
        local statusContent = if tbl1.itemStatus then buildItemStatusContent(tbl1.itemStatus, var3) else nil

        if shouldRenderIndicatorStack(statusContent, var4) then
            element2 = React.createElement(IndicatorStack, { statusContent = statusContent, itemTypeContent = var4 })
        else
            element2 = nil
        end
    else
        element2 = nil
    end

    local createElement = React.createElement
    local str1 = "TextButton"
    local tbl2 = {
        Text = "",
        AutoButtonColor = false,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        [React.Event.Activated] = if tbl1.isDisabled then nil else tbl1.onActivated,
        ref = ref,
        AutomaticSize = tbl1.AutomaticSize,
        LayoutOrder = tbl1.LayoutOrder,
        SelectionGroup = true,
        ClipsDescendants = false,
        [React.Tag] = tbl1.tag
    }
    local tbl3 = {
        HorizontalLayout = React.createElement("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            VerticalAlignment = Enum.VerticalAlignment.Top,
            Padding = UDim.new(0, var2.Gap.Medium)
        }),
        Header = 0,
        Footer = 0
    }

    local createElement2 = React.createElement
    local var6 = ItemCardHeader
    local tbl4 = {
        LayoutOrder = 1,
        aspectRatio = tbl1.headerAspectRatio,
        Size = tbl1.headerSize,
        overlaySlot = 0
    }
    local element3

    if FFlagAXMarketplaceItemCardIndicatorStack then
        element3 = React.createElement(
            ItemCardHeaderCornersOverlay,
            {
                topLeftSlot = topLeftSlot,
                bottomRightSlot = element2,
                constrainTopLeftSlot = topLeftSlot ~= nil
            }
        )
    else
        local createElement3 = React.createElement
        local var7 = ItemCardHeaderCornersOverlay
        local tbl5 = { topLeftSlot = 0, bottomLeftSlot = 0, bottomRightSlot = 0 }
        local element4

        if tbl1.itemStatus and tbl1.itemStatus.type == "badge" then
            element4 = React.createElement(ItemCardBadge, {
                content = {
                    {
                        type = "icon",
                        icon = var1[tbl1.itemStatus.iconType]
                    },
                    {
                        type = "text",
                        text = tbl1.itemStatus.text
                    }
                }
            })
        elseif tbl1.itemStatus then
            if tbl1.itemStatus.type == "text" then
                element4 = React.createElement(ItemCardStatus, { text = tbl1.itemStatus.text })
            elseif var3 then
                element4 = React.createElement(ItemCardIcon, { icon = var3 })
            else
                element4 = nil
            end
        else
            element4 = nil
        end

        tbl5.topLeftSlot = element4

        tbl5.bottomLeftSlot = if var4 then React.createElement(ItemCardBadge, { content = var4 }) else nil

        tbl5.bottomRightSlot = if FFlagAXRemoveDynamicHeadBadge or not icon then nil else React.createElement(ItemCardBadge, { content = {{ type = "icon", icon = icon }} })
        element3 = createElement3(var7, tbl5)
    end

    tbl4.overlaySlot = element3
    tbl3.Header = createElement2(var6, tbl4, tbl1.presentationSlot)

    tbl3.Footer = React.createElement(CatalogRowItemCardFooter, {
        title = tbl1.title,
        creatorName = if tbl1.creator then tbl1.creator.name else nil,
        bundlePartsText = tbl1.bundlePartsText,
        itemSubType = tbl1.itemSubType,
        creatorHasVerifiedBadge = if tbl1.creator then tbl1.creator.verified else nil,
        priceLineContent = tbl1.priceLineContent,
        itemStatusInCheckout = if FFlagAXDurables2Option then tbl1.itemStatusInCheckout else nil,
        expirationTime = if FFlagAXDurablesForMIS or FFlagAXEnableTimedOptionsForCatalogRowCard then tbl1.expirationTime else nil,
        isOwned = if FFlagAXDurablesForMIS or FFlagAXEnableTimedOptionsForCatalogRowCard then tbl1.isOwned else nil,
        timedOptions = if FFlagAXDurablesForMIS or FFlagAXEnableTimedOptionsForCatalogRowCard then tbl1.timedOptions else nil,
        onTimedOptionPriceChanged = if FFlagAXDurablesForMIS or FFlagAXEnableTimedOptionsForCatalogRowCard then tbl1.onTimedOptionPriceChanged else nil,
        selectedTimedOptionPrice = if FFlagAXDurablesForMIS or FFlagAXEnableTimedOptionsForCatalogRowCard then tbl1.selectedTimedOptionPrice else nil,
        setSelectedTimedOptionPrice = if FFlagAXDurablesForMIS or FFlagAXEnableTimedOptionsForCatalogRowCard then tbl1.setSelectedTimedOptionPrice else nil,
        selectedTimedOptionIndexInReducer = if FFlagAXDurablesForMIS or FFlagAXEnableTimedOptionsForCatalogRowCard then tbl1.selectedTimedOptionIndexInReducer else nil,
        wearTimeSelectedOptionInList = if FFlagAXDurablesForMIS or FFlagAXEnableTimedOptionsForCatalogRowCard then tbl1.wearTimeSelectedOptionInList else nil,
        onRemove = if FFlagAXDurables2Option then tbl1.onRemove else nil,
        giftButton = if FFlagAXGifting then tbl1.giftButton else nil,
        hideTimedOptionSelections = if FFlagAXDurables2Option then tbl1.hideTimedOptionSelections else nil,
        LayoutOrder = 2,
        Size = tbl1.footerSize,
        AutomaticSize = if tbl1.footerAutomaticSize then tbl1.footerAutomaticSize else Enum.AutomaticSize.Y,
        offersLocalized = if FFlagAXMISOffersChip then tbl1.offersLocalized else nil,
        offerApplied = if FFlagAXMISOffersChip then tbl1.offerApplied else nil,
        showOfferPillTooltip = if FFlagAXDurables2Option then tbl1.showOfferPillTooltip else nil
    })
    return createElement(str1, tbl2, tbl3)
end))
