-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:51:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceAnalytics = script:FindFirstAncestor("AvatarExperienceAnalytics")
local AvatarExperienceAnalyticsParent = AvatarExperienceAnalytics.Parent

local CollectionService = game:GetService("CollectionService")
local React = require(AvatarExperienceAnalyticsParent.React)
local Cryo = require(AvatarExperienceAnalyticsParent.Cryo)
local sendUnifiedEventLogForInstance = require(script.Parent.sendUnifiedEventLogForInstance)
local UnifiedEventLogConstants = require(script.Parent.UnifiedEventLogConstants)
local UnifiedEventLogEnums = require(script.Parent.UnifiedEventLogEnums)
local resolveClickSurface = require(script.Parent.resolveClickSurface)
local applyClickStampFieldOverrides = require(script.Parent.applyClickStampFieldOverrides)
local UnifiedEventLoggingUtils = require(AvatarExperienceAnalytics.Utils.UnifiedEventLoggingUtils)
local getDeferredPurchaseSourceTile = require(AvatarExperienceAnalytics.Utils.getDeferredPurchaseSourceTile)
local UnifiedSelectionListStore = require(AvatarExperienceAnalytics.Store.UnifiedSelectionListStore)
local LastDeferredSingleItemStore = require(AvatarExperienceAnalytics.Store.LastDeferredSingleItemStore)
local CartIdService = require(AvatarExperienceAnalytics.Lib.CartIdService)
local AvatarExperienceCommon = require(AvatarExperienceAnalyticsParent.AvatarExperienceCommon)
local useSelectorSignal = AvatarExperienceCommon.Hooks.useSelectorSignal
local selectSearchKeyword = AvatarExperienceCommon.State.Selectors.selectSearchKeyword
local AvatarExperienceNavigation = require(AvatarExperienceAnalyticsParent.AvatarExperienceNavigation)
local useAvatarRoute = AvatarExperienceNavigation.AvatarRoute.Hooks.useAvatarRoute
local AvatarScreenProperties = AvatarExperienceNavigation.AvatarRoute.AvatarScreenProperties
local UnifiedLoggingSurface = AvatarExperienceNavigation.Enums.UnifiedLoggingSurface

local AvatarExperienceFlags = require(AvatarExperienceAnalyticsParent.AvatarExperienceFlags)
local FFlagAXMISEnableMultiShoppingUnifiedEvents = AvatarExperienceFlags.FFlagAXMISEnableMultiShoppingUnifiedEvents
local FFlagAXUnifiedImpressionsOnThumbnail = AvatarExperienceFlags.FFlagAXUnifiedImpressionsOnThumbnail
local FFlagAXFixSingleItemPurchaseWidgetLogging = AvatarExperienceFlags.FFlagAXFixSingleItemPurchaseWidgetLogging
local FFlagAXFixSearchPurchaseSurface = AvatarExperienceFlags.FFlagAXFixSearchPurchaseSurface
local FFlagAXSkipTapDetection = AvatarExperienceFlags.FFlagAXSkipTapDetection

local function markLastActivated(instance: Instance)
    for _, value in (CollectionService:GetTagged(UnifiedEventLogConstants.LAST_ACTIVATED_TAG_NAME)) do
        CollectionService:RemoveTag(value, UnifiedEventLogConstants.LAST_ACTIVATED_TAG_NAME)
    end

    CollectionService:AddTag(instance, UnifiedEventLogConstants.LAST_ACTIVATED_TAG_NAME)
end

local function markSelectionListStatus(arg1, bool1: boolean, tbl1)
    local attributes = arg1:GetAttributes()

    if FFlagAXMISEnableMultiShoppingUnifiedEvents then
        for value, value2 in UnifiedEventLoggingUtils.getScreenSize(arg1) do
            attributes[UnifiedEventLogConstants.ATTRIBUTE_PREFIX .. value] = value2
        end

        for value, value2 in UnifiedEventLoggingUtils.getElementSizeAndPosition(arg1) do
            attributes[UnifiedEventLogConstants.ATTRIBUTE_PREFIX .. value] = value2
        end
    end

    if FFlagAXFixSearchPurchaseSurface and not bool1 then
        local var1 = UnifiedEventLogConstants.ATTRIBUTE_PREFIX .. "surface"
        if attributes[var1] == nil then
            local var2 = resolveClickSurface(arg1, if tbl1 then tbl1.current else nil)
            if var2 ~= nil then
                attributes[var1] = var2
            end
        end
    end

    if bool1 then
        UnifiedSelectionListStore.removeFromSelectionList(attributes)
        return
    end

    UnifiedSelectionListStore.addToSelectionList(attributes)
end

local function getChildButton(arg1)
    if not arg1 then
        return nil
    end

    if arg1:IsA("TextButton") or arg1:IsA("ImageButton") or arg1:IsA("GuiButton") then
        return arg1
    end
    for _, _ in arg1:GetDescendants() do
        if arg1:IsA("TextButton") or arg1:IsA("ImageButton") or arg1:IsA("GuiButton") then
            return arg1
        end
    end

    return nil
end

local function AnalyticsMetadataSelector(tbl1)
    return tbl1.AvatarExperience.AnalyticsMetadata
end

local function useUnifiedEventListenerInExperience(arg1, tbl1) -- Luacid: Inlined by compiler; 2 call sites recovered
    React.useEffect(function()
        local tbl2 = ({})

        local connection = CollectionService:GetInstanceAddedSignal(UnifiedEventLogConstants.TAG_NAME):Connect(function(arg2)
            local childButton = getChildButton(arg2)
            if not childButton then
                return
            end

            local connection = childButton.Activated:Connect(function()
                local attributes = arg2:GetAttributes()

                if FFlagAXSkipTapDetection and attributes[UnifiedEventLogConstants.SKIP_TAP_DETECTION] == true then
                    return
                end
                if attributes[UnifiedEventLogConstants.HAS_DEFERRED_ACTION] then
                    markLastActivated(arg2)
                end

                if FFlagAXMISEnableMultiShoppingUnifiedEvents
                    and attributes[UnifiedEventLogConstants.HAS_DEFERRED_ACTION]
                    and attributes[UnifiedEventLogConstants.IS_SELECTED] ~= nil
                then
                    markSelectionListStatus(
                        arg2,
                        attributes[UnifiedEventLogConstants.IS_SELECTED],
                        if FFlagAXFixSearchPurchaseSurface then tbl1 else nil
                    )
                end

                if FFlagAXFixSingleItemPurchaseWidgetLogging
                    and FFlagAXMISEnableMultiShoppingUnifiedEvents
                    and attributes[UnifiedEventLogConstants.ATTRIBUTE_PREFIX .. "action"] == UnifiedEventLogEnums.MarketplaceUnifiedAction.PURCHASE_ATTEMPT
                then
                    local var1 = getDeferredPurchaseSourceTile(
                        CollectionService:GetTagged(UnifiedEventLogConstants.TAG_NAME),
                        arg2,
                        attributes[UnifiedEventLogConstants.ATTRIBUTE_PREFIX .. "itemId"],
                        attributes[UnifiedEventLogConstants.ATTRIBUTE_PREFIX .. "itemType"]
                    )
                        or arg2
                    local attributes2 = var1:GetAttributes()

                    for value, value2 in UnifiedEventLoggingUtils.getScreenSize(var1) do
                        attributes2[UnifiedEventLogConstants.ATTRIBUTE_PREFIX .. value] = value2
                    end

                    for value, value2 in UnifiedEventLoggingUtils.getElementSizeAndPosition(var1) do
                        attributes2[UnifiedEventLogConstants.ATTRIBUTE_PREFIX .. value] = value2
                    end
                    LastDeferredSingleItemStore.setSnapshot(attributes2)
                end

                local var1 = not arg1 and {} or Cryo.Dictionary.join(arg1.getAnalyticsMetadata(false), { keyword = arg1.getSearchKeyword(false) })

                if FFlagAXUnifiedImpressionsOnThumbnail then
                    local var2 = arg2:GetAttribute(UnifiedEventLogConstants.ATTRIBUTE_PREFIX .. "surface")
                    local var3 = resolveClickSurface(arg2, if tbl1 then tbl1.current else nil)

                    if var3 ~= nil then
                        var1.surface = var3
                    end
                    if var2 ~= nil then
                        var3 = var2
                    end

                    if var3 ~= UnifiedLoggingSurface.SEARCH_RESULTS then
                        var1.keyword = nil
                    end
                elseif tbl1 and tbl1.current and tbl1.current.current then
                    local var2 = AvatarScreenProperties[tbl1.current.opaque.name]
                    if var2 and var2.analyticsData then
                        var1.surface = var2.analyticsData.unifiedLoggingSurface
                    end
                end

                if FFlagAXMISEnableMultiShoppingUnifiedEvents and attributes[UnifiedEventLogConstants.HAS_DEFERRED_ACTION] then
                    var1.cartId = CartIdService.getCartId()
                end

                if FFlagAXUnifiedImpressionsOnThumbnail then
                    var1 = applyClickStampFieldOverrides(var1, attributes)
                end

                sendUnifiedEventLogForInstance(arg2, var1, { includeScreenSize = true, includeElementSizeAndPosition = true })
            end)

            tbl2[arg2] = connection
        end)

        tbl2.instanceAdded = connection

        local connection2 = CollectionService:GetInstanceRemovedSignal(UnifiedEventLogConstants.TAG_NAME):Connect(function(arg2)
            local var1 = tbl2[arg2]
            if var1 then
                var1:Disconnect()
            end

            tbl2[arg2] = nil
        end)

        tbl2.instanceRemoved = connection2

        return function()
            for _, value in tbl2 do
                value:Disconnect()
            end

            tbl2 = {}
        end
    end, {})
end

return {
    useUnifiedEventListener = function()
        local getAnalyticsMetadata = useSelectorSignal(AnalyticsMetadataSelector)
        local getSearchKeyword = useSelectorSignal(selectSearchKeyword)

        local current = useAvatarRoute()
        local var4 = React.useRef(current)
        React.useEffect(function()
            var4.current = current
        end, { current })

        useUnifiedEventListenerInExperience(
            { getAnalyticsMetadata = getAnalyticsMetadata, getSearchKeyword = getSearchKeyword },
            var4
        )
    end,
    useUnifiedEventListenerInExperience = function()
        useUnifiedEventListenerInExperience(nil, nil)
    end
}
