-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:01:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local _DeveloperProduct = require(BuildExperienceParent.DataHydration.DeveloperProduct)
local DeveloperSubscription = require(BuildExperienceParent.DataHydration.DeveloperSubscription)
local GamePassConfig = require(BuildExperienceParent.DataHydration.GamePassConfig)
local GamePermissions = require(BuildExperienceParent.DataHydration.GamePermissions)
local _MonetizationOptions = require(BuildExperienceParent.DataHydration.MonetizationOptions)
local UniverseConfiguration = require(BuildExperienceParent.DataHydration.UniverseConfiguration)
local Localization = require(BuildExperienceParent.Localization)
local Promise = require(BuildExperienceParent.Promise)
local React = require(BuildExperienceParent.React)
local Signals = require(BuildExperienceParent.Signals)
local SignalsReact = require(BuildExperienceParent.SignalsReact)

local createManageDevProductStore = require(BuildExperience.Chat.createManageDevProductStore)
local createManageMonetizationOptionsStore = require(BuildExperience.Chat.createManageMonetizationOptionsStore)
local MonetizationPageView = require(script.Parent.MonetizationPageView)
local getProductKindCapabilities = require(script.Parent.getProductKindCapabilities)
local mapDeveloperProductsToMonetizationProducts = require(script.Parent.mapDeveloperProductsToMonetizationProducts)
local mapMonetizationCatalog = require(script.Parent.mapMonetizationCatalog)
local useMonetizationPageViewModel = require(script.Parent.useMonetizationPageViewModel)
local LocalizationStrings = require(BuildExperience.LocalizationStrings)
local sendBuildExperienceEvent = require(BuildExperience.Telemetry.sendBuildExperienceEvent)
local useGamePermissions = require(BuildExperience.useGamePermissions)
local FFlagBuildCheckGamePermissions = require(BuildExperience.Flags.FFlagBuildCheckGamePermissions)
local FFlagBuildExperienceManageDevProduct = require(BuildExperience.Flags.FFlagBuildExperienceManageDevProduct)
local FFlagBuildExperienceMonetizationNativeUI = require(BuildExperience.Flags.FFlagBuildExperienceMonetizationNativeUI)
local FFlagBuildExperienceMonetizationMultiKind = require(BuildExperience.Flags.FFlagBuildExperienceMonetizationMultiKind)

local FFlagBuildExperienceMonetizationProductEditing = require(BuildExperience.Flags.FFlagBuildExperienceMonetizationProductEditing)
local FFlagBuildExperienceMonetizationManageKinds = require(BuildExperience.Flags.FFlagBuildExperienceMonetizationManageKinds)

local FFlagBuildExperienceMonetizationKindRegionalPricing = require(BuildExperience.Flags.FFlagBuildExperienceMonetizationKindRegionalPricing)

local FFlagBuildExperienceDevProductModerationReadback = require(BuildExperience.Flags.FFlagBuildExperienceDevProductModerationReadback)
local var1 = FFlagBuildExperienceManageDevProduct or FFlagBuildExperienceMonetizationNativeUI

local function normalizeSourceStatus(str1: string, isIncomplete: boolean): string -- Luacid: Inlined by compiler; 3 call sites recovered
    return if isIncomplete or str1 == "Failed" then "Failed" elseif str1 == "Ready" then "Ready" else "NotReady"
end

local signal = Signals.createSignal(nil)
local signal2 = Signals.createSignal(nil)
local signal3 = Signals.createSignal(nil)
local signal4 = Signals.createSignal(nil)
local signal5 = Signals.createSignal(nil)
local signal6 = Signals.createSignal(nil)
local signal7 = Signals.createSignal(nil)
local signal8 = Signals.createSignal("Ready")
local signal9 = Signals.createSignal("NotReady")
local computed = Signals.createComputed(function()
    return createManageDevProductStore()
end)
local computed2 = Signals.createComputed(function()
    return createManageMonetizationOptionsStore()
end)

local function combineCatalogStatus(tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    local str1 = "Ready"
    for _, value in tbl1 do
        if value.status == "Failed" then
            return "Failed"
        end

        if value.status ~= "Ready" then
            str1 = "NotReady"
        end
    end

    return str1
end

local function useMixedCatalog(arg1, bool1: boolean, arg2, arg3, tbl1, bool2: boolean)
    local var2 = SignalsReact.useSignalState(GamePassConfig.getGamePassConfigStore)
    local var3 = SignalsReact.useSignalState(DeveloperSubscription.getDeveloperSubscriptionStore)
    local var4 = SignalsReact.useSignalState(var2.getAccountResetGeneration)
    local var5 = SignalsReact.useSignalState(var3.getAccountResetGeneration)
    local var6 = React.useMemo(function()
        if arg1.products ~= nil or arg1.universeId == nil then
            return nil
        end
        return var2.fetchGamePasses(arg1.universeId)
    end, {
        var4,
        var2,
        arg1.products ~= nil,
        arg1.universeId or 0
    })

    local var7 = React.useMemo(function()
        if arg1.products ~= nil or arg1.universeId == nil then
            return nil
        end
        return var3.fetchSubscriptions(arg1.universeId)
    end, {
        arg1.products ~= nil,
        arg1.universeId or 0,
        var5,
        var3
    })

    local gamePassCatalog = SignalsReact.useSignalState(if var6 ~= nil then var6.data else signal2)
    local var9 = SignalsReact.useSignalState(if var6 ~= nil then var6.status else signal8)

    local subscriptionCatalog = SignalsReact.useSignalState(if var7 ~= nil then var7.data else signal3)

    local var11 = SignalsReact.useSignalState(if var7 ~= nil then var7.status else signal8)
    local isIncomplete = not (arg2 == nil) and arg2.nextPageToken ~= nil
    local bool3 = not (gamePassCatalog == nil) and gamePassCatalog.isIncomplete == true
    local bool4 = not (subscriptionCatalog == nil) and subscriptionCatalog.isIncomplete == true
    local status = normalizeSourceStatus(arg3, isIncomplete)
    local str1 = normalizeSourceStatus(var9, bool3)
    local str2 = normalizeSourceStatus(var11, bool4)

    local catalogSources = React.useMemo(function()
        if arg1.products ~= nil then
            return {}
        end
        return {
            {
                kind = "GamePass",
                label = tbl1.gamePassSection,
                status = str1,
                hasCachedProducts = not (gamePassCatalog == nil) and #gamePassCatalog.gamePasses > 0,
                isIncomplete = bool3
            },
            {
                kind = "DeveloperProduct",
                label = tbl1.productSection,
                status = status,
                hasCachedProducts = not (arg2 == nil) and #arg2.developerProducts > 0,
                isIncomplete = isIncomplete
            },
            {
                kind = "Subscription",
                label = tbl1.subscriptionSection,
                status = str2,
                hasCachedProducts = not (subscriptionCatalog == nil) and #subscriptionCatalog.developerSubscriptions > 0,
                isIncomplete = bool4
            }
        }
    end, {
        status,
        str1,
        if arg2 == nil then 0 else #arg2.developerProducts,
        if gamePassCatalog == nil then 0 else #gamePassCatalog.gamePasses,
        if subscriptionCatalog == nil then 0 else #subscriptionCatalog.developerSubscriptions,
        isIncomplete,
        bool3,
        bool4,
        tbl1.gamePassSection,
        tbl1.productSection,
        tbl1.subscriptionSection,
        arg1.products ~= nil,
        str2
    })

    local var13 = React.useRef({})
    local var14 = React.useRef(nil)
    React.useEffect(function()
        if var14.current ~= arg1.universeId then
            var14.current = arg1.universeId
            table.clear(var13.current)
        end
        for _, value in catalogSources do
            if value.status == "NotReady" then
                var13.current[value.kind] = nil
            elseif var13.current[value.kind] ~= value.status then
                var13.current[value.kind] = value.status
                sendBuildExperienceEvent(
                    if value.status == "Ready" then "MONETIZATION_CATALOG_LOAD_SUCCESS" else "MONETIZATION_CATALOG_LOAD_FAILURE",
                    {
                        universeId = arg1.universeId,
                        placeId = arg1.placeId,
                        conversationId = arg1.sessionId
                    },
                    {
                        catalogKind = tostring(value.kind),
                        hasCachedProducts = tostring(value.hasCachedProducts),
                        isIncomplete = tostring(value.isIncomplete)
                    }
                )
            end
        end
    end, {
        catalogSources,
        arg1.placeId,
        arg1.sessionId,
        arg1.universeId
    })

    local onRetryAll = React.useCallback(function()
        if arg1.products == nil and arg1.universeId ~= nil then
            bool1.fetchProducts(arg1.universeId)
            var2.fetchGamePasses(arg1.universeId)
            var3.fetchSubscriptions(arg1.universeId)
        end
    end, {
        bool1,
        var2,
        arg1.products,
        arg1.universeId,
        var3
    })

    local onRetrySource = React.useCallback(function(arg4)
        if arg1.products ~= nil or arg1.universeId == nil then
            return
        end

        if arg4 == "DeveloperProduct" then
            bool1.fetchProducts(arg1.universeId)
        elseif arg4 == "GamePass" then
            var2.fetchGamePasses(arg1.universeId)
        elseif arg4 == "Subscription" then
            var3.fetchSubscriptions(arg1.universeId)
        end
    end, {
        bool1,
        var2,
        arg1.products,
        arg1.universeId,
        var3
    })

    local var17 = React.useCallback(function(arg4, str4: string, tbl2)
        local universeId = arg1.universeId
        local productKindCapabilities = getProductKindCapabilities(arg4)
        if universeId == nil or productKindCapabilities == nil then
            return Promise.reject("This product cannot be changed from here")
        elseif arg4 == "GamePass" then
            local var17 = tonumber(str4)
            if var17 == nil then
                return Promise.reject("This product cannot be changed from here")
            elseif tbl2.isForSale ~= nil then
                if tbl2.isForSale then
                    return (var2.activate(universeId, var17))
                end

                return (var2.deactivate(universeId, var17))
            else
                local function write() -- Luacid: Inlined by compiler; 1 call site recovered
                    return var2.update(universeId, var17, { isManagedPricingEnabled = tbl2.isManagedPricingEnabled })
                end

                if tbl2.isManagedPricingEnabled == true then
                    return (bool2.ensureManagedPricingAccepted(universeId):andThen(write))
                end

                return (write())
            end
        elseif tbl2.isForSale == nil then
            return Promise.reject("This product cannot be changed from here")
        elseif tbl2.isForSale then
            return (var3.activate(universeId, str4))
        else
            return (var3.deactivate(universeId, str4, false))
        end
    end, {
        var2,
        bool2,
        arg1.universeId or 0,
        var3
    })

    local onUpdateProductDetails = if FFlagBuildExperienceMonetizationManageKinds then React.useCallback(function(arg4, str4: string, arg5)
        local universeId = arg1.universeId
        if universeId == nil then
            return Promise.reject("This product cannot be changed from here")
        elseif arg4 == "GamePass" then
            local var18 = tonumber(str4)
            if var18 == nil then
                return Promise.reject("This product cannot be changed from here")
            end
            return var2.update(
                universeId,
                var18,
                {
                    name = arg5.name,
                    description = arg5.description,
                    priceInRobux = arg5.priceInRobux
                },
                { acceptModeratedText = true }
            )
        elseif arg4 == "Subscription" then
            return var3.update(universeId, str4, { description = arg5.description }, { acceptModeratedText = true }):andThen(function(arg6)
                return {
                    name = arg6.name,
                    description = arg6.description,
                    priceInformation = arg6.currencyType == DeveloperSubscription.CurrencyType.Robux and {
                        defaultPriceInRobux = arg6.priceInRobux
                    } or nil
                }
            end)
        else
            return Promise.reject("This product cannot be changed from here")
        end
    end, { var2, arg1.universeId or 0, var3 }) else nil

    local var19 = nil

    local onUpdateSaleStatus = if FFlagBuildExperienceMonetizationManageKinds then React.useCallback(function(arg4, str4: string, isForSale: boolean)
        return var17(arg4, str4, { isForSale = isForSale })
    end, { var17 }) else nil

    if FFlagBuildExperienceMonetizationKindRegionalPricing then
        var19 = React.useCallback(function(arg4, str4: string, isManagedPricingEnabled: boolean)
            return var17(arg4, str4, { isManagedPricingEnabled = isManagedPricingEnabled })
        end, { var17 })
    end

    return {
        gamePassCatalog = gamePassCatalog,
        subscriptionCatalog = subscriptionCatalog,
        catalogSources = catalogSources,
        status = combineCatalogStatus(catalogSources),
        onRetryAll = onRetryAll,
        onRetrySource = onRetrySource,
        onUpdateSaleStatus = onUpdateSaleStatus,
        onUpdateManagedPricing = var19,
        onUpdateProductDetails = onUpdateProductDetails
    }
end

local function getProductLocalizationKeys()
    return {
        priceUnavailable = LocalizationStrings.MONETIZATION_PRICE_UNAVAILABLE,
        productType = LocalizationStrings.AGENT_DEV_PRODUCT_TITLE,
        productSection = if FFlagBuildExperienceMonetizationMultiKind then LocalizationStrings.MONETIZATION_DEVELOPER_PRODUCTS else nil,
        gamePassType = if FFlagBuildExperienceMonetizationMultiKind then LocalizationStrings.MONETIZATION_GAME_PASS else nil,
        gamePassSection = if FFlagBuildExperienceMonetizationMultiKind then LocalizationStrings.MONETIZATION_PASSES else nil,
        subscriptionType = if FFlagBuildExperienceMonetizationMultiKind then LocalizationStrings.AGENT_SUBSCRIPTION_TITLE else nil,
        subscriptionSection = if FFlagBuildExperienceMonetizationMultiKind then LocalizationStrings.MONETIZATION_SUBSCRIPTIONS else nil,
        onSale = LocalizationStrings.MONETIZATION_ON_SALE,
        offSale = LocalizationStrings.MONETIZATION_OFF_SALE
    }
end

local function useResultState(tbl1, func1: (...any) -> (...any)) -- Luacid: Inlined by compiler; 1 call site recovered
    local useSignalState = SignalsReact.useSignalState

    if tbl1 ~= nil then
        func1 = tbl1.data
    end

    return useSignalState(func1), (SignalsReact.useSignalState(if tbl1 ~= nil then tbl1.status else signal9))
end

local function MonetizationPageContainer(arg1)
    local var2 = React.useContext(Localization.LocalizationRoactContext)
    local var3 = Localization.Hooks.useLocalization((getProductLocalizationKeys()))

    local var4 = computed()
    local var5 = nil
    local var6 = nil
    if FFlagBuildExperienceMonetizationNativeUI then
        var5 = computed2()

        var6 = SignalsReact.useSignalState(UniverseConfiguration.getUniverseConfigurationStore)
    end

    local var7 = if FFlagBuildExperienceMonetizationNativeUI then React.useMemo(function()
        if var6 == nil or arg1.universeId == nil then
            return nil
        end
        return var6.getAndFetchSummary(arg1.universeId)
    end, { arg1.universeId, var6 }) else nil

    local var8 = nil
    local str1 = "NotReady"
    if FFlagBuildExperienceMonetizationNativeUI then
        var8, str1 = useResultState(var7, signal4)
    end

    local var9 = if FFlagBuildExperienceMonetizationNativeUI then React.useMemo(function()
        if arg1.universeId == nil then
            return nil
        elseif FFlagBuildCheckGamePermissions then
            local var9 = GamePermissions.getGamePermissionsStore().getAndFetchUniversePermissions(arg1.universeId)
            return {
                data = Signals.createComputed(function(arg2): {canMonetize: any}?
                    local var10 = var9.data(arg2)
                    return if var10 == nil then nil else {
                        canMonetize = var10.canMonetize
                    }
                end),
                status = var9.status
            }
        elseif var5 == nil or var8 == nil then
            return nil
        else
            return var5.getAndFetchPermission(arg1.universeId, var8.creatorType, var8.creatorTargetId)
        end
    end, { var5, arg1.universeId, var8 }) else nil

    local var10 = nil
    local str2 = "NotReady"
    if FFlagBuildExperienceMonetizationNativeUI then
        local var11 = signal5
        local useSignalState = SignalsReact.useSignalState

        if var9 ~= nil then
            var11 = var9.data
        end

        var10 = useSignalState(var11)
        str2 = SignalsReact.useSignalState(if var9 ~= nil then var9.status else signal9)

        if not FFlagBuildCheckGamePermissions and str1 == "Failed" then
            str2 = "Failed"
        end
    end

    local var11 = if FFlagBuildExperienceMonetizationNativeUI then React.useMemo(function()
        if var5 == nil or arg1.universeId == nil then
            return nil
        end
        return var5.getAndFetchManagedPricing(arg1.universeId)
    end, { var5, arg1.universeId }) else nil

    local var12 = if FFlagBuildExperienceMonetizationNativeUI then React.useMemo(function()
        if var5 == nil or arg1.universeId == nil then
            return nil
        end
        return var5.getAndFetchShops(arg1.universeId)
    end, { var5, arg1.universeId }) else nil

    local var13 = nil
    local var14 = nil
    local str3 = "NotReady"
    local str4 = "NotReady"
    if FFlagBuildExperienceMonetizationNativeUI then
        local var15 = signal6
        local useSignalState = SignalsReact.useSignalState

        if var11 ~= nil then
            var15 = var11.data
        end

        var13 = useSignalState(var15)
        str3 = SignalsReact.useSignalState(if var11 ~= nil then var11.status else signal9)

        local var16 = signal7
        local useSignalState2 = SignalsReact.useSignalState

        if var12 ~= nil then
            var16 = var12.data
        end

        var14 = useSignalState2(var16)
        str4 = SignalsReact.useSignalState(if var12 ~= nil then var12.status else signal9)
    end
    if FFlagBuildExperienceMonetizationNativeUI then
        local var15 = React.useRef({})

        local var16 = React.useRef(nil)

        React.useEffect(function()
            if arg1.universeId == nil then
                return
            end
            if var16.current ~= arg1.universeId then
                var16.current = arg1.universeId
                table.clear(var15.current)
            end
            local function reportStatus(resource: string, arg2)
                if arg2 == "NotReady" or var15.current[resource] == arg2 then
                    return
                end

                var15.current[resource] = arg2
                sendBuildExperienceEvent(
                    if arg2 == "Ready" then "MONETIZATION_OPTIONS_LOAD_SUCCESS" else "MONETIZATION_OPTIONS_LOAD_FAILURE",
                    {
                        universeId = arg1.universeId,
                        placeId = arg1.placeId,
                        conversationId = arg1.sessionId
                    },
                    { resource = resource }
                )
            end

            reportStatus("permission", str2)
            reportStatus("managed_pricing", str3)
            reportStatus("shops", str4)
        end, {
            str3,
            str2,
            arg1.placeId,
            arg1.sessionId,
            arg1.universeId,
            str4
        })
    end

    local bool1 = if FFlagBuildExperienceMonetizationMultiKind then str2 == "Ready" and var10 ~= nil and var10.canMonetize == true else not FFlagBuildExperienceMonetizationNativeUI or str2 ~= "Ready" or var10 == nil or var10.canMonetize == true
    local var15 = if FFlagBuildExperienceMonetizationMultiKind then SignalsReact.useSignalState(var4.getAccountResetGeneration) else 0

    local tbl1 = FFlagBuildExperienceMonetizationMultiKind and {
        var15,
        var4,
        arg1.products ~= nil,
        arg1.universeId or 0
    }
        or { var4, arg1.products ~= nil, arg1.universeId or 0 }

    local var16 = React.useMemo(function()
        if arg1.products ~= nil or arg1.universeId == nil then
            return nil
        elseif var1 then
            return (var4.fetchProducts(arg1.universeId))
        end

        return (var4.getAndFetchProducts(arg1.universeId))
    end, tbl1)

    local developerProducts = SignalsReact.useSignalState(if var16 ~= nil then var16.data else signal)

    local current = SignalsReact.useSignalState(if var16 ~= nil then var16.status else signal8)
    local var19 = if FFlagBuildExperienceMonetizationMultiKind then useMixedCatalog(
        arg1,
        var4,
        developerProducts,
        current,
        {
            productSection = var3.productSection,
            gamePassSection = var3.gamePassSection,
            subscriptionSection = var3.subscriptionSection
        },
        var5
    ) else nil
    local gamePassCatalog = if var19 == nil then nil else var19.gamePassCatalog
    local subscriptionCatalog = if var19 == nil then nil else var19.subscriptionCatalog

    local products = React.useMemo(function()
        if arg1.products ~= nil then
            return arg1.products
        end
        local function formatDefaultProductName(productId: number)
            return var2:Format(LocalizationStrings.MONETIZATION_DEFAULT_PRODUCT_NAME, { PRODUCT_ID = productId })
        end

        if not FFlagBuildExperienceMonetizationMultiKind then
            return mapDeveloperProductsToMonetizationProducts(developerProducts, {
                formatDefaultProductName = formatDefaultProductName,
                priceUnavailable = var3.priceUnavailable,
                productType = var3.productType,
                onSale = var3.onSale,
                offSale = var3.offSale
            })
        end

        return mapMonetizationCatalog(
            {
                developerProducts = developerProducts,
                gamePasses = gamePassCatalog,
                subscriptions = subscriptionCatalog
            },
            {
                formatDefaultProductName = formatDefaultProductName,
                priceUnavailable = var3.priceUnavailable,
                developerProductType = var3.productType,
                gamePassType = var3.gamePassType,
                subscriptionType = var3.subscriptionType,
                onSale = var3.onSale,
                offSale = var3.offSale
            }
        )
    end, {
        developerProducts,
        var3,
        var2,
        arg1.products,
        gamePassCatalog,
        subscriptionCatalog
    })

    local var21 = React.useRef(nil)
    React.useEffect(function()
        if FFlagBuildExperienceMonetizationMultiKind or var16 == nil then
            return
        end

        if current == "NotReady" then
            var21.current = nil
            return
        end

        if var21.current == current then
            return
        end

        var21.current = current
        sendBuildExperienceEvent(
            if current == "Ready" then "MONETIZATION_CATALOG_LOAD_SUCCESS" else "MONETIZATION_CATALOG_LOAD_FAILURE",
            {
                universeId = arg1.universeId,
                placeId = arg1.placeId,
                conversationId = arg1.sessionId
            }
        )
    end, {
        var16,
        current,
        arg1.placeId,
        arg1.sessionId,
        arg1.universeId
    })

    local var22 = React.useCallback(function()
        if arg1.products == nil and arg1.universeId ~= nil then
            var4.fetchProducts(arg1.universeId)
        end
    end, { var4, arg1.products, arg1.universeId })
    if var19 ~= nil then
        var22 = var19.onRetryAll
    end

    local onRetrySource = if var19 == nil then nil else var19.onRetrySource

    local var23 = React.useCallback(function(num1: number, isManagedPricingEnabled: boolean)
        local function func1()
            return var4.update(arg1.universeId, num1, { isManagedPricingEnabled = isManagedPricingEnabled })
        end

        if FFlagBuildExperienceMonetizationNativeUI and isManagedPricingEnabled then
            return var5.ensureManagedPricingAccepted(arg1.universeId):andThen(func1)
        end
        return func1()
    end, { var4, var5, arg1.universeId })
    local onUpdateProductSaleStatus = React.useCallback(function(num1: number, isForSale: boolean)
        return var4.update(arg1.universeId, num1, { isForSale = isForSale })
    end, { var4, arg1.universeId })
    local onUpdateProduct = React.useCallback(function(num1: number, arg2)
        return var4.update(arg1.universeId, num1, arg2, FFlagBuildExperienceDevProductModerationReadback)
    end, { var4, arg1.universeId })

    local var26, var27, var28, var29

    if FFlagBuildExperienceMonetizationNativeUI then
        var26 = React.useCallback(function()
            return var5.acceptManagedPricing(arg1.universeId)
        end, { var5, arg1.universeId })

        var27 = React.useCallback(function(tbl2, bool2: boolean)
            local function refreshProducts() -- Luacid: Inlined by compiler; 2 call sites recovered
                return var4.list(arg1.universeId):catch(function()
                    return nil
                end)
            end
            return var5.updateDeveloperProductsManagedPricing(arg1.universeId, tbl2, bool2):andThen(function(arg2)
                return refreshProducts():andThen(function()
                    return arg2
                end)
            end, function(arg2)
                return refreshProducts():andThen(function()
                    return Promise.reject(arg2)
                end)
            end)
        end, { var4, var5, arg1.universeId })

        var28 = React.useCallback(function(bool2: boolean)
            return var5.setShopGlobalIcon(arg1.universeId, bool2)
        end, { var5, arg1.universeId })

        var29 = React.useCallback(function()
            local var30 = var5
            var30.fetchManagedPricing(arg1.universeId)
            var30.fetchShops(arg1.universeId)
            if FFlagBuildCheckGamePermissions then
                GamePermissions.getGamePermissionsStore().fetchUniversePermissions(arg1.universeId)
            elseif var8 ~= nil and str1 ~= "Failed" then
                var30.fetchPermission(arg1.universeId, var8.creatorType, var8.creatorTargetId)
            else
                var6.fetchSummary(arg1.universeId)
            end
        end, {
            var5,
            arg1.universeId,
            var8,
            str1,
            var6
        })
    else
        var26 = nil
        var27 = nil
        var28 = nil
        var29 = nil
    end

    local var30 = table.clone(arg1)
    var30.products = products
    if FFlagBuildCheckGamePermissions then
        var30.canEditOnBuild = useGamePermissions({ universeId = arg1.universeId }).canEditOnBuild
    end
    var30.showOptions = FFlagBuildExperienceMonetizationNativeUI and (arg1.showOptions == true or arg1.universeId ~= nil)
    if FFlagBuildExperienceMonetizationNativeUI and arg1.universeId ~= nil then
        var30.managedPricingStatus = if var13 == nil then nil else var13.status
        var30.shops = if var14 == nil then nil else var14.shops
        var30.permissionCanMonetize = if var10 == nil then nil else var10.canMonetize
        var30.managedPricingLoadStatus = str3
        var30.shopsLoadStatus = str4
        var30.permissionLoadStatus = str2
        var30.onAcceptManagedPricing = var26
        var30.onUpdateManagedPricing = var27
        var30.onSetShopButton = var28
        var30.onRetryOptions = var29
    end
    if FFlagBuildExperienceMonetizationMultiKind then
        var30.catalogSources = if arg1.products == nil then var19.catalogSources else nil
        var30.onRetryCatalogSource = onRetrySource
        var30.catalogStatus = var19.status
    elseif current == "Ready" then
        var30.catalogStatus = "Ready"
    elseif current == "Failed" then
        var30.catalogStatus = "Failed"
    else
        var30.catalogStatus = "NotReady"
    end
    var30.onRetryCatalog = var22
    if arg1.universeId == nil or not bool1 then
        var23 = nil
    end

    var30.onUpdateProductManagedPricing = var23

    if FFlagBuildExperienceMonetizationProductEditing and arg1.universeId ~= nil and bool1 then
        var30.onUpdateProductSaleStatus = onUpdateProductSaleStatus
        var30.onUpdateProduct = onUpdateProduct
        if FFlagBuildExperienceMonetizationManageKinds then
            var30.onUpdateProductKindSaleStatus = var19.onUpdateSaleStatus
            var30.onUpdateProductKind = var19.onUpdateProductDetails
        end
        if FFlagBuildExperienceMonetizationKindRegionalPricing then
            var30.onUpdateProductKindManagedPricing = var19.onUpdateManagedPricing
        end
    end
    local var31 = useMonetizationPageViewModel(var30)
    return React.createElement(MonetizationPageView, var31)
end

return MonetizationPageContainer
