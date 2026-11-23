-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T16:31:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceInspectAndBuy = script:FindFirstAncestor("AvatarExperienceInspectAndBuy")
local MarketplaceService = game:GetService("MarketplaceService")

local AvatarExperienceInspectAndBuyParent = AvatarExperienceInspectAndBuy.Parent
local tutils = require(AvatarExperienceInspectAndBuyParent.tutils)
local React = require(AvatarExperienceInspectAndBuyParent.React)
local RoactUtils = require(AvatarExperienceInspectAndBuyParent.RoactUtils)
local useEventConnection = require(AvatarExperienceInspectAndBuyParent.ReactUtils).useEventConnection
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector
local VerifiedBadges = require(AvatarExperienceInspectAndBuyParent.VerifiedBadges)
local Localization = require(AvatarExperienceInspectAndBuyParent.Localization)

local FFlagAXInspectAndBuyAvatarBackground = require(AvatarExperienceInspectAndBuyParent.AvatarExperienceFlags).FFlagAXInspectAndBuyAvatarBackground
local useLocalization = Localization.Hooks.useLocalization
local useItemSelectionStore = require(AvatarExperienceInspectAndBuy.Contexts.ItemSelectionStoreContext).useItemSelectionStore

local _ResponsivePanelLayout = require(AvatarExperienceInspectAndBuy.Components.Common.ResponsivePanelLayout)
local AvatarItemsViewLayout = require(AvatarExperienceInspectAndBuy.Components.ItemsView.AvatarItemsViewLayout)
local ItemDetailsLayout = require(AvatarExperienceInspectAndBuy.Components.ItemDetails.ItemDetailsLayout)
local ViewportLayout = require(AvatarExperienceInspectAndBuy.Components.ItemsView.ViewportLayout)
local ViewType = require(AvatarExperienceInspectAndBuy.Enums.ViewType)
local _Types = require(AvatarExperienceInspectAndBuy.Types)
local useRemoteBulkPurchaseEvent = require(AvatarExperienceInspectAndBuy.Hooks.useRemoteBulkPurchaseEvent)
local _BuyActionBar = require(AvatarExperienceInspectAndBuy.Components.Common.BuyActionBar)
local getItemThumbnailUrl = require(AvatarExperienceInspectAndBuy.Utils.getItemThumbnailUrl)
local usePurchaseButtonProps = require(AvatarExperienceInspectAndBuy.Components.usePurchaseButtonProps)
local useInspectPlayer = require(AvatarExperienceInspectAndBuy.Hooks.useInspectPlayer)
local useTokens = require(AvatarExperienceInspectAndBuyParent.Foundation).Hooks.useTokens

local formatNumber = require(AvatarExperienceInspectAndBuy.Utils.formatNumber)

local function selectView(arg1)
    return arg1.view
end

local function selectInspectPreviewDetails(arg1)
    return arg1.avatarPreviewDetails
end

local function shouldRenderSecondPanel(arg1, arg2): boolean -- Luacid: unused: defined but never referenced
    return arg1 == ViewType.WideLandscape or (arg1 == ViewType.Wide or arg1 == ViewType.Compact) and not arg2
end

local tbl1 = {
    [ViewType.WideLandscape] = {
        tag = "size-full row align-y-center align-x-center",
        layoutOrder = { first = 1, second = 2 },
        panelSizes = {
            first = UDim2.new(0.65, 0, 1, 0),
            second = UDim2.new(0.35, 0, 1, 0)
        },
        showRightBorder = true
    },
    [ViewType.Wide] = {
        tag = "size-full col align-y-center align-x-center",
        layoutOrder = { first = 2, second = 1 },
        panelSizes = {
            first = UDim2.new(1, 0, 0.65, 0),
            second = UDim2.new(1, 0, 0.35, 0)
        },
        showRightBorder = false
    },
    [ViewType.Compact] = {
        tag = "size-full col align-y-center align-x-center",
        layoutOrder = { first = 2, second = 1 },
        panelSizes = {
            first = UDim2.new(1, 0, 0.7, 0),
            second = UDim2.new(1, 0, 0.3, 0)
        },
        showRightBorder = false
    }
}

return function(tbl2)
    local view = useSelector(selectView, tutils.deepEqual)
    local bool1 = view == ViewType.WideLandscape
    local selectedItem, var3 = React.useState(nil)
    local tryOnState, var5 = React.useState({ isTryOnEnabled = false, tryOnItem = {} })

    local items = useSelector(selectInspectPreviewDetails, tutils.deepEqual).items
    local onBulkPurchase, var7, var8 = useRemoteBulkPurchaseEvent(items, tbl2.analytics)
    local var9 = useInspectPlayer()
    local var10 = formatNumber(var8)
    local var11 = useTokens()

    local var12 = useItemSelectionStore()

    local ref = React.useRef(nil)
    local var14 = React.useRef(0)

    local localizedStrings = useLocalization({
        bulkPurchaseButtonText = "Feature.Catalog.Label.BuyItems",
        headerText = var9.hasVerifiedBadge
            and {
                "InGame.InspectMenu.Label.VerifiedAvatar",
                PLAYER_NAME = var9.playerName,
                VERIFIED_BADGE = VerifiedBadges.emoji.verified
            }
            or {
                "InGame.InspectMenu.Label.Avatar",
                PLAYER_NAME = var9.playerName
            },
        totalItems = items and {
            "Feature.Catalog.Feature.Catalog.Label.TotalItemsParenthesis",
            itemCount = #items
        } or nil,
        total = "Feature.Catalog.Label.TotalUnformatted"
    })

    local onToggleTryOn = React.useCallback(function(arg1)
        var5(function(arg2)
            local var16 = arg1
            local isTryOnEnabled = not arg2.isTryOnEnabled

            if isTryOnEnabled then
                tbl2.analytics.reportTryOnButtonClicked(arg1.itemType, arg1.itemId)
            end

            return {
                isTryOnEnabled = isTryOnEnabled,
                tryOnItem = not isTryOnEnabled and {} or var16
            }
        end)
    end, { tbl2.analytics })

    local buyActionBarProps = usePurchaseButtonProps({
        purchaseButtonText = localizedStrings.bulkPurchaseButtonText,
        onBulkPurchase = onBulkPurchase,
        isDisabled = not var7,
        selectedItem = selectedItem,
        localizedStrings = localizedStrings,
        formattedTotalPrice = var10,
        onPromptPurchase = tbl2.onPromptPurchase
    })

    useEventConnection(MarketplaceService.PromptBulkPurchaseFinished, tbl2.onBulkPurchaseFinished)

    React.useEffect(function()
        if ref.current then
            ref.current.CanvasPosition = Vector2.new(0, var14.current)
        end
    end, { selectedItem })

    React.useEffect(function()
        if selectedItem then
            tbl2.onItemDetailsOpened(selectedItem)
        end
    end, { selectedItem, tbl2.onItemDetailsOpened })

    local onInspectMenuClosed = React.useCallback(function()
        var12.clearAll()
        tbl2.onInspectMenuClosed()
    end, { var12, tbl2.onInspectMenuClosed })

    local function renderFirstPanel()
        if not selectedItem then
            return (React.createElement(AvatarItemsViewLayout, {
                view = view,
                items = items,
                headerText = localizedStrings.headerText,
                onInspectMenuClosed = onInspectMenuClosed,
                onItemCardActivated = function(arg1)
                    if ref.current then
                        var14.current = ref.current.CanvasPosition.Y
                    end
                    var3(arg1)
                end,
                subheaderText = {
                    leftSlotLabel = localizedStrings.totalItems or "",
                    rightSlotPrice = var10
                },
                buyActionBarProps = buyActionBarProps,
                ref = ref
            }))
        end

        return (React.createElement(ItemDetailsLayout, {
            itemDetailsViewProps = {
                view = view,
                item = selectedItem,
                onItemDetailsClosed = function()
                    var3(nil)
                    var5({ isTryOnEnabled = false, tryOnItem = {} })
                end,
                onToggleFavorite = tbl2.onToggleFavorite,
                openAttributionOverlay = tbl2.openAttributionOverlay,
                purchaseButtonProps = if view == ViewType.Wide then buyActionBarProps.purchaseButtonProps else nil,
                onToggleTryOn = onToggleTryOn,
                renderTryOnViewport = tbl2.renderTryOnViewport,
                tryOnState = tryOnState,
                localPlayerModel = tbl2.localPlayerModel,
                formatNumber = formatNumber
            },
            buyActionBarProps = buyActionBarProps,
            view = view
        }))
    end

    local avatarBackgroundImageUrl = if FFlagAXInspectAndBuyAvatarBackground and not selectedItem then tbl2.avatarBackgroundImageUrl else nil

    local function func2()
        local createElement = React.createElement
        local var19 = ViewportLayout

        local tbl3 = {
            view = view,
            thumbnailUrl = if selectedItem then getItemThumbnailUrl(selectedItem) or "" else "rbxthumb://type=Avatar&id=" .. tostring(var9.playerId) .. "&w=420&h=420",
            backButtonProps = {
                onBackButtonClick = selectedItem and function()
                    var3(nil)
                end or tbl2.onInspectMenuClosed
            },
            viewportProps = {
                ScaleType = Enum.ScaleType.Crop,
                Size = if bool1 then UDim2.new(1, 0, 0, 0) else UDim2.new(1, 0, 1, 0),
                AspectRatio = 1
            },
            buyActionBarProps = buyActionBarProps,
            Size = UDim2.new(1, 0, 1, 0),
            renderTryOnViewport = tbl2.renderTryOnViewport,
            tryOnState = tryOnState,
            backgroundImageUrl = avatarBackgroundImageUrl,
            thumbnailPadding = selectedItem
                and {
                    left = UDim.new(0, var11.Padding.XXLarge),
                    right = UDim.new(0, var11.Padding.XXLarge),
                    top = UDim.new(0, var11.Padding.XXLarge),
                    bottom = UDim.new(0, var11.Padding.XXLarge)
                }
                or avatarBackgroundImageUrl and {
                    top = UDim.new(0, var11.Padding.Medium)
                }
                or nil
        }

        return createElement(var19, tbl3)
    end

    local tbl3 = {
        view = view,
        renderFirstPanel = renderFirstPanel,
        renderSecondPanel = 0,
        panelConfig = 0
    }

    if view ~= ViewType.WideLandscape
        and not (if view == ViewType.Wide then not selectedItem else view == ViewType.Compact and not selectedItem)
    then
        func2 = nil
    end

    tbl3.renderSecondPanel = func2
    tbl3.panelConfig = tbl1[view] or tbl1[ViewType.Wide]
    return tbl3
end
