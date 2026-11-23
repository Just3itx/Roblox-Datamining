-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:01:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Promise = require(BuildExperienceParent.Promise)
local React = require(BuildExperienceParent.React)
local UrlBuilder = require(BuildExperienceParent.UrlBuilder).UrlBuilder
local useLocalization = require(BuildExperienceParent.Localization).Hooks.useLocalization
local _ChatComposer = require(BuildExperience.Components.Chat.ChatComposer)
local _ChatActions = require(BuildExperience.Components.Chat.ChatActions)
local _chatTypes = require(BuildExperience.Chat.chatTypes)
local useOnScreenKeyboardHeight = require(BuildExperience.utils.useOnScreenKeyboardHeight)
local LocalizationStrings = require(BuildExperience.LocalizationStrings)
local GetBuildPromptDraftStore = require(BuildExperience.Stores.GetBuildPromptDraftStore)
local sendBuildExperienceEvent = require(BuildExperience.Telemetry.sendBuildExperienceEvent)
local formatError = require(BuildExperience.utils.formatError)
local FFlagBuildExperienceMonetizationNativeUI = require(BuildExperience.Flags.FFlagBuildExperienceMonetizationNativeUI)
local FFlagBuildExperienceMonetizationMultiKind = require(BuildExperience.Flags.FFlagBuildExperienceMonetizationMultiKind)
local FFlagBuildExperienceDeveloperProductContext = require(BuildExperience.Flags.FFlagBuildExperienceDeveloperProductContext)
local FFlagBuildCheckGamePermissions = require(BuildExperience.Flags.FFlagBuildCheckGamePermissions)

local FFlagBuildExperienceMonetizationProductEditing = require(BuildExperience.Flags.FFlagBuildExperienceMonetizationProductEditing)
local FFlagBuildExperienceMonetizationManageKinds = require(BuildExperience.Flags.FFlagBuildExperienceMonetizationManageKinds)

local FFlagBuildExperienceMonetizationKindRegionalPricing = require(BuildExperience.Flags.FFlagBuildExperienceMonetizationKindRegionalPricing)
local var1 = require(BuildExperience.Flags.FFlagBuildExperienceMonetizationPageFixes) and FFlagBuildExperienceDeveloperProductContext

local FFlagBuildExperienceRemoveDevProductPriceCap = require(BuildExperienceParent.SharedFlags).FFlagBuildExperienceRemoveDevProductPriceCap

local _MonetizationPageView = require(script.Parent.MonetizationPageView)
local getProductKindCapabilities = require(script.Parent.getProductKindCapabilities)

local tbl1 = {}
local string2 = if FFlagBuildExperienceDeveloperProductContext then UrlBuilder.fromString("apis:developer-products/v2/universes/{universeId}/developer-products/{productId}/creator") else nil
local string3 = if var1 then UrlBuilder.fromString("apis:game-passes/v1/universes/{universeId}/game-passes/{productId}/creator") else nil
local string4 = if var1 then UrlBuilder.fromString("apis:experience-subscriptions/v1/experiences/{universeId}/experience-subscriptions/{productId}") else nil
local FFlagBuildExperienceDevProductModerationReadback = require(BuildExperience.Flags.FFlagBuildExperienceDevProductModerationReadback)
local wasDeveloperProductTextModerated = require(BuildExperience.utils.wasDeveloperProductTextModerated)

local function logProductMutationFailure(str1: string, arg1, arg2) -- Luacid: unused: defined but never referenced
    if not FFlagBuildExperienceMonetizationNativeUI then
        return
    end
    local var2 = string.gsub(formatError(arg2), "[\r\n]+", " ")
    local productKind = arg1.productKind or "DeveloperProduct"
    warn(`[{productKind}] action={str1} productId={arg1.id} failed={string.sub(var2, 1, 200)}`)
end

local function formatLogError(arg1): string -- Luacid: unused: defined but never referenced
    return string.sub(string.gsub(formatError(arg1), "[\r\n]+", " "), 1, 200)
end

local function sendMonetizationEvent(str1: string, arg1, tbl2) -- Luacid: Inlined by compiler; 23 call sites recovered
    if tbl2 == nil then
        sendBuildExperienceEvent(str1, arg1)
        return
    end
    sendBuildExperienceEvent(str1, arg1, tbl2)
end

local function noop(_) end

local tbl2 = {
    selectedProductIdRef = { current = nil },
    isProductSaleStatusPending = false,
    setIsProductSaleStatusPending = noop,
    productSaleStatusError = false,
    setProductSaleStatusError = noop,
    isProductEditPending = false,
    setIsProductEditPending = noop,
    productEditError = nil,
    setProductEditError = noop,
    editName = "",
    setEditName = noop,
    editDescription = "",
    setEditDescription = noop,
    editPrice = "",
    setEditPrice = noop
}

local tbl3 = {
    loadStatus = "NotReady",
    canMonetize = false,
    canChangeManagedPricing = false,
    managedPricingState = "Unavailable",
    managedPricingSupportingText = nil,
    shopButtonEnabled = false,
    isManagedPricingPending = false,
    isShopButtonPending = false,
    managedPricingError = nil,
    shopButtonError = nil,
    showAcknowledgement = false,
    onManagedPricingChanged = noop,
    onShopButtonChanged = noop,
    onConfirmManagedPricing = function() end,
    onCancelManagedPricing = function() end,
    onRetry = function() end,
    labels = {
        options = LocalizationStrings.MONETIZATION_OPTIONS,
        pricingOptions = LocalizationStrings.MONETIZATION_PRICING_OPTIONS,
        pricingOptionsDescription = LocalizationStrings.MONETIZATION_PRICING_OPTIONS_DESCRIPTION,
        managedPricing = LocalizationStrings.MONETIZATION_MANAGED_PRICING,
        managedPricingDescription = LocalizationStrings.MONETIZATION_MANAGED_PRICING_DESCRIPTION,
        shopUI = LocalizationStrings.MONETIZATION_SHOP_UI,
        shopButton = LocalizationStrings.MONETIZATION_SHOP_BUTTON,
        shopButtonDescription = LocalizationStrings.MONETIZATION_SHOP_BUTTON_DESCRIPTION,
        optionsLoadError = LocalizationStrings.MONETIZATION_OPTIONS_LOAD_ERROR,
        permissionDenied = LocalizationStrings.MONETIZATION_PERMISSION_DENIED,
        mixed = LocalizationStrings.MONETIZATION_MANAGED_PRICING_MIXED,
        unavailable = LocalizationStrings.MONETIZATION_MANAGED_PRICING_UNAVAILABLE,
        noEligibleProducts = LocalizationStrings.MONETIZATION_NO_ELIGIBLE_PRODUCTS,
        optionsUpdateError = LocalizationStrings.MONETIZATION_OPTIONS_UPDATE_ERROR,
        partialUpdateError = LocalizationStrings.MONETIZATION_MANAGED_PRICING_PARTIAL_ERROR,
        acknowledgementTitle = LocalizationStrings.MONETIZATION_MANAGED_PRICING_ACK_TITLE,
        acknowledgementDescription = LocalizationStrings.MONETIZATION_MANAGED_PRICING_ACK_DESCRIPTION,
        agree = LocalizationStrings.MONETIZATION_AGREE
    }
}

local function trim(str1: string) -- Luacid: Inlined by compiler; 3 call sites recovered
    return string.match(str1, "^%s*(.-)%s*$") or ""
end

local function textLength(str1: string): number -- Luacid: Inlined by compiler; 2 call sites recovered
    return utf8.len(str1) or #str1
end

local function productIdentity(arg1) -- Luacid: Inlined by compiler; 19 call sites recovered
    return arg1.identity or arg1.id
end

local function canManageProduct(arg1): boolean -- Luacid: Inlined by compiler; 11 call sites recovered
    return not (arg1 == nil or arg1.productKind ~= nil and arg1.productKind ~= "DeveloperProduct") and arg1.canManage ~= false
end

local function canDescribeKindProduct(arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
    local bool1 = var1
    return bool1 and arg1 ~= nil and (arg1.productKind == "GamePass" or arg1.productKind == "Subscription")
end

local function hasProductComposer(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return canManageProduct(arg1) or canDescribeKindProduct(arg1)
end

local function productResourceUrl(universeId: number, arg1)
    local tbl4 = {
        universeId = universeId,
        productId = arg1.id
    }

    if canDescribeKindProduct(arg1) then
        if arg1.productKind == "GamePass" then
            return (string3(tbl4))
        end

        return (string4(tbl4))
    end
    return string2(tbl4)
end

local function getKindSaleCapabilities(arg1) -- Luacid: Inlined by compiler; 26 call sites recovered
    if not FFlagBuildExperienceMonetizationManageKinds then
        return nil
    end
    return getProductKindCapabilities(if arg1 == nil then nil else arg1.productKind)
end

local function getKindRegionalPricingCapabilities(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    local kindSaleCapabilities = getKindSaleCapabilities(arg1)
    return if FFlagBuildExperienceMonetizationKindRegionalPricing
        and kindSaleCapabilities ~= nil
        and kindSaleCapabilities.regionalPricing then kindSaleCapabilities else nil
end

local function canEditKindProduct(arg1) -- Luacid: Inlined by compiler; 10 call sites recovered
    return FFlagBuildExperienceMonetizationProductEditing and getKindSaleCapabilities(arg1) ~= nil
end

local function canEditProduct(arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
    return canManageProduct(arg1) or canEditKindProduct(arg1)
end

local function canOpenProductEdit(tbl4, arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    local var2 = canEditProduct(arg1)
    return var2 and (tbl4.onUpdateProductKind ~= nil or not canEditKindProduct(arg1))
end

local function canEditProductName(arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
    local kindSaleCapabilities = getKindSaleCapabilities(arg1)
    return kindSaleCapabilities == nil or kindSaleCapabilities.editableName
end

local function getEditedProductName(arg1, editName: string) -- Luacid: Inlined by compiler; 1 call site recovered
    if canEditProductName(arg1) then
        return (trim(editName))
    end

    return nil
end

local function canEditProductPrice(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    local kindSaleCapabilities = getKindSaleCapabilities(arg1)
    return kindSaleCapabilities == nil or kindSaleCapabilities.editablePrice
end

local function getEditTelemetryParameters(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    local tbl4 = {
        productId = arg1.id
    }

    if canEditKindProduct(arg1) and arg1.productKind ~= nil then
        tbl4.productKind = arg1.productKind
    end
    return tbl4
end

local function findProduct(tbl4, str1: string?) -- Luacid: Inlined by compiler; 3 call sites recovered
    if str1 == nil then
        return nil
    end
    for _, value in tbl4 do
        if productIdentity(value) == str1 then
            return value
        end
    end
    return nil
end

local tbl4 = {
    managedPricing = { "isManagedPricingEnabled" },
    saleStatus = { "isForSale" },
    details = {
        "name",
        "description",
        "priceInRobux",
        "price"
    }
}
local function withOverride(arg1, str1: string) -- Luacid: Inlined by compiler; 3 call sites recovered
    return function(arg2)
        local var2 = productIdentity(arg1)
        local var3 = table.clone(arg2[var2] or {})
        var3[str1] = arg1
        local var4 = table.clone(arg2)
        var4[var2] = var3
        return var4
    end
end

local function withoutOverride(str1: string, str2: string) -- Luacid: Inlined by compiler; 6 call sites recovered
    return function(arg1)
        if (arg1[str1] or {})[str2] == nil then
            return arg1
        end
        local var2 = table.clone(arg1[str1])
        var2[str2] = nil
        local var3 = table.clone(arg1)
        var3[str1] = var2
        if next(var2) == nil then
            var3[str1] = nil
        end
        return var3
    end
end

local function applyProductOverrides(arg1, tbl5)
    if tbl5 == nil then
        return arg1
    end
    local var2 = table.clone(arg1)
    for value, value2 in tbl5 do
        for _, value3 in tbl4[value] do
            var2[value3] = value2[value3]
        end
    end
    return var2
end

local function clearReadBackOverrides(tbl5, tbl6, callback: (...any) -> (...any))
    for value, value2 in tbl6 do
        local product = findProduct(tbl5, value)
        local details = value2.details
        if product ~= nil
            and details ~= nil
            and product.name == details.name
            and product.description == details.description
            and product.priceInRobux == details.priceInRobux
        then
            callback((withoutOverride(value, "details")))
        end

        local function clearReadBackToggle(str1: string, str2: string) -- Luacid: unused: defined but never referenced
            local var2 = value2[str1]
            if product == nil or var2 == nil then
                return
            end
            if product[str2] == true == (var2[str2] == true) then
                local func1 = withoutOverride(value, str1)
                callback(func1)
            end
        end

        local managedPricing = value2.managedPricing
        if product ~= nil
            and managedPricing ~= nil
            and product.isManagedPricingEnabled == true == (managedPricing.isManagedPricingEnabled == true)
        then
            callback((withoutOverride(value, "managedPricing")))
        end

        local saleStatus = value2.saleStatus
        if product ~= nil and saleStatus ~= nil and product.isForSale == true == (saleStatus.isForSale == true) then
            callback((withoutOverride(value, "saleStatus")))
        end
    end
end

local function useManageProductState(arg1)
    local selectedProductIdRef = React.useRef(if arg1 == nil then nil else productIdentity(arg1))
    local isProductSaleStatusPending, setIsProductSaleStatusPending = React.useState(false)
    local productSaleStatusError, setProductSaleStatusError = React.useState(false)
    local isProductEditPending, setIsProductEditPending = React.useState(false)
    local productEditError, setProductEditError = React.useState(nil)

    local editName, setEditName = React.useState(if arg1 == nil then "" else arg1.name)

    local editDescription, setEditDescription = React.useState(if arg1 == nil then "" else arg1.description)
    local useState = React.useState
    local var15 = if arg1 == nil or arg1.priceInRobux == nil then "" else tostring(arg1.priceInRobux)
    local editPrice, setEditPrice = useState(var15)

    return {
        selectedProductIdRef = selectedProductIdRef,
        isProductSaleStatusPending = isProductSaleStatusPending,
        setIsProductSaleStatusPending = setIsProductSaleStatusPending,
        productSaleStatusError = productSaleStatusError,
        setProductSaleStatusError = setProductSaleStatusError,
        isProductEditPending = isProductEditPending,
        setIsProductEditPending = setIsProductEditPending,
        productEditError = productEditError,
        setProductEditError = setProductEditError,
        editName = editName,
        setEditName = setEditName,
        editDescription = editDescription,
        setEditDescription = setEditDescription,
        editPrice = editPrice,
        setEditPrice = setEditPrice
    }
end

local function getEligibleProducts(tbl5)
    local eligibleProducts = {}
    for _, value in tbl5 do
        if canManageProduct(value)
            and value.isForSale == true
            and value.isArchived ~= true
            and value.isImmutable ~= true
            and value.isInActivePriceOptimizationExperiment ~= true
            and value.priceInRobux ~= nil
            and value.priceInRobux > 0
        then
            table.insert(eligibleProducts, value)
        end
    end
    return eligibleProducts
end

local function isProductMutationDisabled(arg1): boolean -- Luacid: Inlined by compiler; 4 call sites recovered
    return not (arg1 == nil)
        and (arg1.isArchived == true or arg1.isImmutable == true or arg1.isInActivePriceOptimizationExperiment == true)
end

local function validateProductEdit(arg1, editedProductName: string?, editDescription: string, editPrice: string, tbl5)
    if editedProductName ~= nil then
        if editedProductName == "" then
            return tbl5.nameRequiredError
        end
        if textLength(editedProductName) > 50 then
            return tbl5.nameLengthError
        end
    end
    if textLength(editDescription) > 1000 then
        return tbl5.descriptionLengthError
    elseif not canEditProductPrice(arg1) then
        return nil, nil
    else
        local var2 = tonumber(editPrice)
        local bool1 = arg1.isForSale == true
        if editPrice == "" and bool1
            or editPrice ~= "" and var2 == nil
            or var2 ~= nil and var2 % 1 ~= 0
            or var2 ~= nil and var2 < 1
            or not FFlagBuildExperienceRemoveDevProductPriceCap and var2 ~= nil and var2 > 1000000000
        then
            return tbl5.priceError
        end
        return nil, var2
    end
end

local function resolveProductEditSubmit(tbl5, arg1)
    if canEditKindProduct(arg1) then
        local onUpdateProductKind = tbl5.onUpdateProductKind
        return if onUpdateProductKind == nil then nil else function(arg2)
            return onUpdateProductKind(arg1.productKind, arg1.id, arg2)
        end
    end
    local onUpdateProduct = tbl5.onUpdateProduct
    local var2 = tonumber(arg1.id)
    return if onUpdateProduct == nil or var2 == nil then nil else function(arg2)
        local name = arg2.name
        if name == nil then
            return Promise.reject("A name is required to update a developer product.")
        end
        return onUpdateProduct(var2, { name = name, description = arg2.description, priceInRobux = arg2.priceInRobux })
    end
end

local function applyProductEditResult(arg1, tbl5, name: string?, description: string, num1: number?)
    local var2 = table.clone(arg1)
    if name == nil then
        var2.name = tbl5.name or arg1.name
    else
        var2.name = if FFlagBuildExperienceDevProductModerationReadback then tbl5.name or "" else tbl5.name or name
    end

    var2.description = if FFlagBuildExperienceDevProductModerationReadback then tbl5.description or "" elseif tbl5.description == nil then description else tbl5.description

    local priceInRobux = (if tbl5.priceInformation == nil then nil else tbl5.priceInformation.defaultPriceInRobux) or num1 or arg1.priceInRobux
    var2.priceInRobux = priceInRobux
    var2.price = if priceInRobux ~= nil then tostring(priceInRobux) else arg1.price

    return var2, if FFlagBuildExperienceDevProductModerationReadback then wasDeveloperProductTextModerated(name, tbl5.name) or wasDeveloperProductTextModerated(description, tbl5.description) else name ~= nil and tbl5.name ~= nil and tbl5.name ~= name
        or not (tbl5.description == nil) and tbl5.description ~= description
end

local function getKindEditState(arg1, bool1: boolean, tbl5): {[any]: any} | {canEdit: boolean, canEditName: any, canEditPrice: any}
    return if arg1 == nil or not canEditKindProduct(arg1) or not bool1 or tbl5.onUpdateProductKind == nil then {} else {
        canEdit = true,
        canEditName = canEditProductName(arg1),
        canEditPrice = canEditProductPrice(arg1)
    }
end

local function getManagedPricingState(managedPricingStatus: string?, eligibleProducts): string -- Luacid: Inlined by compiler; 1 call site recovered
    if managedPricingStatus == nil or managedPricingStatus == "Disabled" then
        return "Unavailable"
    end

    local num1 = 0
    for _, eligibleProduct in eligibleProducts do
        if eligibleProduct.isManagedPricingEnabled == true then
            num1 += 1
        end
    end
    return if num1 == 0 then "AllOff" elseif num1 == #eligibleProducts then "AllOn" else "Mixed"
end

local function getShopButtonEnabled(shops)
    local shop = if shops == nil then nil else shops[1]

    for _, value in (shop == nil or shop.entryPoints == nil) and {} or shop.entryPoints do
        if value.name == "InExperienceGlobalIconEnabled" then
            return value.isEnabled == true
        end
    end
    return false
end

local function combineLoadStatus(tbl5) -- Luacid: Inlined by compiler; 1 call site recovered
    for _, value in tbl5 do
        if value == "Failed" then
            return "Failed"
        end
    end
    for _, value in tbl5 do
        if value ~= "Ready" then
            return "NotReady"
        end
    end
    return "Ready"
end

local function getDisplayedManagedPricingState(bool1: boolean?, managedPricingState: string) -- Luacid: Inlined by compiler; 1 call site recovered
    return if bool1 == nil then managedPricingState elseif bool1 then "AllOn" else "AllOff"
end

local function useOptionsState(tbl5, tbl6, bool1: boolean, tbl7, current)
    local labels = useLocalization({
        options = LocalizationStrings.MONETIZATION_OPTIONS,
        pricingOptions = LocalizationStrings.MONETIZATION_PRICING_OPTIONS,
        pricingOptionsDescription = LocalizationStrings.MONETIZATION_PRICING_OPTIONS_DESCRIPTION,
        managedPricing = LocalizationStrings.MONETIZATION_MANAGED_PRICING,
        managedPricingDescription = LocalizationStrings.MONETIZATION_MANAGED_PRICING_DESCRIPTION,
        shopUI = LocalizationStrings.MONETIZATION_SHOP_UI,
        shopButton = LocalizationStrings.MONETIZATION_SHOP_BUTTON,
        shopButtonDescription = LocalizationStrings.MONETIZATION_SHOP_BUTTON_DESCRIPTION,
        optionsLoadError = LocalizationStrings.MONETIZATION_OPTIONS_LOAD_ERROR,
        permissionDenied = LocalizationStrings.MONETIZATION_PERMISSION_DENIED,
        mixed = LocalizationStrings.MONETIZATION_MANAGED_PRICING_MIXED,
        unavailable = LocalizationStrings.MONETIZATION_MANAGED_PRICING_UNAVAILABLE,
        noEligibleProducts = LocalizationStrings.MONETIZATION_NO_ELIGIBLE_PRODUCTS,
        optionsUpdateError = LocalizationStrings.MONETIZATION_OPTIONS_UPDATE_ERROR,
        partialUpdateError = LocalizationStrings.MONETIZATION_MANAGED_PRICING_PARTIAL_ERROR,
        acknowledgementTitle = LocalizationStrings.MONETIZATION_MANAGED_PRICING_ACK_TITLE,
        acknowledgementDescription = LocalizationStrings.MONETIZATION_MANAGED_PRICING_ACK_DESCRIPTION,
        agree = LocalizationStrings.MONETIZATION_AGREE
    })
    local eligibleProducts = getEligibleProducts(tbl6)

    local managedPricingState = getManagedPricingState(tbl5.managedPricingStatus, eligibleProducts)
    local shopButtonEnabled = getShopButtonEnabled(tbl5.shops)
    local loadStatus = combineLoadStatus({ tbl5.managedPricingLoadStatus or "NotReady", tbl5.shopsLoadStatus or "NotReady", tbl5.permissionLoadStatus or "NotReady" })
    local canMonetize = loadStatus == "Ready" and tbl5.permissionCanMonetize == true
    local isManagedPricingPending, var4 = React.useState(false)
    local isShopButtonPending, var6 = React.useState(false)

    local var7, var8 = React.useState(nil)
    local var9, var10 = React.useState(nil)
    local managedPricingError, var12 = React.useState(nil)
    local shopButtonError, var14 = React.useState(nil)
    local showAcknowledgement, var16 = React.useState(false)
    local var17 = React.useRef(nil)
    local var18 = React.useRef(nil)

    React.useLayoutEffect(function()
        var17.current = nil
        var18.current = nil
        var4(false)
        var6(false)
        var8(nil)
        var10(nil)
        var12(nil)
        var14(nil)
        var16(false)
    end, { tbl5.universeId or 0 })

    React.useEffect(function()
        if var7 ~= nil and (var7 and managedPricingState == "AllOn" or not var7 and managedPricingState == "AllOff") then
            var8(nil)
        end
    end, { managedPricingState, var7 })

    React.useEffect(function()
        if var9 ~= nil and var9 == shopButtonEnabled then
            var10(nil)
        end
    end, { var9, shopButtonEnabled })

    local var19 = React.useCallback(function(bool3: boolean, bool4: boolean)
        local onUpdateManagedPricing = tbl5.onUpdateManagedPricing

        if tbl7.current ~= current
            or var17.current ~= nil
            or isManagedPricingPending
            or not canMonetize
            or onUpdateManagedPricing == nil
            or tbl5.managedPricingStatus == nil
            or tbl5.managedPricingStatus == "Disabled"
            or #eligibleProducts == 0
        then
            return
        end
        local tbl8 = {}
        for _, eligibleProduct in eligibleProducts do
            local var19 = tonumber(eligibleProduct.id)
            if var19 ~= nil then
                table.insert(tbl8, var19)
            end
        end
        if #tbl8 == 0 then
            var16(false)
            return
        end
        local tbl9 = {}
        var17.current = tbl9

        var12(nil)
        var8(bool3)
        var4(true)

        local var19 = if bool4 and tbl5.onAcceptManagedPricing ~= nil then tbl5.onAcceptManagedPricing():andThen(function()
            if tbl7.current ~= current or var17.current ~= tbl9 then
                return nil
            end
            return onUpdateManagedPricing(tbl8, bool3)
        end) else onUpdateManagedPricing(tbl8, bool3)

        var19:andThen(function(arg1)
            if tbl7.current ~= current or var17.current ~= tbl9 then
                return
            end
            var16(false)
            if type(arg1) ~= "table" or type(arg1.errors) ~= "table" or not (#arg1.errors > 0) then
                sendMonetizationEvent("MONETIZATION_OPTIONS_UPDATE_SUCCESS", bool1, { action = "managed_pricing" })
                return
            end

            local warn = warn

            local universeId = bool1.universeId
            warn(`[MonetizationOptions] Managed Pricing update partially failed (universeId={tostring(universeId)})`)

            sendMonetizationEvent(
                "MONETIZATION_OPTIONS_UPDATE_FAILURE",
                bool1,
                { action = "managed_pricing", failureType = "partial" }
            )

            var8(nil)
            var12(labels.partialUpdateError)
        end):catch(function(arg1)
            if tbl7.current ~= current or var17.current ~= tbl9 then
                return
            end
            local warn = warn
            local str2 = tostring(bool1.universeId)
            local var20 = string.gsub(formatError(arg1), "[\r\n]+", " ")
            warn(
                `[MonetizationOptions] Managed Pricing update failed (universeId={str2}): {string.sub(var20, 1, 200)}`
            )

            sendMonetizationEvent(
                "MONETIZATION_OPTIONS_UPDATE_FAILURE",
                bool1,
                { action = "managed_pricing", failureType = "request" }
            )

            var16(false)
            var8(nil)
            var12(labels.optionsUpdateError)
        end):finally(function()
            if tbl7.current == current and var17.current == tbl9 then
                var17.current = nil
                var4(false)
            end
        end)
    end, {
        canMonetize,
        eligibleProducts,
        isManagedPricingPending,
        labels.optionsUpdateError,
        labels.partialUpdateError,
        tbl5.managedPricingStatus,
        tbl5.onAcceptManagedPricing,
        tbl5.onUpdateManagedPricing,
        bool1,
        current
    })

    local onManagedPricingChanged = React.useCallback(function(bool3: boolean)
        if tbl7.current ~= current
            or not canMonetize
            or tbl5.onUpdateManagedPricing == nil
            or tbl5.managedPricingStatus == nil
            or tbl5.managedPricingStatus == "Disabled"
            or #eligibleProducts == 0
        then
            return
        end

        if tbl5.managedPricingStatus == "Pending" and bool3 then
            var16(true)
        else
            var19(bool3, false)
        end
    end, {
        canMonetize,
        eligibleProducts,
        tbl5.managedPricingStatus,
        tbl5.onUpdateManagedPricing,
        var19
    })

    local onShopButtonChanged = React.useCallback(function(bool3: boolean)
        local onSetShopButton = tbl5.onSetShopButton

        if tbl7.current ~= current or var18.current ~= nil or isShopButtonPending or not canMonetize or onSetShopButton == nil then
            return
        end
        local tbl8 = {}
        var18.current = tbl8
        var14(nil)
        var10(bool3)
        var6(true)
        onSetShopButton(bool3):andThen(function()
            if tbl7.current ~= current or var18.current ~= tbl8 then
                return
            end
            sendMonetizationEvent("MONETIZATION_OPTIONS_UPDATE_SUCCESS", bool1, { action = "shop_button" })
        end):catch(function(arg1)
            if tbl7.current ~= current or var18.current ~= tbl8 then
                return
            end
            local warn = warn
            local str2 = tostring(bool1.universeId)
            local var21 = string.gsub(formatError(arg1), "[\r\n]+", " ")
            warn(`[MonetizationOptions] Shop button update failed (universeId={str2}): {string.sub(var21, 1, 200)}`)

            sendMonetizationEvent("MONETIZATION_OPTIONS_UPDATE_FAILURE", bool1, { action = "shop_button", failureType = "request" })

            var10(nil)
            var14(labels.optionsUpdateError)
        end):finally(function()
            if tbl7.current == current and var18.current == tbl8 then
                var18.current = nil
                var6(false)
            end
        end)
    end, {
        canMonetize,
        isShopButtonPending,
        labels.optionsUpdateError,
        tbl5.onSetShopButton,
        bool1,
        current
    })

    local displayedManagedPricingState = getDisplayedManagedPricingState(var7, managedPricingState)
    local module = {
        loadStatus = loadStatus,
        canMonetize = canMonetize,
        canChangeManagedPricing = canMonetize
            and not (tbl5.onUpdateManagedPricing == nil or not (#eligibleProducts > 0))
            and displayedManagedPricingState ~= "Unavailable",
        managedPricingState = displayedManagedPricingState,
        managedPricingSupportingText = if #eligibleProducts == 0 and displayedManagedPricingState ~= "Unavailable" then labels.noEligibleProducts else nil,
        shopButtonEnabled = if var9 == nil then shopButtonEnabled else var9,
        isManagedPricingPending = isManagedPricingPending,
        isShopButtonPending = isShopButtonPending,
        managedPricingError = managedPricingError,
        shopButtonError = shopButtonError,
        showAcknowledgement = showAcknowledgement,
        onManagedPricingChanged = onManagedPricingChanged,
        onShopButtonChanged = onShopButtonChanged,
        onConfirmManagedPricing = 0,
        onCancelManagedPricing = 0,
        onRetry = 0,
        labels = 0
    }

    function module.onConfirmManagedPricing()
        var19(true, true)
    end
    function module.onCancelManagedPricing()
        if not isManagedPricingPending then
            var16(false)
        end
    end
    module.onRetry = tbl5.onRetryOptions or function() end
    module.labels = labels
    return module
end

local function getRegionalPricingViewState(tbl5, arg1, bool1: boolean, bool2: boolean, arg2)
    local kindRegionalPricingCapabilities = getKindRegionalPricingCapabilities(arg1)
    local priceInRobux = if arg1 == nil then nil else arg1.priceInRobux
    local tbl6 = {
        canUpdate = if kindRegionalPricingCapabilities ~= nil then tbl5.onUpdateProductKindManagedPricing ~= nil else tbl5.onUpdateProductManagedPricing ~= nil,
        canChangeKind = 0,
        errorLabel = 0
    }

    if FFlagBuildExperienceMonetizationKindRegionalPricing then
        if bool1 then
            if kindRegionalPricingCapabilities == nil then
                bool1 = false
            else
                bool1 = tbl5.onUpdateProductKindManagedPricing ~= nil
            end
        end
    else
        bool1 = nil
    end

    tbl6.canChangeKind = bool1

    tbl6.errorLabel = if kindRegionalPricingCapabilities == nil or not bool2 then nil elseif priceInRobux == nil then arg2.kindPriceRequiredForRegionalPricing else arg2.updateError
    return tbl6
end

local function getInitialSelection(tbl5, tbl6) -- Luacid: unused: defined but never referenced
    local initialMode = if FFlagBuildExperienceMonetizationNativeUI or tbl5.initialMode ~= "options" then tbl5.initialMode else nil

    if initialMode == "detail" or FFlagBuildExperienceMonetizationProductEditing and initialMode == "edit" then
        return initialMode, tbl6[1]
    end

    return initialMode, nil
end

local function useMonetizationLocalization()
    return useLocalization({
        composerPlaceholder = if FFlagBuildExperienceDeveloperProductContext then LocalizationStrings.CHAT_COMPOSER_PLACEHOLDER else nil,
        title = LocalizationStrings.MONETIZATION_TITLE,
        emptyTitle = LocalizationStrings.MONETIZATION_EMPTY_TITLE,
        emptyDescription = LocalizationStrings.MONETIZATION_EMPTY_DESCRIPTION,
        emptyCreateProduct = LocalizationStrings.MONETIZATION_EMPTY_CREATE_PRODUCT,
        createProductPrompt = LocalizationStrings.MONETIZATION_CREATE_PRODUCT_PROMPT,
        pricing = LocalizationStrings.MONETIZATION_PRICING,
        regionalPricing = LocalizationStrings.MONETIZATION_REGIONAL_PRICING,
        loading = LocalizationStrings.MONETIZATION_LOADING,
        loadErrorTitle = LocalizationStrings.BUILD_ELIGIBILITY_ERROR_TITLE,
        loadErrorDescription = LocalizationStrings.CHAT_ERROR_UPSTREAM_UNAVAILABLE,
        updateError = LocalizationStrings.CHAT_DEFAULT_FAILURE,
        retry = LocalizationStrings.MONETIZATION_RETRY,
        availableForPurchase = LocalizationStrings.MONETIZATION_AVAILABLE_FOR_PURCHASE,
        edit = LocalizationStrings.MONETIZATION_EDIT,
        editProduct = LocalizationStrings.MONETIZATION_EDIT_PRODUCT,
        name = LocalizationStrings.MONETIZATION_NAME,
        description = LocalizationStrings.MONETIZATION_DESCRIPTION,
        price = LocalizationStrings.MONETIZATION_PRICE,
        cancel = LocalizationStrings.MONETIZATION_CANCEL,
        save = LocalizationStrings.MONETIZATION_SAVE,
        nameRequiredError = LocalizationStrings.MONETIZATION_NAME_REQUIRED_ERROR,
        nameLengthError = LocalizationStrings.MONETIZATION_NAME_LENGTH_ERROR,
        descriptionLengthError = LocalizationStrings.MONETIZATION_DESCRIPTION_LENGTH_ERROR,
        priceError = LocalizationStrings.MONETIZATION_PRICE_ERROR,
        priceRequiredForSale = LocalizationStrings.MONETIZATION_PRICE_REQUIRED_FOR_SALE,
        moderationError = LocalizationStrings.MONETIZATION_MODERATION_ERROR,
        kindPriceRequiredForSale = if FFlagBuildExperienceMonetizationManageKinds then LocalizationStrings.MONETIZATION_PRICE_REQUIRED_FOR_KIND_SALE else nil,
        kindPriceRequiredForRegionalPricing = if FFlagBuildExperienceMonetizationKindRegionalPricing then LocalizationStrings.MONETIZATION_PRICE_REQUIRED_FOR_REGIONAL_PRICING else nil
    })
end

local function useMonetizationPageViewModel(tbl5)
    local var2 = useMonetizationLocalization()
    local products = tbl5.products or tbl1
    local initialMode = if FFlagBuildExperienceMonetizationNativeUI or tbl5.initialMode ~= "options" then tbl5.initialMode else nil
    local var4 = if initialMode == "detail" or FFlagBuildExperienceMonetizationProductEditing and initialMode == "edit" then products[1] else nil

    local var5 = React.useMemo(function()
        return {
            universeId = tbl5.universeId,
            placeId = tbl5.placeId,
            conversationId = tbl5.sessionId,
            messageId = nil,
            turnId = nil,
            chatOpenId = nil
        }
    end, { tbl5.placeId or 0, tbl5.sessionId or "", tbl5.universeId or 0 })
    local current = React.useMemo(function()
        return {}
    end, { tbl5.universeId or 0 })
    local var7 = React.useRef(nil)
    React.useLayoutEffect(function()
        var7.current = current
        return function()
            if var7.current == current then
                var7.current = nil
            end
        end
    end, { current })
    local tbl6 = tbl3
    if FFlagBuildExperienceMonetizationNativeUI then
        tbl6 = useOptionsState(tbl5, products, var5, var7, current)
    end
    local bool1 = not FFlagBuildExperienceMonetizationMultiKind

    if not bool1 then
        if tbl5.permissionLoadStatus == "Ready" then
            bool1 = tbl5.permissionCanMonetize == true
        else
            bool1 = false
        end
    end

    local str1 = if #products > 0 then "catalog" else "empty"
    local mode, var9 = React.useState(initialMode or str1)

    local var10, var11 = React.useState(var4)
    local var12 = nil
    local func1 = noop
    local tbl7 = {}
    local func2 = noop
    if FFlagBuildExperienceMonetizationMultiKind then
        local useState = React.useState
        local var13 = if var4 == nil then nil else productIdentity(var4)
        var12, func1 = useState(var13)

        tbl7, func2 = React.useState({})
    end

    local product = if FFlagBuildExperienceMonetizationMultiKind then findProduct(products, var12) else nil

    if FFlagBuildExperienceMonetizationMultiKind then
        if product == nil then
            var10 = nil
        else
            var10 = applyProductOverrides(product, if var12 == nil then nil else tbl7[var12])
        end
    end

    local isProductManagedPricingPending, var14 = React.useState(false)
    local productManagedPricingError, var16 = React.useState(false)
    local var17 = React.useRef(nil)
    local tbl8 = tbl2
    if FFlagBuildExperienceMonetizationProductEditing then
        tbl8 = useManageProductState(var4)
    end
    local selectedProductIdRef = tbl8.selectedProductIdRef
    local isProductSaleStatusPending = tbl8.isProductSaleStatusPending
    local setIsProductSaleStatusPending = tbl8.setIsProductSaleStatusPending
    local productSaleStatusError = tbl8.productSaleStatusError
    local setProductSaleStatusError = tbl8.setProductSaleStatusError
    local isProductEditPending = tbl8.isProductEditPending
    local setIsProductEditPending = tbl8.setIsProductEditPending
    local productEditError = tbl8.productEditError
    local setProductEditError = tbl8.setProductEditError
    local editName = tbl8.editName
    local setEditName = tbl8.setEditName
    local editDescription = tbl8.editDescription
    local setEditDescription = tbl8.setEditDescription
    local editPrice = tbl8.editPrice
    local setEditPrice = tbl8.setEditPrice

    React.useLayoutEffect(function()
        var17.current = nil
        var9(initialMode or str1)
        if FFlagBuildExperienceMonetizationMultiKind then
            func1(if var4 == nil then nil else productIdentity(var4))
            func2({})
        else
            var11(var4)
        end
        var14(false)
        var16(false)
        if not FFlagBuildExperienceMonetizationProductEditing then
            return
        end

        local var18 = selectedProductIdRef
        var18.current = if var4 == nil then nil else productIdentity(var4)

        setIsProductSaleStatusPending(false)
        setProductSaleStatusError(false)
        setIsProductEditPending(false)
        setProductEditError(nil)
        setEditName(if var4 == nil then "" else var4.name)
        setEditDescription(if var4 == nil then "" else var4.description)
        local var19 = setEditPrice
        local var20 = if var4 == nil or var4.priceInRobux == nil then "" else tostring(var4.priceInRobux)
        var19(var20)
    end, { tbl5.universeId or 0 })
    React.useEffect(function()
        sendMonetizationEvent("MONETIZATION_ENTRY_CLICK", var5, { source = "monetization_page" })
        sendMonetizationEvent("MONETIZATION_PAGE_IMPRESSION", var5, nil)
    end, { var5 })

    React.useEffect(function()
        if initialMode == nil and (mode == "catalog" or mode == "empty") and mode ~= str1 then
            var9(str1)
        end
    end, { str1, initialMode, mode })

    if FFlagBuildExperienceMonetizationMultiKind then
        React.useEffect(function()
            if var12 ~= nil and findProduct(products, var12) == nil then
                selectedProductIdRef.current = nil
                func1(nil)
                var9(str1)
            end
            clearReadBackOverrides(products, tbl7, func2)
        end, {
            str1,
            tbl7,
            products,
            var12
        })
    end
    local useCallback = React.useCallback
    local function func3()
        sendMonetizationEvent("MONETIZATION_CLOSE_CLICK", var5, { mode = tostring(mode) })
        if FFlagBuildExperienceMonetizationProductEditing and mode == "edit" then
            if isProductEditPending or var17.current ~= nil then
                return
            end
            setProductEditError(nil)
            var9("detail")
            return
        end

        if mode ~= "detail" then
            if FFlagBuildExperienceMonetizationNativeUI and mode == "options" and initialMode ~= "options" then
                var9(str1)
            else
                tbl5.onClose()
            end

            return
        end

        if FFlagBuildExperienceMonetizationProductEditing then
            selectedProductIdRef.current = nil
        end
        if FFlagBuildExperienceMonetizationMultiKind then
            func1(nil)
        else
            var11(nil)
        end
        var9(str1)
    end

    local var18 = if FFlagBuildExperienceMonetizationProductEditing then isProductEditPending else nil
    local onClose = useCallback(func3, { str1, var18, mode, initialMode, tbl5.onClose, var5, setProductEditError })

    local onProductActivated = React.useCallback(function(str2: string)
        for _, value in products do
            if productIdentity(value) ~= str2 then
                continue
            end

            local tbl9 = {
                productId = value.id
            }

            if FFlagBuildExperienceMonetizationMultiKind then
                tbl9.productKind = value.productKind
            end
            sendMonetizationEvent("MONETIZATION_PRODUCT_CLICK", var5, tbl9)
            if FFlagBuildExperienceMonetizationProductEditing then
                var16(false)
                setProductSaleStatusError(false)
                setProductEditError(nil)
            end
            if FFlagBuildExperienceMonetizationProductEditing then
                selectedProductIdRef.current = productIdentity(value)
            end
            if FFlagBuildExperienceMonetizationMultiKind then
                func1(str2)
            else
                var11(value)
            end
            var9("detail")
            return
        end
    end, {
        products,
        setProductEditError,
        setProductSaleStatusError,
        var5
    })

    local onOpenOptions = not FFlagBuildExperienceMonetizationNativeUI and function() end or React.useCallback(function()
        var9("options")
    end, {})

    local useCallback2 = React.useCallback
    local function func4(isManagedPricingEnabled: boolean)
        local var22 = var10
        local var23 = if var22 == nil then nil else tonumber(var22.id)
        local onUpdateProductManagedPricing = tbl5.onUpdateProductManagedPricing
        local kindRegionalPricingCapabilities = getKindRegionalPricingCapabilities(var22)
        local onUpdateProductKindManagedPricing = tbl5.onUpdateProductKindManagedPricing

        if var7.current ~= current
            or var17.current ~= nil
            or var22 == nil
            or not canManageProduct(var22) and kindRegionalPricingCapabilities == nil
            or not bool1
        then
            return
        end

        local bool2 = if kindRegionalPricingCapabilities == nil then var23 == nil or onUpdateProductManagedPricing == nil else onUpdateProductKindManagedPricing == nil

        if bool2
            or isProductManagedPricingPending
            or FFlagBuildExperienceMonetizationProductEditing and isProductSaleStatusPending
            or isProductMutationDisabled(var22)
        then
            return
        end

        if FFlagBuildExperienceMonetizationNativeUI and isManagedPricingEnabled and var22.priceInRobux == nil then
            var16(true)
            return
        end
        local tbl9 = {}
        var17.current = tbl9
        local productKind = if kindRegionalPricingCapabilities == nil then nil else var22.productKind
        sendMonetizationEvent(
            "MONETIZATION_MANAGED_PRICING_CLICK",
            var5,
            {
                isEnabled = tostring(isManagedPricingEnabled),
                productId = var22.id,
                productKind = productKind
            }
        )
        local var24 = table.clone(var22)
        var24.isManagedPricingEnabled = isManagedPricingEnabled
        if FFlagBuildExperienceMonetizationMultiKind then
            local func5 = withOverride(var24, "managedPricing")

            func2(func5)
        else
            var11(var24)
        end
        var16(false)
        var14(true)
        local var25 = if kindRegionalPricingCapabilities ~= nil then onUpdateProductKindManagedPricing(var22.productKind, var22.id, isManagedPricingEnabled) else onUpdateProductManagedPricing(var23, isManagedPricingEnabled)

        var25:andThen(function()
            if var7.current ~= current or var17.current ~= tbl9 then
                return
            end
            sendMonetizationEvent(
                "MONETIZATION_PRODUCT_UPDATE_SUCCESS",
                var5,
                {
                    action = "managed_pricing",
                    productId = var22.id,
                    productKind = productKind
                }
            )
        end):catch(function(arg1)
            if var7.current ~= current or var17.current ~= tbl9 then
                return
            end
            local var26 = var22

            if FFlagBuildExperienceMonetizationNativeUI then
                local var27 = string.gsub(formatError(arg1), "[\r\n]+", " ")
                local productKind2 = var26.productKind or "DeveloperProduct"
                warn(`[{productKind2}] action=managed_pricing productId={var26.id} failed={string.sub(var27, 1, 200)}`)
            end

            if FFlagBuildExperienceMonetizationMultiKind then
                func2((withoutOverride(productIdentity(var22), "managedPricing")))
            end
            sendMonetizationEvent(
                "MONETIZATION_PRODUCT_UPDATE_FAILURE",
                var5,
                {
                    action = "managed_pricing",
                    productId = var22.id,
                    productKind = productKind
                }
            )

            if FFlagBuildExperienceMonetizationProductEditing and selectedProductIdRef.current ~= productIdentity(var22) then
                return
            end
            if not FFlagBuildExperienceMonetizationMultiKind then
                var11(var22)
            end
            var16(true)
        end):finally(function()
            if var7.current == current and var17.current == tbl9 then
                var17.current = nil
                var14(false)
            end
        end)
    end

    local var22 = if FFlagBuildExperienceMonetizationProductEditing then isProductSaleStatusPending else nil
    local onProductManagedPricingChanged = useCallback2(func4, {
        bool1,
        isProductManagedPricingPending,
        var22,
        tbl5.onUpdateProductManagedPricing,
        var10,
        var5,
        current,
        tbl5.onUpdateProductKindManagedPricing or false
    })

    local onProductSaleStatusChanged = React.useCallback(function(isForSale: boolean)
        local var24 = var10
        local var25 = if var24 == nil then nil else tonumber(var24.id)
        local onUpdateProductSaleStatus = tbl5.onUpdateProductSaleStatus
        local kindSaleCapabilities = getKindSaleCapabilities(var24)
        local onUpdateProductKindSaleStatus = tbl5.onUpdateProductKindSaleStatus

        if not FFlagBuildExperienceMonetizationProductEditing
            or var7.current ~= current
            or var17.current ~= nil
            or var24 == nil
            or not canManageProduct(var24) and kindSaleCapabilities == nil
            or not bool1
        then
            return
        end

        local bool2 = if kindSaleCapabilities == nil then var25 == nil or onUpdateProductSaleStatus == nil else onUpdateProductKindSaleStatus == nil

        if bool2 or isProductSaleStatusPending or isProductManagedPricingPending or isProductMutationDisabled(var24) then
            return
        end

        if FFlagBuildExperienceMonetizationNativeUI
            and isForSale
            and var24.priceInRobux == nil
            and (kindSaleCapabilities == nil or kindSaleCapabilities.priceRequiredForSale)
        then
            setProductSaleStatusError(true)
            return
        end
        local tbl9 = {}
        var17.current = tbl9
        local productKind = if kindSaleCapabilities == nil then nil else var24.productKind
        sendMonetizationEvent(
            "MONETIZATION_SALE_STATUS_CLICK",
            var5,
            {
                isEnabled = tostring(isForSale),
                productId = var24.id,
                productKind = productKind
            }
        )
        local var26 = table.clone(var24)
        var26.isForSale = isForSale
        if FFlagBuildExperienceMonetizationMultiKind then
            local func5 = withOverride(var26, "saleStatus")

            func2(func5)
        else
            var11(var26)
        end
        setProductSaleStatusError(false)
        setIsProductSaleStatusPending(true)
        local var27 = if kindSaleCapabilities ~= nil then onUpdateProductKindSaleStatus(var24.productKind, var24.id, isForSale) else onUpdateProductSaleStatus(var25, isForSale)

        var27:andThen(function()
            if var7.current ~= current or var17.current ~= tbl9 then
                return
            end
            sendMonetizationEvent(
                "MONETIZATION_PRODUCT_UPDATE_SUCCESS",
                var5,
                {
                    action = "sale_status",
                    productId = var24.id,
                    productKind = productKind
                }
            )
        end):catch(function(arg1)
            if var7.current ~= current or var17.current ~= tbl9 then
                return
            end
            local var28 = var24

            if FFlagBuildExperienceMonetizationNativeUI then
                local var29 = string.gsub(formatError(arg1), "[\r\n]+", " ")
                local productKind2 = var28.productKind or "DeveloperProduct"
                warn(`[{productKind2}] action=sale_status productId={var28.id} failed={string.sub(var29, 1, 200)}`)
            end

            if FFlagBuildExperienceMonetizationMultiKind then
                func2((withoutOverride(productIdentity(var24), "saleStatus")))
            end
            sendMonetizationEvent(
                "MONETIZATION_PRODUCT_UPDATE_FAILURE",
                var5,
                {
                    action = "sale_status",
                    productId = var24.id,
                    productKind = productKind
                }
            )

            if selectedProductIdRef.current ~= productIdentity(var24) then
                return
            end

            if not FFlagBuildExperienceMonetizationMultiKind then
                var11(var24)
            end
            setProductSaleStatusError(true)
        end):finally(function()
            if var7.current == current and var17.current == tbl9 then
                var17.current = nil
                setIsProductSaleStatusPending(false)
            end
        end)
    end, {
        bool1,
        isProductManagedPricingPending,
        isProductSaleStatusPending,
        tbl5.onUpdateProductSaleStatus,
        var10,
        setIsProductSaleStatusPending,
        setProductSaleStatusError,
        var5,
        current,
        tbl5.onUpdateProductKindSaleStatus or false
    })

    local onUpdateProductKind = tbl5.onUpdateProductKind or false
    local onOpenProductEdit = React.useCallback(function()
        local var25 = var10

        if not FFlagBuildExperienceMonetizationProductEditing
            or var25 == nil
            or not canOpenProductEdit(tbl5, var25)
            or not bool1
            or isProductMutationDisabled(var25)
        then
            return
        end
        sendMonetizationEvent("MONETIZATION_EDIT_CLICK", var5, (getEditTelemetryParameters(var25)))
        setEditName(var25.name)
        setEditDescription(var25.description)
        local var26 = setEditPrice
        local var27 = if var25.priceInRobux == nil then "" else tostring(var25.priceInRobux)
        var26(var27)
        setProductEditError(nil)
        var9("edit")
    end, {
        bool1,
        onUpdateProductKind,
        var10,
        setEditDescription,
        setEditName,
        setEditPrice,
        setProductEditError,
        var5
    })

    local onEditNameChanged = React.useCallback(function(str2: string)
        setEditName(str2)
        setProductEditError(nil)
    end, {})
    local onEditDescriptionChanged = React.useCallback(function(str2: string)
        setEditDescription(str2)
        setProductEditError(nil)
    end, {})
    local onEditPriceChanged = React.useCallback(function(str2: string)
        setEditPrice(str2)
        setProductEditError(nil)
    end, {})
    local onCancelProductEdit = React.useCallback(function()
        if isProductEditPending or var17.current ~= nil then
            return
        end
        local var29 = var10

        sendMonetizationEvent("MONETIZATION_EDIT_CANCEL_CLICK", var5, var29 ~= nil and { productId = var29.id } or nil)

        setProductEditError(nil)
        var9("detail")
    end, { isProductEditPending, var10, var5 })

    local onSaveProductEdit = React.useCallback(function()
        local var30 = var10
        local var31 = if var30 == nil then nil else resolveProductEditSubmit(tbl5, var30)

        if not FFlagBuildExperienceMonetizationProductEditing
            or var7.current ~= current
            or var17.current ~= nil
            or var30 == nil
            or not canEditProduct(var30)
            or not bool1
            or var31 == nil
            or isProductEditPending
        then
            return
        end

        local editTelemetryParameters = getEditTelemetryParameters(var30)
        sendMonetizationEvent("MONETIZATION_EDIT_SAVE_CLICK", var5, editTelemetryParameters)

        local name = getEditedProductName(var30, editName)

        local var32, priceInRobux = validateProductEdit(var30, name, editDescription, editPrice, var2)
        if var32 ~= nil then
            setProductEditError(var32)
            return
        end
        local tbl9 = {}
        var17.current = tbl9

        setProductEditError(nil)
        setIsProductEditPending(true)
        var31({ name = name, description = editDescription, priceInRobux = priceInRobux }):andThen(function(tbl10)
            if var7.current ~= current or var17.current ~= tbl9 then
                return
            end
            local var34 = table.clone(editTelemetryParameters)
            var34.action = "product_details"

            sendMonetizationEvent("MONETIZATION_PRODUCT_UPDATE_SUCCESS", var5, var34)

            local var35, var36 = applyProductEditResult(var30, tbl10, name, editDescription, priceInRobux)
            if FFlagBuildExperienceMonetizationMultiKind then
                local func5 = withOverride(var35, "details")

                func2(func5)
            else
                var11(var35)
            end
            var16(false)
            setProductSaleStatusError(false)
            if var36 then
                setProductEditError(var2.moderationError)
            elseif not FFlagBuildExperienceMonetizationMultiKind or selectedProductIdRef.current == productIdentity(var30) then
                var9("detail")
            end
        end):catch(function(arg1)
            if var7.current ~= current or var17.current ~= tbl9 then
                return
            end
            local var34 = var30

            if FFlagBuildExperienceMonetizationNativeUI then
                local var35 = string.gsub(formatError(arg1), "[\r\n]+", " ")
                local productKind = var34.productKind or "DeveloperProduct"
                warn(`[{productKind}] action=product_details productId={var34.id} failed={string.sub(var35, 1, 200)}`)
            end

            local var35 = table.clone(editTelemetryParameters)
            var35.action = "product_details"

            sendMonetizationEvent("MONETIZATION_PRODUCT_UPDATE_FAILURE", var5, var35)

            setProductEditError(var2.updateError)
        end):finally(function()
            if var7.current == current and var17.current == tbl9 then
                var17.current = nil
                setIsProductEditPending(false)
            end
        end)
    end, {
        bool1,
        editDescription,
        editName,
        editPrice,
        isProductEditPending,
        var2.descriptionLengthError,
        var2.moderationError,
        var2.nameLengthError,
        var2.nameRequiredError,
        var2.priceError,
        var2.updateError,
        tbl5.onUpdateProduct,
        onUpdateProductKind,
        var10,
        setIsProductEditPending,
        setProductEditError,
        setProductSaleStatusError,
        var5,
        current
    })

    local var31 = tbl5.onComposerActivated or tbl5.onClose
    local bool2 = tbl5.canEditOnBuild ~= false
    local bool3 = bool1
    if FFlagBuildCheckGamePermissions and tbl5.permissionLoadStatus ~= nil then
        bool3 = tbl5.permissionLoadStatus == "Ready" and tbl5.permissionCanMonetize == true
    end

    local var32, tbl9

    if FFlagBuildExperienceDeveloperProductContext then
        local composerText, onComposerChanged = React.useBinding("")
        local textBoxRef = React.useRef(nil)
        var32 = useOnScreenKeyboardHeight()
        React.useEffect(function()
            onComposerChanged("")
        end, {
            tbl5.universeId or 0,
            tbl5.sessionId or "",
            if var10 == nil then "" else var10.id,
            onComposerChanged
        })

        local onSend = React.useCallback(function(): boolean
            local text = trim((composerText:getValue()))
            if text == "" or mode ~= "detail" or var10 == nil or tbl5.universeId == nil then
                return false
            end
            GetBuildPromptDraftStore().queueDraft({
                universeId = tbl5.universeId,
                sessionId = tbl5.sessionId,
                text = text,
                autoSend = true,
                resourceAttachments = {{
                    type = "resource_link",
                    name = var10.name,
                    uri = productResourceUrl(tbl5.universeId, var10),
                    mimeType = "application/json"
                }}
            })

            onComposerChanged("")
            if textBoxRef.current ~= nil then
                textBoxRef.current.releaseFocus()
            end
            var31()
            return true
        end, {
            composerText,
            var31,
            mode,
            tbl5.sessionId,
            tbl5.universeId,
            var10,
            onComposerChanged
        })

        if mode == "detail" and var10 ~= nil and hasProductComposer(var10) and tbl5.universeId ~= nil then
            tbl9 = {
                composerText = composerText,
                onComposerChanged = onComposerChanged,
                placeholder = var2.composerPlaceholder,
                textBoxRef = textBoxRef,
                isAssistantResponding = false,
                canSendWhileResponding = false,
                allowImageAttachments = false,
                tracksExternalText = true,
                onSend = onSend,
                onStop = function() end,
                isReadOnly = not bool2
            }
        else
            tbl9 = nil
        end
    else
        var32 = nil
        tbl9 = nil
    end

    local onOpenCreate = React.useCallback(function()
        if not bool3 then
            return
        end
        sendMonetizationEvent("MONETIZATION_CREATE_CLICK", var5, nil)
        if tbl5.onCreateProduct ~= nil then
            tbl5.onCreateProduct()
            return
        end
        GetBuildPromptDraftStore().queueDraft(
            {
                universeId = tbl5.universeId,
                sessionId = tbl5.sessionId,
                text = var2.createProductPrompt
            }
        )
        var31()
    end, {
        var31,
        var2.createProductPrompt,
        bool3,
        tbl5.onCreateProduct,
        tbl5.sessionId,
        tbl5.universeId,
        var5
    })

    local onRetryCatalog = React.useCallback(function()
        sendMonetizationEvent("MONETIZATION_RETRY_CLICK", var5, nil)
        if tbl5.onRetryCatalog ~= nil then
            tbl5.onRetryCatalog()
        end
    end, { tbl5.onRetryCatalog, var5 })

    local onRetryCatalogSource = if FFlagBuildExperienceMonetizationMultiKind then React.useCallback(function(arg1)
        sendMonetizationEvent("MONETIZATION_RETRY_CLICK", var5, { catalogKind = tostring(arg1) })
        if tbl5.onRetryCatalogSource ~= nil then
            tbl5.onRetryCatalogSource(arg1)
        end
    end, { tbl5.onRetryCatalogSource, var5 }) else nil

    local kindSaleCapabilities = getKindSaleCapabilities(var10)
    local priceInRobux = if var10 == nil then nil else var10.priceInRobux
    local regionalPricingViewState = getRegionalPricingViewState(tbl5, var10, bool1, productManagedPricingError, var2)

    local kindEditState = getKindEditState(var10, bool1, tbl5)
    local tbl10 = {
        mode = mode,
        keyboardHeight = if FFlagBuildExperienceDeveloperProductContext then if mode ~= "detail" then 0 else var32 else nil,
        chatActions = tbl9,
        products = products,
        catalogSources = tbl5.catalogSources,
        showOptions = FFlagBuildExperienceMonetizationNativeUI and tbl5.showOptions == true,
        optionsLoadStatus = tbl6.loadStatus,
        canMonetize = tbl6.canMonetize,
        canCreateProduct = bool3,
        canChangeManagedPricing = tbl6.canChangeManagedPricing,
        managedPricingState = tbl6.managedPricingState,
        managedPricingSupportingText = tbl6.managedPricingSupportingText,
        shopButtonEnabled = tbl6.shopButtonEnabled,
        isOptionsManagedPricingPending = tbl6.isManagedPricingPending,
        isShopButtonPending = tbl6.isShopButtonPending,
        managedPricingError = tbl6.managedPricingError,
        shopButtonError = tbl6.shopButtonError,
        showManagedPricingAcknowledgement = tbl6.showAcknowledgement,
        disableDialogPortal = tbl5.disableDialogPortal,
        selectedProduct = var10,
        isProductDisabled = tbl5.isProductDisabled == true
            or (if canManageProduct(var10) or getKindSaleCapabilities(var10) ~= nil then isProductMutationDisabled(var10) else false),
        isProductManagedPricingPending = isProductManagedPricingPending,
        isProductSaleStatusPending = isProductSaleStatusPending,
        isProductEditPending = isProductEditPending,
        canUpdateProductManagedPricing = regionalPricingViewState.canUpdate
    }
    local bool4 = FFlagBuildExperienceMonetizationProductEditing and canManageProduct(var10)

    if bool4 then
        if bool1 then
            if tbl5.onUpdateProductSaleStatus == nil then
                bool4 = false
            else
                bool4 = tbl5.onUpdateProduct ~= nil
            end
        else
            bool4 = bool1
        end
    end

    tbl10.canManageProduct = bool4

    tbl10.canChangeKindManagedPricing = regionalPricingViewState.canChangeKind
    tbl10.canEditKindProduct = kindEditState.canEdit
    tbl10.canEditName = kindEditState.canEditName
    tbl10.canEditPrice = kindEditState.canEditPrice
    tbl10.canChangeSaleStatus = if FFlagBuildExperienceMonetizationManageKinds then bool1 and not (getKindSaleCapabilities(var10) == nil) and tbl5.onUpdateProductKindSaleStatus ~= nil else nil

    tbl10.productManagedPricingError = productManagedPricingError
    tbl10.productManagedPricingErrorLabel = regionalPricingViewState.errorLabel
    tbl10.productSaleStatusError = productSaleStatusError ~= false
    tbl10.productSaleStatusErrorLabel = if FFlagBuildExperienceMonetizationManageKinds and productSaleStatusError and kindSaleCapabilities ~= nil then if kindSaleCapabilities.priceRequiredForSale and priceInRobux == nil then var2.kindPriceRequiredForSale else var2.updateError else nil

    tbl10.productEditError = productEditError
    tbl10.editName = editName
    tbl10.editDescription = editDescription
    tbl10.editPrice = editPrice
    tbl10.catalogStatus = tbl5.catalogStatus or "Ready"
    tbl10.emptyTitle = var2.emptyTitle
    tbl10.emptyDescription = var2.emptyDescription
    tbl10.onClose = onClose
    tbl10.onOpenCreate = onOpenCreate
    tbl10.onOpenOptions = onOpenOptions
    tbl10.onManagedPricingChanged = tbl6.onManagedPricingChanged
    tbl10.onShopButtonChanged = tbl6.onShopButtonChanged
    tbl10.onConfirmManagedPricing = tbl6.onConfirmManagedPricing
    tbl10.onCancelManagedPricing = tbl6.onCancelManagedPricing
    tbl10.onRetryOptions = tbl6.onRetry
    tbl10.onProductActivated = onProductActivated
    tbl10.onProductManagedPricingChanged = onProductManagedPricingChanged
    tbl10.onProductSaleStatusChanged = onProductSaleStatusChanged
    tbl10.onOpenProductEdit = onOpenProductEdit
    tbl10.onEditNameChanged = onEditNameChanged
    tbl10.onEditDescriptionChanged = onEditDescriptionChanged
    tbl10.onEditPriceChanged = onEditPriceChanged
    tbl10.onCancelProductEdit = onCancelProductEdit
    tbl10.onSaveProductEdit = onSaveProductEdit
    tbl10.onRetryCatalog = onRetryCatalog
    tbl10.onRetryCatalogSource = onRetryCatalogSource
    tbl10.labels = {
        title = var2.title,
        options = tbl6.labels.options,
        pricingOptions = tbl6.labels.pricingOptions,
        pricingOptionsDescription = tbl6.labels.pricingOptionsDescription,
        managedPricing = tbl6.labels.managedPricing,
        managedPricingDescription = tbl6.labels.managedPricingDescription,
        shopUI = tbl6.labels.shopUI,
        shopButton = tbl6.labels.shopButton,
        shopButtonDescription = tbl6.labels.shopButtonDescription,
        optionsLoadError = tbl6.labels.optionsLoadError,
        permissionDenied = tbl6.labels.permissionDenied,
        mixed = tbl6.labels.mixed,
        unavailable = tbl6.labels.unavailable,
        noEligibleProducts = tbl6.labels.noEligibleProducts,
        optionsUpdateError = tbl6.labels.optionsUpdateError,
        partialUpdateError = tbl6.labels.partialUpdateError,
        acknowledgementTitle = tbl6.labels.acknowledgementTitle,
        acknowledgementDescription = tbl6.labels.acknowledgementDescription,
        agree = tbl6.labels.agree,
        emptyCreateProduct = var2.emptyCreateProduct,
        pricing = var2.pricing,
        regionalPricing = var2.regionalPricing,
        loading = var2.loading,
        loadErrorTitle = var2.loadErrorTitle,
        loadErrorDescription = var2.loadErrorDescription,
        retry = var2.retry,
        updateError = var2.updateError,
        availableForPurchase = var2.availableForPurchase,
        edit = var2.edit,
        editProduct = var2.editProduct,
        name = var2.name,
        description = var2.description,
        price = var2.price,
        priceError = var2.priceError,
        priceRequiredForSale = var2.priceRequiredForSale,
        cancel = var2.cancel,
        save = var2.save
    }
    return tbl10
end

return useMonetizationPageViewModel
