-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:10:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local GuiService = game:GetService("GuiService")
local CoreGui = game:GetService("CoreGui")
local scriptParentParent = script.Parent.Parent
local React = require(CorePackages.Packages.React)
local AvatarExperienceFlags = require(CorePackages.Workspace.Packages.AvatarExperienceFlags)
local AvatarViewport = require(scriptParentParent.Components.AvatarViewport)
local AvatarExperienceInspectAndBuy = require(CorePackages.Workspace.Packages.AvatarExperienceInspectAndBuy)
local PopoverFocusRestorationContext = require(CorePackages.Workspace.Packages.AvatarExperienceTimedOptions).PopoverFocusRestorationContext
local useViewBreakpoints = AvatarExperienceInspectAndBuy.Hooks.useViewBreakpoints
local ResponsivePanelLayout = AvatarExperienceInspectAndBuy.Components.ResponsivePanelLayout
local useResponsivePanelLayoutProps = AvatarExperienceInspectAndBuy.Hooks.useResponsivePanelLayoutProps
local applyTryOnItemToHumanoidDescription = AvatarExperienceInspectAndBuy.Utils.applyTryOnItemToHumanoidDescription
local useInspectAndBuyFocusNavigation = AvatarExperienceInspectAndBuy.Hooks.useInspectAndBuyFocusNavigation
local buildBulkPurchaseAnalyticsPayload = AvatarExperienceInspectAndBuy.Utils.buildBulkPurchaseAnalyticsPayload

local UpdateBulkPuchaseResults = require(scriptParentParent.Actions.UpdateBulkPuchaseResults)
local GetProductInfo = require(scriptParentParent.Thunks.GetProductInfo)
local GetFavoriteForAsset = require(scriptParentParent.Thunks.GetFavoriteForAsset)
local GetFavoriteForBundle = require(scriptParentParent.Thunks.GetFavoriteForBundle)
local CreateFavoriteForAsset = require(scriptParentParent.Thunks.CreateFavoriteForAsset)
local DeleteFavoriteForAsset = require(scriptParentParent.Thunks.DeleteFavoriteForAsset)
local CreateFavoriteForBundle = require(scriptParentParent.Thunks.CreateFavoriteForBundle)
local DeleteFavoriteForBundle = require(scriptParentParent.Thunks.DeleteFavoriteForBundle)
local PromptPurchase = require(scriptParentParent.Thunks.PromptPurchase)
local GetItemDetails = require(scriptParentParent.Thunks.GetItemDetails)
local RoactUtils = require(CorePackages.Workspace.Packages.RoactUtils)
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector
local ItemTypeEnum = require(CorePackages.Workspace.Packages.AvatarExperienceModel).Enums.ItemTypeEnum

local OpenOverlay = require(scriptParentParent.Actions.OpenOverlay)
local Overlay = require(scriptParentParent.Enums.Overlay)
local Overlay2 = require(scriptParentParent.Components.Overlay)

local useUnifiedEventListenerInExperience = require(CorePackages.Workspace.Packages.AvatarExperienceAnalytics).useUnifiedEventListener.useUnifiedEventListenerInExperience

local Signals = require(CorePackages.Packages.Signals)
local useSignalState = require(CorePackages.Packages.SignalsReact).useSignalState
local AvatarBackground = require(CorePackages.Workspace.Packages.DataHydration.AvatarBackground)

local Foundation = require(CorePackages.Packages.Foundation)
local useTokens = Foundation.Hooks.useTokens
local Modules = CoreGui.RobloxGui.Modules
local Theme = require(Modules.Settings.Theme)
local Constants = require(Modules.TopBar.Constants)
local tutils = require(CorePackages.Packages.tutils)

local bool1 = game:DefineFastFlag("EnableAvatarViewportAutoRotation", false)

local cameraFieldOfView = game:DefineFastInt("AXViewportCameraFieldOfView", 68)
local FFlagAXEnableBatchItemDetailsFetchV2 = AvatarExperienceFlags.FFlagAXEnableBatchItemDetailsFetchV2
local FFlagAXEnableInspectAndBuyFocusNavigation = AvatarExperienceFlags.FFlagAXEnableInspectAndBuyFocusNavigation
local FFlagAXInspectAndBuyAvatarBackground = AvatarExperienceFlags.FFlagAXInspectAndBuyAvatarBackground
local ItemSelectionStoreContext = AvatarExperienceInspectAndBuy.Contexts.ItemSelectionStoreContext
local Provider = ItemSelectionStoreContext.Provider
local useItemSelectionStore = ItemSelectionStoreContext.useItemSelectionStore

local function func1(arg1)
    return arg1.assets
end

local function func2(arg1)
    return arg1.collectibleResellableInstances
end

local function func3(arg1)
    return arg1.bundles
end

local function useAvatarBackgroundImageUrl(playerId: number?)
    local var1 = React.useMemo(function()
        local var1 = if playerId == nil then nil else AvatarBackground.getAvatarBackgroundStore(false).getAndFetchAvatarBackground(playerId)

        return Signals.createComputed(function(arg1)
            local var2 = var1 and var1.data(arg1)
            local assetId = var2 and var2.assetId
            if assetId then
                return (AvatarBackground.getAvatarBackgroundImageUrl(assetId))
            end

            return nil
        end)
    end, { playerId })
    return useSignalState(var1)
end

local function InspectAndBuyBaseContainer(arg1)
    local var1 = useViewBreakpoints(Constants.TopBarHeight)
    local var2 = useTokens()
    local var3 = useDispatch()

    local var4 = useItemSelectionStore()
    local var5 = useSignalState(var4.getItemDataMap)

    local assetsMap = useSelector(func1, tutils.deepEqual)
    local collectibleResellableInstances = useSelector(func2, tutils.deepEqual)
    local bundlesMap = useSelector(func3, tutils.deepEqual)
    local avatarBackgroundImageUrl = if FFlagAXInspectAndBuyAvatarBackground then useAvatarBackgroundImageUrl(arg1.playerId) else nil

    local onInspectMenuClosed = React.useCallback(function()
        GuiService:CloseInspectMenu()
    end, {})

    local onBulkPurchaseFinished = React.useCallback(function(_, _, arg2)
        var3(UpdateBulkPuchaseResults(arg2))

        for _, item in arg2.Items do
            if item.status ~= Enum.MarketplaceItemPurchaseStatus.Success then
                continue
            end

            local bool2 = item.type == Enum.MarketplaceProductType.AvatarAsset
            local id = item.id
            local avatarItemType = if bool2 then Enum.AvatarItemType.Asset else Enum.AvatarItemType.Bundle
            local itemType = if bool2 then ItemTypeEnum.Asset else ItemTypeEnum.Bundle
            local storedData = var5[tostring(id)]
            local bulkPurchaseAnalyticsPayload = buildBulkPurchaseAnalyticsPayload({
                itemId = tostring(id),
                itemType = itemType,
                assetsMap = assetsMap,
                bundlesMap = bundlesMap,
                collectibleResellableInstances = collectibleResellableInstances,
                storedData = storedData
            })
            if bulkPurchaseAnalyticsPayload then
                arg1.analytics.reportPurchaseSuccessUnifiedEvent(itemType, id, bulkPurchaseAnalyticsPayload)
            end
            var3(GetItemDetails(id, avatarItemType))
        end
    end, {
        var3,
        assetsMap,
        bundlesMap,
        collectibleResellableInstances,
        var5,
        arg1.analytics.reportPurchaseSuccessUnifiedEvent
    })

    local onItemDetailsOpened = React.useCallback(function(arg2)
        if arg2.itemType == ItemTypeEnum.Asset then
            var3(GetFavoriteForAsset(arg2.id))
            var3(GetProductInfo(arg2.id))

            if FFlagAXEnableBatchItemDetailsFetchV2 then
                var3(GetItemDetails(arg2.id, Enum.AvatarItemType.Asset))
            end
        elseif arg2.itemType == ItemTypeEnum.Bundle then
            var3(GetFavoriteForBundle(arg2.id))
        end
    end, { var3 })

    local onToggleFavorite = React.useCallback(function(arg2, bool2: boolean)
        if arg2.itemType == ItemTypeEnum.Asset then
            if bool2 then
                var3(DeleteFavoriteForAsset(arg2.id))
                return
            end
            var3(CreateFavoriteForAsset(arg2.id))
            return
        end
        if arg2.itemType ~= ItemTypeEnum.Bundle then
            return
        end

        if bool2 then
            var3(DeleteFavoriteForBundle(arg2.id))
            return
        end
        var3(CreateFavoriteForBundle(arg2.id))
    end, { var3 })

    local openAttributionOverlay = React.useCallback(function(arg2)
        var3(OpenOverlay(Overlay.AttributionTraversal, arg2))
    end, { var3 })

    local function onPromptPurchase(arg2, arg3, arg4, arg5, arg6, arg7, arg8)
        var3(PromptPurchase(arg2, arg3, arg4, arg5, arg6, arg7, arg8))
    end

    local renderTryOnViewport = React.useCallback(function(arg2)
        if not (arg1.localPlayerModel and arg1.localPlayerModel.Humanoid) then
            return nil
        end

        local humanoidDescription = arg1.localPlayerModel.Humanoid.HumanoidDescription:Clone()
        applyTryOnItemToHumanoidDescription(arg2, humanoidDescription)
        return React.createElement(AvatarViewport, {
            size = UDim2.new(1, 0, 1, 0),
            position = UDim2.new(0.5, 0, 0.5, 0),
            humanoidDescription = humanoidDescription,
            model = arg1.localPlayerModel,
            visible = true,
            backgroundTransparency = 1,
            disableAutoRotation = not bool1,
            offsetOptions = {
                defaultCameraOffset = CFrame.new(0, 0.5, -5),
                toolOffset = CFrame.new(0, 2, -8)
            },
            cameraFieldOfView = cameraFieldOfView,
            resetCameraAndAutoRotationOnModelChange = true
        })
    end, { arg1.localPlayerModel })

    local var16 = useResponsivePanelLayoutProps({
        onInspectMenuClosed = onInspectMenuClosed,
        onBulkPurchaseFinished = onBulkPurchaseFinished,
        onItemDetailsOpened = onItemDetailsOpened,
        onToggleFavorite = onToggleFavorite,
        openAttributionOverlay = openAttributionOverlay,
        onPromptPurchase = onPromptPurchase,
        renderTryOnViewport = renderTryOnViewport,
        localPlayerModel = arg1.localPlayerModel,
        analytics = arg1.analytics,
        avatarBackgroundImageUrl = avatarBackgroundImageUrl
    })

    useUnifiedEventListenerInExperience()

    if not FFlagAXEnableInspectAndBuyFocusNavigation then
        return (React.createElement(Foundation.View, {
            Size = var1.OverlaySize,
            Position = var1.OverlayPosition,
            backgroundStyle = var2.Color.Common.Shadow,
            stateLayer = {
                affordance = Foundation.Enums.StateLayerAffordance.None
            },
            onActivated = function()
                GuiService:CloseInspectMenu()
            end
        }, {
            ContainerView = React.createElement(Foundation.View, {
                AnchorPoint = var1.ContainerAnchorPoint,
                ClipsDescendants = true,
                Size = var1.ContainerSize,
                Position = var1.ContainerPosition,
                backgroundStyle = {
                    Color3 = Theme.color("MenuContainer"),
                    Transparency = Theme.transparency("MenuContainer", 1) * GuiService.PreferredTransparency
                },
                stateLayer = {
                    affordance = Foundation.Enums.StateLayerAffordance.None
                },
                onActivated = function() end
            }, {
                UICorner = React.createElement("UICorner", { CornerRadius = Theme.DefaultCornerRadius }),
                ResponsivePanelLayout = React.createElement(ResponsivePanelLayout, var16)
            }),
            Overlay = React.createElement(Overlay2)
        }))
    end

    local var17 = useInspectAndBuyFocusNavigation()

    local inspectAndBuyContent = React.createElement("Frame", {
        ref = var17.setFocusRef,
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        SelectionGroup = var17.focusNavigationProps.SelectionGroup,
        SelectionBehaviorDown = var17.focusNavigationProps.SelectionBehaviorDown,
        SelectionBehaviorLeft = var17.focusNavigationProps.SelectionBehaviorLeft,
        SelectionBehaviorRight = var17.focusNavigationProps.SelectionBehaviorRight,
        SelectionBehaviorUp = var17.focusNavigationProps.SelectionBehaviorUp
    }, {
        Content = React.createElement(Foundation.View, {
            Size = var1.OverlaySize,
            Position = var1.OverlayPosition,
            backgroundStyle = var2.Color.Common.Shadow,
            stateLayer = {
                affordance = Foundation.Enums.StateLayerAffordance.None
            },
            onActivated = function()
                GuiService:CloseInspectMenu()
            end
        }, {
            ContainerView = React.createElement(Foundation.View, {
                AnchorPoint = var1.ContainerAnchorPoint,
                ClipsDescendants = true,
                Size = var1.ContainerSize,
                Position = var1.ContainerPosition,
                backgroundStyle = {
                    Color3 = Theme.color("MenuContainer"),
                    Transparency = Theme.transparency("MenuContainer", 1) * GuiService.PreferredTransparency
                },
                stateLayer = {
                    affordance = Foundation.Enums.StateLayerAffordance.None
                },
                onActivated = function() end
            }, {
                UICorner = React.createElement("UICorner", { CornerRadius = Theme.DefaultCornerRadius }),
                ResponsivePanelLayout = React.createElement(ResponsivePanelLayout, var16)
            }),
            Overlay = React.createElement(Overlay2)
        })
    })

    return (React.createElement(
        PopoverFocusRestorationContext.Provider,
        { value = true },
        { InspectAndBuyContent = inspectAndBuyContent }
    ))
end

local function InspectAndBuyBaseContainerWithSignalsProvider(arg1)
    return React.createElement(Provider, {}, { Inner = React.createElement(InspectAndBuyBaseContainer, arg1) })
end

return InspectAndBuyBaseContainerWithSignalsProvider
