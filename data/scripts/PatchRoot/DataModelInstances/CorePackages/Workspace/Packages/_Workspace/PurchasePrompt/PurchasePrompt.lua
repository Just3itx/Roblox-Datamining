-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T06:40:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local script2 = script
local script2Parent = script2.Parent
local PurchasePromptDeps = require(script2Parent.PurchasePromptDeps)
local PurchasePromptLite = require(script2Parent.PurchasePromptLite)
local RunService = game:GetService("RunService")
local SharedFlags = require(script2Parent.SharedFlags)

local Roact = PurchasePromptDeps.Roact
local Rodux = PurchasePromptDeps.Rodux

local CoreGui = game:GetService("CoreGui")
local PurchasePromptApp = require(script.Components.PurchasePromptApp)
local Reducer = require(script2.Reducers.Reducer)
local ABTest = require(script2.Services.ABTest)
local Network = require(script2.Services.Network)
local Analytics = require(script2.Services.Analytics)
local PlatformInterface = require(script2.Services.PlatformInterface)
local ExternalSettings = require(script2.Services.ExternalSettings)
local PublicBindables = require(script2.Services.PublicBindables)
local Thunk = require(script2.Thunk)
local initiateAvatarCreationFeePurchase = require(script2.Thunks.initiateAvatarCreationFeePurchase)
local UnifiedPurchasePrompt = require(script2.Components.UnifiedPurchasePrompt)
local dispatchPurchaseForProductPayload = require(script2.Utils.dispatchPurchaseForProductPayload)
local SetProductPayload = require(script2.Actions.SetProductPayload)
local SetPurchaseAnalyticsMetadata = require(script2.Actions.SetPurchaseAnalyticsMetadata)

local FFlagAXSupportRentalPurchaseInUnifiedProductPurchaseFlow = require(script2.Parent.SharedFlags).FFlagAXSupportRentalPurchaseInUnifiedProductPurchaseFlow
local FFlagEnablePurchasePayloadInExperienceShop = SharedFlags.FFlagEnablePurchasePayloadInExperienceShop
local FFlagPassShopPurchaseSurfaceToBuyModal = SharedFlags.FFlagPassShopPurchaseSurfaceToBuyModal
local FFlagSkipBuyDelayForExperienceShop = require(script2.Flags.FFlagSkipBuyDelayForExperienceShop)
local _types = require(script2.types)

local FFlagPurchasePromptSubtitleForTimedOptions = require(script2.Parent.SharedFlags).FFlagPurchasePromptSubtitleForTimedOptions
local FFlagAXMISWithBlackbird = SharedFlags.FFlagAXMISWithBlackbird
local FFlagEnableRobuxInExperienceShop = SharedFlags.FFlagEnableRobuxInExperienceShop
local bool1 = game:DefineFastFlag("PurchasePromptElevateDisplayOrder", false)

local WindowState = require(script2.Enums.WindowState)
local PromptState = require(script2.Enums.PromptState)
local PublishAssetAnalytics = require(script2.Utils.PublishAssetAnalytics)

local var1 = nil
local store = nil

local var2 = nil

local bindableEvent = Instance.new("BindableEvent")
local bindableEvent2 = Instance.new("BindableEvent")

local function createStore()
    local abTest = ABTest.new()
    var2 = Network.new()

    local analytics = Analytics.new()
    local platformInterface = PlatformInterface.new()
    local externalSettings = ExternalSettings.new()

    local publicBindables = PublicBindables.new({ windowStateChangedBindable = bindableEvent })

    store = Rodux.Store.new(Reducer, {}, { Thunk.middleware({
            [ABTest] = abTest,
            [Network] = var2,
            [Analytics] = analytics,
            [PlatformInterface] = platformInterface,
            [ExternalSettings] = externalSettings,
            [PublicBindables] = publicBindables
        }) })

    store.changed:connect(function(arg1, arg2)
        if arg2.windowState ~= arg1.windowState then
            bindableEvent:Fire(
                {
                    isShown = arg1.windowState == WindowState.Shown,
                    hasCompletedPurchase = arg1.hasCompletedPurchase
                }
            )
        end

        if arg2.promptState ~= arg1.promptState and arg1.promptState == PromptState.None then
            bindableEvent2:Fire()
        end

        if not arg2.hasCompletedPurchase and arg1.hasCompletedPurchase then
            PurchasePromptLite.Events.firePurchaseCompleted()
        end
    end)
end

local function initiateAvatarCreationFeePurchase2(arg1, arg2, arg3, arg4)
    if not store then
        error("initiateAvatarCreationFeePurchase cannot be called when the PurchasePrompt has not been mounted")
    end

    store:dispatch(initiateAvatarCreationFeePurchase(arg1, arg2, arg3, arg4))
end

local function initiatePurchaseForProductPayload(arg1, arg2)
    if not store then
        warn("initiatePurchaseForProductPayload called before mountPurchasePrompt; ignoring.")
        return
    end

    if FFlagEnablePurchasePayloadInExperienceShop or FFlagSkipBuyDelayForExperienceShop then
        store:dispatch(SetProductPayload(arg1))
    end

    if FFlagPassShopPurchaseSurfaceToBuyModal and arg2 then
        store:dispatch(SetPurchaseAnalyticsMetadata({ surface = arg2.surface, productUniverseId = arg2.productUniverseId }))
    end

    dispatchPurchaseForProductPayload(function(arg3)
        store:dispatch(arg3)
    end, arg1, nil, false)
end

local function UnifiedPurchasePromptContainer(tbl1)
    createStore()

    return Roact.createElement(UnifiedPurchasePrompt, {
        store = store,
        network = var2,
        productPayload = tbl1.productPayload,
        purchaseCallbacks = tbl1.purchaseCallbacks,
        postPurchaseActions = tbl1.postPurchaseActions,
        purchaseAnalyticsMetadata = tbl1.purchaseAnalyticsMetadata,
        purchaseOptions = if FFlagAXSupportRentalPurchaseInUnifiedProductPurchaseFlow then tbl1.purchaseOptions else nil,
        subtitleView = if FFlagPurchasePromptSubtitleForTimedOptions then tbl1.subtitleView else nil
    })
end

local module = {}

function module.mountPurchasePrompt()
    if RunService:IsStudio() and RunService:IsEdit() or var1 then
        return nil
    end

    createStore()

    local tbl1 = { AutoLocalize = false, IgnoreGuiInset = true }

    if bool1 then
        tbl1.DisplayOrder = 10
    end

    local element = Roact.createElement("ScreenGui", tbl1, { Roact.createElement(PurchasePromptApp, { store = store, network = var2 }) })

    var1 = Roact.mount(element, CoreGui, "PurchasePromptApp")

    return var1
end

module.initiateAvatarCreationFeePurchase = initiateAvatarCreationFeePurchase2
module.initiatePurchaseForProductPayload = initiatePurchaseForProductPayload

module.windowStateChangedEvent = bindableEvent.Event

module.promptStateSetToNoneEvent = bindableEvent2.Event
module.Utils = FFlagAXMISWithBlackbird
    and {
        getBlackbirdUpsellBannerProductInfo = require(script2.Utils.getBlackbirdUpsellBannerProductInfo)
    }
    or {}

module.PublishAssetAnalytics = PublishAssetAnalytics
module.UnifiedPurchasePromptContainer = UnifiedPurchasePromptContainer

module.launchRobuxPackagePurchase = if FFlagEnableRobuxInExperienceShop then require(script2.launchRobuxPackagePurchase) else nil

module["jest.config"] = script["jest.config"]
module["jest.main.config"] = script["jest.main.config"]
module["jest.mockDataModel.config"] = script["jest.mockDataModel.config"]
return module
