-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:31:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxSubscriptionPurchaseApp = script:FindFirstAncestor("RobloxSubscriptionPurchaseApp")
local RobloxSubscriptionPurchaseAppParent = RobloxSubscriptionPurchaseApp.Parent

local React = require(RobloxSubscriptionPurchaseAppParent.React)
local Foundation = require(RobloxSubscriptionPurchaseAppParent.Foundation)
local LuauPolyfill = require(RobloxSubscriptionPurchaseAppParent.LuauPolyfill)
local RobloxSubscriptionStore = require(RobloxSubscriptionPurchaseApp.Store.RobloxSubscriptionStore)
local _GetRobloxSubscriptionProductsModel = require(RobloxSubscriptionPurchaseApp.Models.GetRobloxSubscriptionProductsModel)
local useLocalization = require(RobloxSubscriptionPurchaseAppParent.Localization).Hooks.useLocalization
local getPeriodTypeDisplayLabel = require(RobloxSubscriptionPurchaseApp.Utils.getPeriodTypeDisplayLabel)
local getFreeTrialOffer = require(RobloxSubscriptionPurchaseApp.Utils.getFreeTrialOffer)
local getTrialUnlockDays = require(RobloxSubscriptionPurchaseApp.Utils.getTrialUnlockDays)
local isSupportedTrialPeriodType = require(RobloxSubscriptionPurchaseApp.Utils.isSupportedTrialPeriodType)
local SignalsReact = require(RobloxSubscriptionPurchaseAppParent.SignalsReact)

local bool1 = game:DefineFastFlag("RobloxPlusUpdateDiscountIcons", false)
local FFlagRobloxPlusEnableNewFeatureList = require(RobloxSubscriptionPurchaseApp.Flags.FFlagRobloxPlusEnableNewFeatureList)
local FFlagRobloxPlusTrialDiscountTiming = require(RobloxSubscriptionPurchaseApp.Flags.FFlagRobloxPlusTrialDiscountTiming)
local FFlagEnablePlusReferralLandingSheet = require(RobloxSubscriptionPurchaseAppParent.SharedFlags).FFlagEnablePlusReferralLandingSheet
local FFlagRobloxPlusAppIconBenefit = require(RobloxSubscriptionPurchaseApp.Flags.FFlagRobloxPlusAppIconBenefit)
local FFlagAppIconSelectionPage = require(RobloxSubscriptionPurchaseAppParent.SharedFlags).FFlagAppIconSelectionPage
local UniversalAppPolicy = if FFlagRobloxPlusAppIconBenefit then require(RobloxSubscriptionPurchaseAppParent.UniversalAppPolicy) else nil
local Array = LuauPolyfill.Array

local FeatureRow = require(script.Parent.FeatureRow)

local View = Foundation.View
local IconName = Foundation.Enums.IconName

local function getVirtualTransactionDiscounts(arg1)
    if not (arg1 and arg1.VirtualTransactionDiscounts) then
        return nil, nil
    end

    local var1 = nil
    local var2 = nil

    for _, virtualTransactionDiscount in ipairs(arg1.VirtualTransactionDiscounts) do
        if typeof(virtualTransactionDiscount) ~= "table" or typeof(virtualTransactionDiscount.PeriodIndex) ~= "number" then
            continue
        end

        if virtualTransactionDiscount.PeriodIndex == 0 then
            var1 = var1 or virtualTransactionDiscount
        elseif virtualTransactionDiscount.PeriodIndex > 0 and (var2 == nil or virtualTransactionDiscount.PeriodIndex < var2.PeriodIndex) then
            var2 = virtualTransactionDiscount
        end
    end

    return var1, var2
end

local function getPrivateServerDiscount(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if not (arg1 and arg1.PrivateServerDiscounts) then
        return nil
    end

    return Array.find(arg1.PrivateServerDiscounts, function(arg2): boolean
        return typeof(arg2) == "table" and typeof(arg2.PeriodIndex) == "number" and arg2.PeriodIndex == 0
    end)
end

local function RobloxSubscriptionFeatureList(tbl1)
    local var1 = RobloxSubscriptionStore.get()
    local var2 = SignalsReact.useSignalState(var1.getRobloxSubscriptionProduct)
    local var3 = if var2 and var2.PeriodType then tostring(var2.PeriodType) or "" else ""
    local periodType = getPeriodTypeDisplayLabel(var3, true)
    local freeTrialOffer = if FFlagRobloxPlusTrialDiscountTiming then getFreeTrialOffer(var2) else nil
    local var4 = FFlagRobloxPlusTrialDiscountTiming

    if var4 then
        if freeTrialOffer == nil then
            var4 = false
        else
            var4 = isSupportedTrialPeriodType(freeTrialOffer.PeriodType)
        end
    end

    local var5 = useLocalization({ periodType = periodType })

    local featureConfig = var2
        and var2.ProductTypeDetails
        and var2.ProductTypeDetails.RobloxSubscriptionProductDetails
        and var2.ProductTypeDetails.RobloxSubscriptionProductDetails.FeatureConfig

    local var6, var7 = getVirtualTransactionDiscounts(featureConfig)
    local privateServerDiscount = getPrivateServerDiscount(featureConfig)
    local trialUnlockDays = if var4 then getTrialUnlockDays(freeTrialOffer, var7 and var7.PeriodIndex, var3) else nil
    local var8 = FFlagRobloxPlusAppIconBenefit
        and FFlagAppIconSelectionPage
        and UniversalAppPolicy.getAppFeaturePolicies().getShowAppIconSetting()

    local var9 = useLocalization({
        baseVirtualTransactionDiscountText = {
            "Feature.RobloxSubscription.Label.BlackbirdVTDiscountFirst",
            discountPercent = var6 and var6.DiscountPercent or 0
        },
        nextVirtualTransactionDiscountText = {
            "Feature.RobloxSubscription.Label.BlackbirdVTDiscountSecond",
            discountPercent = var7 and var7.DiscountPercent or 0,
            periodIndex = var7 and var7.PeriodIndex or 0,
            periodType = var5.periodType
        },
        robuxTransfersText = "Feature.RobloxSubscription.Label.BlackbirdTr",
        privateServerDiscountText = "Feature.RobloxSubscription.Label.BlackbirdPSDiscount",
        discountFeatureText = "Feature.RobloxSubscription.Description.Benefit.DiscountV2",
        discountFeatureTextV3 = var4 and {
            "Feature.RobloxSubscription.Description.Benefit.DiscountV3",
            trialUnlockDays = trialUnlockDays
        } or nil,
        customizeFeatureText = if var8 then "Feature.RobloxSubscription.Description.Benefit.CustomizeWithAppIcon" else "Feature.RobloxSubscription.Description.Benefit.Customize"
    })

    local tbl2 = {}

    local function addRow(iconName, text) -- Luacid: unused: defined but never referenced
        table.insert(tbl2, FeatureRow({ layoutOrder = #tbl2 + 1, iconName = iconName, text = text }))
    end

    if FFlagRobloxPlusEnableNewFeatureList then
        if tbl1.noPurchaseMethodRequired then
            if var6 then
                local tag = IconName.Tag
                local baseVirtualTransactionDiscountText = var9.baseVirtualTransactionDiscountText
                local var10 = FeatureRow
                local tbl3 = {
                    layoutOrder = #tbl2 + 1,
                    iconName = tag,
                    text = baseVirtualTransactionDiscountText
                }
                table.insert(tbl2, var10(tbl3))
            end
        else
            if var6 and var7 then
                local tag = IconName.Tag
                local text = if var4 then var9.discountFeatureTextV3 else var9.discountFeatureText
                local var11 = FeatureRow
                local tbl3 = {
                    layoutOrder = #tbl2 + 1,
                    iconName = tag,
                    text = text
                }
                table.insert(tbl2, var11(tbl3))
            elseif var6 and not var7 then
                local tag = IconName.Tag
                local baseVirtualTransactionDiscountText = var9.baseVirtualTransactionDiscountText
                local var10 = FeatureRow
                local tbl3 = {
                    layoutOrder = #tbl2 + 1,
                    iconName = tag,
                    text = baseVirtualTransactionDiscountText
                }
                table.insert(tbl2, var10(tbl3))
            end

            local paintBrush = IconName.PaintBrush
            local customizeFeatureText = var9.customizeFeatureText
            local var10 = FeatureRow
            local tbl3 = {
                layoutOrder = #tbl2 + 1,
                iconName = paintBrush,
                text = customizeFeatureText
            }
            table.insert(tbl2, var10(tbl3))
        end
    else
        if var6 and typeof(var6.DiscountPercent) == "number" then
            local iconName = if bool1 then IconName.Tag else IconName.TagSparkle
            local baseVirtualTransactionDiscountText = var9.baseVirtualTransactionDiscountText
            local var11 = FeatureRow
            local tbl3 = {
                layoutOrder = #tbl2 + 1,
                iconName = iconName,
                text = baseVirtualTransactionDiscountText
            }
            table.insert(tbl2, var11(tbl3))
        end

        if var7 and typeof(var7.DiscountPercent) == "number" and not tbl1.noPurchaseMethodRequired then
            local iconName = if bool1 then IconName.TagArrowUp else IconName.TagSparkleArrowUp
            local nextVirtualTransactionDiscountText = var9.nextVirtualTransactionDiscountText
            local var11 = FeatureRow
            local tbl3 = {
                layoutOrder = #tbl2 + 1,
                iconName = iconName,
                text = nextVirtualTransactionDiscountText
            }
            table.insert(tbl2, var11(tbl3))
        end
    end

    if privateServerDiscount and typeof(privateServerDiscount.DiscountPercent) == "number" then
        local controller = IconName.Controller
        local privateServerDiscountText = var9.privateServerDiscountText
        local var10 = FeatureRow
        local tbl3 = {
            layoutOrder = #tbl2 + 1,
            iconName = controller,
            text = privateServerDiscountText
        }
        table.insert(tbl2, var10(tbl3))
    end

    if featureConfig and featureConfig.IsRobuxTransferEnabled then
        local robux = IconName.Robux
        local robuxTransfersText = var9.robuxTransfersText
        local var10 = FeatureRow
        local tbl3 = {
            layoutOrder = #tbl2 + 1,
            iconName = robux,
            text = robuxTransfersText
        }
        table.insert(tbl2, var10(tbl3))
    end

    return React.createElement(View, {
        tag = FFlagEnablePlusReferralLandingSheet
            and tbl1.compact
            and "col auto-y size-full-0 align-x-left gap-small padding-top-small"
            or "col auto-y size-full-0 align-x-left gap-medium padding-top-large",
        LayoutOrder = tbl1.layoutOrder
    }, tbl2)
end

return RobloxSubscriptionFeatureList
