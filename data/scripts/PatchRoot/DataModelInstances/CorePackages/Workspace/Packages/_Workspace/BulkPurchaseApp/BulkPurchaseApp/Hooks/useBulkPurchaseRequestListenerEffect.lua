-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:50:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")

local BulkPurchaseApp = script:FindFirstAncestor("BulkPurchaseApp")
local BulkPurchaseAppParent = BulkPurchaseApp.Parent
local React = require(BulkPurchaseAppParent.React)
local IXPServiceWrapper = require(BulkPurchaseAppParent.IXPServiceWrapper).IXPServiceWrapper
local useDispatch = require(BulkPurchaseAppParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useSelector = require(BulkPurchaseAppParent.RoactUtils).Hooks.RoactRodux.useSelector

local InitiateBulkPurchaseFlow = require(BulkPurchaseApp.Store.Thunks.InitiateBulkPurchaseFlow)
local useNetwork = require(BulkPurchaseAppParent.EconomyCommonCoreScriptHooks).useNetwork
local _Types = require(BulkPurchaseApp.Store.Types)
local PurchasableStateEnum = require(BulkPurchaseApp.Enums.PurchasableStateEnum)
local BulkPurchasePromptStateEnum = require(BulkPurchaseApp.Enums.BulkPurchasePromptStateEnum)
local selectPromptState = require(BulkPurchaseApp.Store.Selectors.selectPromptState)
local BulkPurchaseRefreshed = require(BulkPurchaseApp.Store.Actions.BulkPurchaseRefreshed)
local BulkPurchaseFailed = require(BulkPurchaseApp.Store.Actions.BulkPurchaseFailed)
local ErrorCodeEnum = require(BulkPurchaseApp.Enums.ErrorCodeEnum)
local BulkPurchaseCountersEnum = require(BulkPurchaseApp.Enums.BulkPurchaseCountersEnum)
local reportBulkPurchaseRequestCounters = require(BulkPurchaseApp.Utils.reportBulkPurchaseRequestCounters)

local FFlagBulkPurchaseEnablePurchaseOptions = require(BulkPurchaseApp.Flags.FFlagBulkPurchaseEnablePurchaseOptions)
local FFlagAXAddPlusUpsellToBulkPurchase = require(BulkPurchaseApp.Flags.FFlagAXAddPlusUpsellToBulkPurchase)
local FFlagBulkPurchaseReportCounters = require(BulkPurchaseApp.Flags.FFlagBulkPurchaseReportCounters)
local FFlagAXAddOffersToBulkPurchase = require(BulkPurchaseApp.Flags.FFlagAXAddOffersToBulkPurchase)
local convertToDiscountInformationOrNil = require(BulkPurchaseApp.Utils.convertToDiscountInformationOrNil)
local bool1 = game:DefineFastFlag("AXAddPlusUpsellToBulkPurchaseExposure", false)

local str1 = game:DefineFastString("AXAddPlusUpsellToBulkPurchaseLayerName", "AvatarExperience.UA.MarketplaceView")

local _Types2 = require(BulkPurchaseApp.Store.Types)

local function decodeLuauUnicodeEscapes(str2: string) -- Luacid: Inlined by compiler; 3 call sites recovered
    return (str2:gsub("\\u{(%x+)}", function(str3: string): string
        local var1 = tonumber(str3, 16)
        if var1 == nil or var1 < 0 or var1 > 1114111 then
            return ""
        end
        return utf8.char(var1)
    end))
end

local function getOffersAvailableMap(availableOffers)
    local offersAvailableMap = {}
    if availableOffers ~= nil then
        for _, availableOffer in availableOffers do
            offersAvailableMap[availableOffer.offerId] = availableOffer
            if availableOffer.localizedDescription then
                availableOffer.localizedDescription = decodeLuauUnicodeEscapes(availableOffer.localizedDescription)
            end
        end
    end
    return offersAvailableMap
end

local function transformItemDataToBulkPurchaseItemData(displayData)
    local result = {}
    for _, value in displayData do
        table.insert(result, {
            id = value.id,
            name = value.name,
            description = value.description,
            priceRobux = value.priceRobux,
            type = value.type,
            ownedCount = value.ownedCount,
            quantityLimitPerUser = value.quantityLimitPerUser,
            isLimited = value.isLimited,
            purchasableState = if value.purchaseableState == "Purchaseable" then PurchasableStateEnum.Purchasable else value.purchaseableState,
            discountInformation = value.discountInformation,
            purchaseOptions = if FFlagBulkPurchaseEnablePurchaseOptions then value.purchaseOptions else nil
        })
    end
    return result
end

local function useBulkPurchaseRequestListenerEffect()
    local var1 = useDispatch()
    local var2 = useNetwork()

    local var3 = if FFlagAXAddPlusUpsellToBulkPurchase then useSelector(selectPromptState) == BulkPurchasePromptStateEnum.Request else nil

    if FFlagAXAddOffersToBulkPurchase then
        React.useEffect(function()
            local var4 = nil
            if var1 and var2 then
                local success, result = pcall(function(): RBXScriptConnection
                    return MarketplaceService.PromptBulkPurchaseRequestedV3:Connect(function(player: Instance, _marketplaceBulkPurchasePromptStatus: Enum.MarketplaceBulkPurchasePromptStatus, response)
                        local orderRequest = response.orderRequest
                        local purchaserRobuxBalance = response.purchaserRobuxBalance
                        local orderTotalRobux = response.orderTotalRobux
                        local options = response.options
                        local discountInformation = response.discountInformation

                        if player ~= Players.LocalPlayer then
                            return
                        end

                        if FFlagBulkPurchaseEnablePurchaseOptions and require(BulkPurchaseApp.Flags.FFlagBulkPurchaseReportsMissingPurchaseOptions) then
                            require(BulkPurchaseApp.Utils.reportBulkPurchaseRequestIssues)(response.displayData)
                        end

                        if bool1 then
                            IXPServiceWrapper:LogFlagLinkedUserLayerExposure(str1)
                        end

                        local tbl1 = {
                            offersAvailable = getOffersAvailableMap(response.availableOffers),
                            savingsSummary = if response.savingsSummary then decodeLuauUnicodeEscapes(response.savingsSummary) else nil
                        }

                        var1(
                            InitiateBulkPurchaseFlow(
                                var2,
                                transformItemDataToBulkPurchaseItemData(response.displayData),
                                orderRequest,
                                purchaserRobuxBalance,
                                orderTotalRobux,
                                options,
                                convertToDiscountInformationOrNil(discountInformation),
                                tbl1
                            )
                        )
                    end)
                end)

                if success then
                    var4 = result
                end
            end
            return function()
                if var4 then
                    var4:Disconnect()
                    var4 = nil
                end
            end
        end, { var1, var2 })
    else
        React.useEffect(function()
            local connection = if var1 and var2 then MarketplaceService.PromptBulkPurchaseRequestedV2:Connect(function(player: Instance, displayData, orderRequest, purchaserRobuxBalance: number, orderTotalRobux: number, options, discountInformation)
                if player ~= Players.LocalPlayer then
                    return
                end

                if FFlagBulkPurchaseEnablePurchaseOptions and require(BulkPurchaseApp.Flags.FFlagBulkPurchaseReportsMissingPurchaseOptions) then
                    require(BulkPurchaseApp.Utils.reportBulkPurchaseRequestIssues)(displayData)
                end

                if bool1 then
                    IXPServiceWrapper:LogFlagLinkedUserLayerExposure(str1)
                end

                var1(
                    InitiateBulkPurchaseFlow(
                        var2,
                        transformItemDataToBulkPurchaseItemData(displayData),
                        orderRequest,
                        purchaserRobuxBalance,
                        orderTotalRobux,
                        options,
                        convertToDiscountInformationOrNil(discountInformation)
                    )
                )
            end) else nil

            return function()
                if connection then
                    connection:Disconnect()
                    connection = nil
                end
            end
        end, { var1, var2 })
    end

    if not FFlagAXAddPlusUpsellToBulkPurchase then
        return
    end

    React.useEffect(function()
        local var4 = nil

        if var3 then
            local success, result = pcall(function(): RBXScriptConnection
                return MarketplaceService.PromptBulkPurchaseRefreshed:Connect(function(player: Instance, status: Enum.MarketplaceBulkPurchasePromptStatus, response)
                    local tbl1 = if FFlagAXAddOffersToBulkPurchase then {
                        offersAvailable = getOffersAvailableMap(response.availableOffers),
                        savingsSummary = if response.savingsSummary then decodeLuauUnicodeEscapes(response.savingsSummary) else nil
                    } else nil

                    if player == Players.LocalPlayer and status == Enum.MarketplaceBulkPurchasePromptStatus.Completed then
                        if FFlagAXAddOffersToBulkPurchase then
                            var1(
                                BulkPurchaseRefreshed(
                                    transformItemDataToBulkPurchaseItemData(response.displayData),
                                    response.orderRequest,
                                    response.purchaserRobuxBalance,
                                    response.orderTotalRobux,
                                    response.options,
                                    convertToDiscountInformationOrNil(response.discountInformation),
                                    tbl1
                                )
                            )
                            return
                        end

                        var1(
                            BulkPurchaseRefreshed(
                                transformItemDataToBulkPurchaseItemData(response.displayData),
                                response.orderRequest,
                                response.purchaserRobuxBalance,
                                response.orderTotalRobux,
                                response.options,
                                convertToDiscountInformationOrNil(response.discountInformation)
                            )
                        )
                        return
                    end

                    if FFlagBulkPurchaseReportCounters then
                        reportBulkPurchaseRequestCounters(BulkPurchaseCountersEnum.BulkPurchaseRefreshFailedCounter)
                    end

                    var1(BulkPurchaseFailed(ErrorCodeEnum.Generic))
                end)
            end)

            if success then
                var4 = result
            end
        end

        return function()
            if var4 then
                var4:Disconnect()
            end
        end
    end, { var1, var3 })
end

return useBulkPurchaseRequestListenerEffect
