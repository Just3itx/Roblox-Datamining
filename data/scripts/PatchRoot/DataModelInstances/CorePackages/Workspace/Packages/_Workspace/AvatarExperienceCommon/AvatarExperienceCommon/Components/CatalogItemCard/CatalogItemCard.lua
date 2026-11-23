-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:11:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommon = script:FindFirstAncestor("AvatarExperienceCommon")
local AvatarExperienceCommonParent = AvatarExperienceCommon.Parent
local React = require(AvatarExperienceCommonParent.React)
local AvatarExperienceUIKit = require(AvatarExperienceCommonParent.AvatarExperienceUIKit)
local Responsive = require(AvatarExperienceCommonParent.Responsive)

local ItemCardComponents = AvatarExperienceUIKit.ItemCardComponents
local ItemCardFooter = ItemCardComponents.ItemCardFooter
local ItemCardHeader = ItemCardComponents.ItemCardHeader
local ItemCard = ItemCardComponents.ItemCard
local ItemCardBadge = ItemCardComponents.ItemCardBadge
local ItemCardStatus = ItemCardComponents.ItemCardStatus
local ItemCardHeaderCornersOverlay = ItemCardComponents.ItemCardHeaderCornersOverlay
local _ItemCardPriceLine = ItemCardComponents.ItemCardPriceLine
local ItemCardIcon = ItemCardComponents.ItemCardIcon
local Foundation = require(AvatarExperienceCommonParent.Foundation)
local useTokens = Foundation.Hooks.useTokens
local BadgeSize = Foundation.Enums.BadgeSize
local IconSize = Foundation.Enums.IconSize
local Icon = Foundation.Icon

local useSelector = require(AvatarExperienceCommonParent.RoactUtils).Hooks.RoactRodux.useSelector

local IndicatorStack = require(AvatarExperienceCommon.Components.IndicatorStack.IndicatorStack)
local shouldRenderIndicatorStack = require(AvatarExperienceCommon.Utils.shouldRenderIndicatorStack)
local LicensingBadge = require(AvatarExperienceCommon.Components.LicensingBadge.LicensingBadge)
local _CatalogItemCardItemTypeEnum = require(script.Parent.Enums.CatalogItemCardItemTypeEnum)
local _CatalogItemCardItemInfoEnum = require(script.Parent.Enums.CatalogItemCardItemInfoEnum)
local CatalogItemCardStatusIconTypeEnum = require(script.Parent.Enums.CatalogItemCardStatusIconTypeEnum)
local ItemStatusTypeEnum = require(script.Parent.Enums.ItemStatusTypeEnum)
local CatalogItemCardBadgeMaps = require(script.Parent.CatalogItemCardBadgeMaps)

local CatalogItemCardSelectedOverlay = require(script.Parent.CatalogItemCardSelectedOverlay)
local useSelectedOverlayButton = require(script.Parent.useSelectedOverlayButton)

local AvatarExperienceFlags = require(AvatarExperienceCommonParent.AvatarExperienceFlags)
local FFlagAXInventoryDurablesSupport = AvatarExperienceFlags.FFlagAXInventoryDurablesSupport
local FFlagAXModeratedItemIconUpdates = AvatarExperienceFlags.FFlagAXModeratedItemIconUpdates
local FFlagAXShowFaeUpsell = AvatarExperienceFlags.FFlagAXShowFaeUpsell
local FFlagAXFixBadgeStatusConfigOptions = AvatarExperienceFlags.FFlagAXFixBadgeStatusConfigOptions
local FFlagAXRemoveDynamicHeadBadge = AvatarExperienceFlags.FFlagAXRemoveDynamicHeadBadge
local FFlagAXMarketplaceItemCardIndicatorStack = AvatarExperienceFlags.FFlagAXMarketplaceItemCardIndicatorStack
local FFlagAXMarketplaceLicensingItemCards = AvatarExperienceFlags.FFlagAXMarketplaceLicensingItemCards

local _AvatarExperienceModel = require(AvatarExperienceCommonParent.AvatarExperienceModel)

local DURABLE_ICON = CatalogItemCardBadgeMaps.DURABLE_ICON
local FAE_ICON = CatalogItemCardBadgeMaps.FAE_ICON

local itemTypeToContentMap = CatalogItemCardBadgeMaps.itemTypeToContentMap
local itemInfoIconMap = CatalogItemCardBadgeMaps.itemInfoIconMap
local itemStatusIconTypeToIconMap = CatalogItemCardBadgeMaps.itemStatusIconTypeToIconMap

local function selectIsPortrait(arg1): boolean
    return arg1.DeviceOrientation == Responsive.Keys.Portrait
end

local function buildBadgeStatusContent(icon: string?, text: string?)
    local tbl1 = {{ type = "icon", icon = icon }}

    if text then
        table.insert(tbl1, { type = "text", text = text })
    end
    return tbl1
end

local function buildItemStatusContent(itemStatus, icon: string?, text: string?, isSelected: boolean?)
    if itemStatus then
        local content = if itemStatus.type == ItemStatusTypeEnum.Badge then not (FFlagAXFixBadgeStatusConfigOptions or FFlagAXShowFaeUpsell)
            and {
                { type = "icon", icon = icon },
                {
                    type = "text",
                    text = itemStatus.text
                }
            }
            or buildBadgeStatusContent(icon, itemStatus.text) else nil

        if itemStatus.type == ItemStatusTypeEnum.Text and itemStatus.text then
            return {
                type = "text",
                text = itemStatus.text
            }
        end

        if itemStatus.type == ItemStatusTypeEnum.Badge and content then
            return { type = "badge", content = content, displayBorder = true }
        end

        if icon then
            return { type = "icon", icon = icon }
        end

        if not isSelected or itemStatus.iconType == CatalogItemCardStatusIconTypeEnum.Moderated then
            return nil
        end
    end

    return if FFlagAXInventoryDurablesSupport and text then {
        type = "badge",
        content = {
            { type = "icon", icon = DURABLE_ICON },
            { type = "text", text = text }
        },
        displayBorder = true
    } else nil
end

local function buildSelectedOverlayBadge(itemStatus, icon: string?, text: string?)
    local iconType = itemStatus and itemStatus.iconType
    local text2 = itemStatus and itemStatus.text

    if FFlagAXShowFaeUpsell and iconType == CatalogItemCardStatusIconTypeEnum.FAE then
        return { icon = FAE_ICON }
    end

    if icon and text2 then
        return { icon = icon, text = text2 }
    end

    if FFlagAXInventoryDurablesSupport and text and iconType ~= CatalogItemCardStatusIconTypeEnum.Moderated then
        return { icon = DURABLE_ICON, text = text }
    end

    return nil
end

local function SelectedIndicatorCorners(tbl1)
    local var1 = useSelectedOverlayButton(tbl1.hasOverlayButton)

    return React.createElement(ItemCardHeaderCornersOverlay, {
        topLeftSlot = if FFlagAXMarketplaceLicensingItemCards then tbl1.topLeftSlot else nil,
        bottomRightSlot = tbl1.bottomRightSlot,
        bottomInset = if var1.isVisible then var1.occupiedHeight else nil,
        constrainTopLeftSlot = FFlagAXMarketplaceLicensingItemCards and tbl1.topLeftSlot ~= nil
    })
end

return (React.forwardRef(function(tbl1, ref)
    local var1 = if FFlagAXModeratedItemIconUpdates or FFlagAXMarketplaceLicensingItemCards then useTokens() else nil
    local var2, var3

    if FFlagAXMarketplaceLicensingItemCards then
        local size3000 = var1.Size.Size_3000
        local var4
        var2, var4 = React.useState(false)

        local var5 = React.useRef(var2)
        local var6 = React.useRef(nil)

        React.useImperativeHandle(ref, function()
            return var6.current
        end, {})
        local var7 = React.useCallback(function(arg2)
            local absoluteSizeX = arg2.AbsoluteSize.X
            if absoluteSizeX == 0 then
                return
            end

            local current = absoluteSizeX <= size3000
            if current ~= var5.current then
                var5.current = current
                var4(current)
            end
        end, { size3000 })

        React.useLayoutEffect(function()
            if var6.current then
                var7(var6.current)
            end
        end, { var7 })

        var3 = var7
        ref = var6
    else
        var2 = false
        var3 = nil
    end
    local var4 = tbl1.title or tbl1.creator or tbl1.priceLineContent
    local icon = if tbl1.itemInfo then itemInfoIconMap[tbl1.itemInfo] else nil
    local var6 = if tbl1.itemType then itemTypeToContentMap[tbl1.itemType] else nil
    local var7 = if FFlagAXModeratedItemIconUpdates then useSelector(selectIsPortrait) else nil
    local var8 = if tbl1.itemStatus
        and (tbl1.itemStatus.type == ItemStatusTypeEnum.Icon or tbl1.itemStatus.type == ItemStatusTypeEnum.Badge)
        and tbl1.itemStatus.iconType then itemStatusIconTypeToIconMap[tbl1.itemStatus.iconType] else nil
    local backgroundLayers = tbl1.backgroundLayers
    local suppressBorder = not (backgroundLayers == nil) and #backgroundLayers > 0
    local element = if FFlagAXMarketplaceLicensingItemCards and tbl1.itemLicensingInfo then React.createElement(
        LicensingBadge,
        {
            itemLicensingInfo = tbl1.itemLicensingInfo,
            isInteractive = false,
            passiveSize = if var2 then BadgeSize.XSmall else BadgeSize.Small
        }
    ) else nil
    local element2

    if FFlagAXMarketplaceItemCardIndicatorStack then
        local statusContent = buildItemStatusContent(tbl1.itemStatus, var8, tbl1.expirationTime, tbl1.isSelected)
        if shouldRenderIndicatorStack(statusContent, var6) then
            element2 = React.createElement(IndicatorStack, { statusContent = statusContent, itemTypeContent = var6 })
        else
            element2 = nil
        end
    else
        element2 = nil
    end

    local function renderPresentationSlot()
        if not tbl1.itemStatus or tbl1.itemStatus.type ~= ItemStatusTypeEnum.Placeholder then
            return tbl1.presentationSlot
        end

        if not tbl1.itemStatus.iconType then
            return nil
        end

        local createElement = React.createElement
        local view = Foundation.View
        local tbl2 = { tag = "size-full clip radius-medium row align-x-center align-y-center" }

        local tbl3 = { icon = 0 }
        local element3

        if FFlagAXModeratedItemIconUpdates then
            element3 = React.createElement(Icon, {
                name = itemStatusIconTypeToIconMap[tbl1.itemStatus.iconType],
                style = var1.Color.Content.Muted,
                size = if var7 then IconSize.Large else 40
            })
        else
            element3 = React.createElement(
                Foundation.Image,
                {
                    Image = itemStatusIconTypeToIconMap[tbl1.itemStatus.iconType],
                    Size = UDim2.fromScale(0.33, 0.33)
                }
            )
        end

        tbl3.icon = element3
        return createElement(view, tbl2, tbl3)
    end

    local createElement = React.createElement
    local var9 = ItemCard
    local tbl2 = {
        onActivated = tbl1.onActivated,
        isDisabled = tbl1.isDisabled,
        ref = ref,
        Size = tbl1.Size,
        AutomaticSize = tbl1.AutomaticSize,
        LayoutOrder = tbl1.LayoutOrder,
        tag = tbl1.tag,
        Selectable = tbl1.Selectable,
        showSelectionBorderWithBackground = tbl1.isSelected,
        backgroundLayers = backgroundLayers,
        imageScaleType = tbl1.imageScaleType,
        onAbsoluteSizeChanged = var3,
        headerSlot = 0,
        footerSlot = 0
    }
    local createElement2 = React.createElement
    local var10 = ItemCardHeader
    local tbl3 = {
        aspectRatio = tbl1.headerAspectRatio,
        overlaySlot = 0,
        BackgroundTransparency = 0,
        Size = 0
    }
    local var11

    if FFlagAXMarketplaceItemCardIndicatorStack then
        local createElement3 = React.createElement
        local fragment = React.Fragment
        local var12 = nil
        local tbl4 = {
            CatalogItemCardCorners = if tbl1.isSelected and element2 then React.createElement(SelectedIndicatorCorners, {
                topLeftSlot = element,
                bottomRightSlot = element2,
                hasOverlayButton = not (tbl1.onOverlayButtonActivated == nil) and tbl1.overlayButtonText ~= nil
            }) else React.createElement(
                ItemCardHeaderCornersOverlay,
                {
                    topLeftSlot = element,
                    bottomRightSlot = element2,
                    constrainTopLeftSlot = element ~= nil
                }
            ),
            CatalogItemCardSelection = if tbl1.isSelected then React.createElement(
                CatalogItemCardSelectedOverlay,
                tbl1.onOverlayButtonActivated
                    and tbl1.overlayButtonText
                    and {
                        onActivated = tbl1.onOverlayButtonActivated,
                        buttonText = tbl1.overlayButtonText,
                        suppressBorder = suppressBorder
                    }
                    or suppressBorder and { suppressBorder = true }
                    or nil
            ) else nil
        }
        var11 = createElement3(fragment, var12, tbl4)
    elseif tbl1.isSelected then
        local createElement3 = React.createElement
        local var12 = CatalogItemCardSelectedOverlay
        local tbl4

        if tbl1.onOverlayButtonActivated and tbl1.overlayButtonText then
            tbl4 = {
                onActivated = tbl1.onOverlayButtonActivated,
                buttonText = tbl1.overlayButtonText,
                suppressBorder = suppressBorder,
                badge = 0
            }
            local selectedOverlayBadge

            if FFlagAXFixBadgeStatusConfigOptions then
                selectedOverlayBadge = buildSelectedOverlayBadge(tbl1.itemStatus, var8, tbl1.expirationTime)
            else
                selectedOverlayBadge = FFlagAXShowFaeUpsell
                    and tbl1.itemStatus
                    and tbl1.itemStatus.iconType == CatalogItemCardStatusIconTypeEnum.FAE
                    and { icon = FAE_ICON }
                    or var8 and tbl1.itemStatus and tbl1.itemStatus.text and {
                        icon = var8,
                        text = tbl1.itemStatus.text
                    }
                    or FFlagAXInventoryDurablesSupport
                        and tbl1.expirationTime
                        and (not tbl1.itemStatus or tbl1.itemStatus.iconType ~= CatalogItemCardStatusIconTypeEnum.Moderated)
                        and {
                            icon = DURABLE_ICON,
                            text = tbl1.expirationTime
                        }
                    or nil
            end

            tbl4.badge = selectedOverlayBadge
        else
            tbl4 = FFlagAXInventoryDurablesSupport and var8 and {
                itemStatusIcon = var8,
                suppressBorder = suppressBorder
            }
                or suppressBorder and { suppressBorder = true }
                or nil
        end

        var11 = createElement3(var12, tbl4)
    else
        local createElement3 = React.createElement
        local var12 = ItemCardHeaderCornersOverlay
        local tbl4 = { topLeftSlot = 0, bottomRightSlot = 0 }
        local element3

        if tbl1.itemStatus then
            if tbl1.itemStatus.type == ItemStatusTypeEnum.Text and tbl1.itemStatus.text then
                element3 = React.createElement(ItemCardStatus, { text = tbl1.itemStatus.text })
            elseif tbl1.itemStatus.type == ItemStatusTypeEnum.Badge then
                element3 = React.createElement(ItemCardBadge, {
                    content = not (FFlagAXFixBadgeStatusConfigOptions or FFlagAXShowFaeUpsell)
                        and {
                            { type = "icon", icon = var8 },
                            {
                                type = "text",
                                text = tbl1.itemStatus.text
                            }
                        }
                        or buildBadgeStatusContent(var8, tbl1.itemStatus.text),
                    displayBorder = true
                })
            elseif var8 then
                element3 = React.createElement(ItemCardIcon, { icon = var8 })
            else
                element3 = nil
            end
        elseif FFlagAXInventoryDurablesSupport and tbl1.expirationTime then
            element3 = React.createElement(ItemCardBadge, {
                content = {
                    { type = "icon", icon = DURABLE_ICON },
                    {
                        type = "text",
                        text = tbl1.expirationTime
                    }
                },
                displayBorder = true
            })
        elseif var6 then
            element3 = React.createElement(ItemCardBadge, { content = var6 })
        else
            element3 = nil
        end

        tbl4.topLeftSlot = element3

        tbl4.bottomRightSlot = if FFlagAXRemoveDynamicHeadBadge or not icon then nil else React.createElement(ItemCardBadge, { content = {{ type = "icon", icon = icon }} })
        var11 = createElement3(var12, tbl4)
    end

    tbl3.overlaySlot = var11

    tbl3.BackgroundTransparency = if backgroundLayers then 1 else nil
    tbl3.Size = tbl1.headerSize
    tbl2.headerSlot = createElement2(var10, tbl3, renderPresentationSlot())
    local element3

    if var4 then
        element3 = React.createElement(ItemCardFooter, {
            title = tbl1.title,
            creatorName = if tbl1.creator then tbl1.creator.name else nil,
            creatorHasVerifiedBadge = if tbl1.creator then tbl1.creator.verified else nil,
            priceLineContent = tbl1.priceLineContent,
            titleTextSize = tbl1.titleTextSize,
            LayoutOrder = 2
        })
    else
        element3 = nil
    end

    tbl2.footerSlot = element3
    return createElement(var9, tbl2)
end))
