-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T12:31:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProgressLoading = script:FindFirstAncestor("ProgressLoading")
local ProgressLoadingParent = ProgressLoading.Parent

local ColorMode = require(ProgressLoadingParent.Foundation).Enums.ColorMode

local MarketplaceService = game:GetService("MarketplaceService")
local RunService = game:GetService("RunService")

local React = require(ProgressLoadingParent.React)
local SignalsReact = require(ProgressLoadingParent.SignalsReact)
local Rodux = require(ProgressLoadingParent.Rodux)
local RoactRodux = require(ProgressLoadingParent.RoactRodux)

local Constants = require(ProgressLoadingParent.UIBlox).App.Style.Constants
local UiModeStyleProvider = require(ProgressLoadingParent.Style).UiModeStyleProvider
local Responsive = require(ProgressLoadingParent.Responsive)
local CachedPolicyService = require(ProgressLoadingParent.CachedPolicyService)

local LoadingScreenView = require(script.Parent.LoadingScreenView)
local FFlagEnableTiltLoadingScreen = require(ProgressLoadingParent.SharedFlags).FFlagEnableTiltLoadingScreen
local GetDeferredAssetStore = require(script.Parent.Stores.GetDeferredAssetStore)
local PregameOverride = require(script.Parent.Stores.PregameOverride)
local getJoiningPlace = require(script.Parent.getJoiningPlace)
local createNetworking = require(script.Parent.createNetworking)
local Url = require(ProgressLoadingParent.Http).Url

local EngineFeatureEnableDeferredAssetManagerService = require(ProgressLoading.Flags.EngineFeatureEnableDeferredAssetManagerService)
local FFlagBuildExperienceLibrary = require(ProgressLoadingParent.SharedFlags).FFlagBuildExperienceLibrary
local DeferredAssetManagerService = if EngineFeatureEnableDeferredAssetManagerService then game:GetService("DeferredAssetManagerService") else nil

local store = Rodux.Store.new(function(arg1)
    return arg1 or {}
end, {})

local function getIsLoadingAssets(arg1)
    local deferredAssetStore = GetDeferredAssetStore(arg1)
    return if deferredAssetStore then deferredAssetStore.getDownloadStatus(arg1) == Enum.PrefetchDownloadStatus.InProgress
        or deferredAssetStore.getPregameLoadingScreenOnly(arg1) else false
end

local function onCancel()
    if DeferredAssetManagerService then
        DeferredAssetManagerService:CancelPrefetch()
    end
end

local function PregameOverrideScreen(tbl1)
    React.useEffect(function()
        RunService:SetRobloxGuiFocused(true)
        return function()
            RunService:SetRobloxGuiFocused(false)
        end
    end, {})
    return tbl1.override.render({ displayOrder = 9999, onCancel = onCancel })
end

return React.memo(function(_) -- name: PreGameLoadingScreen
    local current = SignalsReact.useSignalState(getIsLoadingAssets)
    local placeId = if current then getJoiningPlace.getJoiningPlaceId() else 0
    local universeId = if current then getJoiningPlace.getJoiningUniverseId() else 0

    local var3 = React.useRef(nil)
    local var4

    if FFlagBuildExperienceLibrary then
        var4 = SignalsReact.useSignalState(PregameOverride.getPregameOverride)
        if not current then
            var3.current = nil
        elseif var3.current == nil then
            var3.current = os.clock()
        end
        local var5 = React.useRef(current)
        React.useEffect(function()
            if var5.current and not current then
                PregameOverride.setPregameOverride(nil)
            end
            var5.current = current
        end, { current })
    else
        var4 = nil
    end

    local preferredInputRef = React.useRef(nil)
    preferredInputRef.current = Responsive.usePreferredInput()

    local productInfo, var7 = React.useState(nil)
    React.useEffect(function()
        if FFlagEnableTiltLoadingScreen then
            return
        end
        if placeId <= 0 then
            var7(nil)
            return
        end
        local bool1 = false
        task.spawn(function()
            local success, result = pcall(function()
                return MarketplaceService:GetProductInfo(placeId)
            end)
            if success and result and not bool1 then
                var7(result)
            end
        end)
        return function()
            bool1 = true
        end
    end, { placeId })

    local var8, var9 = React.useState(0)
    React.useEffect(function()
        if FFlagEnableTiltLoadingScreen then
            return
        end
        if placeId <= 0 or universeId > 0 then
            var9(0)
            return
        end
        local bool1 = false
        local str1 = string.format("%suniverses/v1/places/%d/universe", Url.APIS_URL, placeId)
        createNetworking(str1, "GET"):andThen(function(arg1)
            if not bool1 and arg1 and arg1.responseBody and arg1.responseBody.universeId then
                var9(arg1.responseBody.universeId)
            end
        end, function() end)
        return function()
            bool1 = true
        end
    end, { placeId, universeId })

    local isSubjectToChinaPolicies, var11 = React.useState(false)
    React.useEffect(function()
        if FFlagEnableTiltLoadingScreen then
            return
        end

        local bool1 = false
        task.spawn(function()
            local isSubjectToChinaPolicies = CachedPolicyService:IsSubjectToChinaPolicies()
            if not bool1 then
                var11(isSubjectToChinaPolicies == true)
            end
        end)
        return function()
            bool1 = true
        end
    end, {})

    if not current or placeId <= 0 then
        return nil
    elseif FFlagBuildExperienceLibrary
        and var4 ~= nil
        and var3.current ~= nil
        and PregameOverride.claims(var4, placeId, var3.current)
    then
        return React.createElement(PregameOverrideScreen, { override = var4 })
    elseif FFlagEnableTiltLoadingScreen then
        local tiltLoadingScreenContainer = require(script.Parent.TiltLoadingScreen.TiltLoadingScreenContainer)
        return React.createElement(tiltLoadingScreenContainer, {
            key = tostring(placeId),
            placeId = placeId,
            deferredJoin = {
                universeId = universeId,
                assetService = DeferredAssetManagerService,
                displayOrder = 9999
            },
            onCancel = onCancel
        })
    else
        if universeId > 0 then
            var8 = universeId
        end
        return React.createElement(RoactRodux.StoreProvider, { store = store }, {
            StyleProvider = React.createElement(
                UiModeStyleProvider,
                {
                    style = {
                        themeName = ColorMode.Dark,
                        fontName = Constants.FontName.Gotham
                    }
                },
                {
                    LoadingScreen = React.createElement(LoadingScreenView, {
                        placeId = placeId,
                        universeId = var8,
                        productInfo = productInfo,
                        isSubjectToChinaPolicies = isSubjectToChinaPolicies,
                        preferredInputRef = preferredInputRef,
                        displayOrder = 9999,
                        manageRobloxGuiFocus = true,
                        onCloseButtonActivated = onCancel,
                        onGamepadCancel = onCancel
                    })
                }
            )
        })
    end
end)
