-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:51:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceAnalyticsParent = script:FindFirstAncestor("AvatarExperienceAnalytics").Parent

local CollectionService = game:GetService("CollectionService")
local Cryo = require(AvatarExperienceAnalyticsParent.Cryo)
local React = require(AvatarExperienceAnalyticsParent.React)
local UnifiedEventLogConstants = require(script.Parent.UnifiedEventLogConstants)
local UnifiedEventLogEnums = require(script.Parent.UnifiedEventLogEnums)

local AvatarExperienceScreenSizeImpressionsDetector = require(script.Parent.AvatarExperienceScreenSizeImpressionsDetector)
local AvatarExperienceNavigation = require(AvatarExperienceAnalyticsParent.AvatarExperienceNavigation)
local useAvatarRoute = AvatarExperienceNavigation.AvatarRoute.Hooks.useAvatarRoute
local AvatarScreenProperties = AvatarExperienceNavigation.AvatarRoute.AvatarScreenProperties
local sendUnifiedEventLogForInstance = require(script.Parent.sendUnifiedEventLogForInstance)
local SeenImpressionsStore = require(script.Parent.Store.SeenImpressionsStore)

local UnifiedImpressions = SeenImpressionsStore.Category.UnifiedImpressions
local AvatarExperienceCommon = require(AvatarExperienceAnalyticsParent.AvatarExperienceCommon)
local useSelectorSignal = AvatarExperienceCommon.Hooks.useSelectorSignal
local selectSearchKeyword = AvatarExperienceCommon.State.Selectors.selectSearchKeyword

local AvatarExperienceFlags = require(AvatarExperienceAnalyticsParent.AvatarExperienceFlags)
local FFlagAXItemDetailsIxpExposure = AvatarExperienceFlags.FFlagAXItemDetailsIxpExposure
local FFlagAXUnifiedImpressionsOnThumbnail = AvatarExperienceFlags.FFlagAXUnifiedImpressionsOnThumbnail

local function AnalyticsMetadataSelector(arg1)
    return arg1.AvatarExperience.AnalyticsMetadata
end

local function getImpressionDedupKey(arg1)
    local attributePrefix = UnifiedEventLogConstants.ATTRIBUTE_PREFIX
    local var1 = arg1:GetAttribute(attributePrefix .. "widgetId")
    local var2 = arg1:GetAttribute(attributePrefix .. "itemId")
    if var2 ~= nil then
        local format = string.format

        local str1 = tostring(var1)
        local str2 = tostring(var2)
        local var3 = attributePrefix .. "gridPositionRow"
        local str3 = tostring(arg1:GetAttribute(var3))
        local var4 = attributePrefix .. "gridPositionColumn"
        local str4 = tostring(arg1:GetAttribute(var4))
        local var5 = attributePrefix .. "itemPosition"
        return format("item|%s|%s|%s|%s|%s", str1, str2, str3, str4, tostring(arg1:GetAttribute(var5)))
    elseif var1 ~= nil then
        return "widget|" .. tostring(var1)
    else
        return arg1:GetFullName()
    end
end
return function(tbl1)
    local var1 = nil
    local var2 = nil
    local var3 = nil
    if not FFlagAXItemDetailsIxpExposure then
        var1 = useAvatarRoute()
        var2 = useSelectorSignal(selectSearchKeyword)
        var3 = useSelectorSignal(AnalyticsMetadataSelector)
    end

    local var4 = React.useRef({})
    local var5 = if FFlagAXItemDetailsIxpExposure then React.useRef({}) else nil

    local filterImpressionFunc = React.useCallback(function(arg1): boolean
        if FFlagAXUnifiedImpressionsOnThumbnail then
            if arg1:GetAttribute(UnifiedEventLogConstants.SKIP_IMPRESSION_DETECTION) then
                return false
            end

            return not SeenImpressionsStore.hasSeen(UnifiedImpressions, getImpressionDedupKey(arg1))
        end

        return not var4.current[arg1:GetFullName()]
    end, {})

    local onImpressionsDetected = React.useCallback(function(arg1)
        local tbl2 = ({})

        for _, value in arg1 do
            local fullName = value:GetFullName()

            if if FFlagAXUnifiedImpressionsOnThumbnail then SeenImpressionsStore.hasSeen(UnifiedImpressions, getImpressionDedupKey(value)) else var4.current[fullName] then
                continue
            end

            if FFlagAXItemDetailsIxpExposure then
                tbl2[fullName] = value

                if not (FFlagAXUnifiedImpressionsOnThumbnail or var5.current[fullName]) then
                    var5.current[fullName] = value.AncestryChanged:Connect(function()
                        if value.Parent then
                            return
                        end

                        var4.current[fullName] = nil
                        if var5.current[fullName] then
                            var5.current[fullName]:Disconnect()
                            var5.current[fullName] = nil
                        end
                    end)
                end
            else
                local var7 = AvatarScreenProperties[var1.current.name]

                sendUnifiedEventLogForInstance(
                    value,
                    Cryo.Dictionary.join(var3(false), {
                        action = UnifiedEventLogEnums.MarketplaceUnifiedAction.ITEM_IMPRESSION,
                        surface = if var7 and var7.analyticsData then var7.analyticsData.unifiedLoggingSurface else nil,
                        keyword = var2(false)
                    }),
                    { includeScreenSize = true, includeElementSizeAndPosition = true }
                )
            end

            if FFlagAXUnifiedImpressionsOnThumbnail then
                SeenImpressionsStore.markSeen(UnifiedImpressions, getImpressionDedupKey(value))
            else
                var4.current[fullName] = true
            end
        end

        if not FFlagAXItemDetailsIxpExposure or not next(tbl2) or not tbl1.extensions then
            return
        end

        for _, visibleInstance in tbl2 do
            for _, extension in tbl1.extensions do
                extension({ visibleInstance = visibleInstance })
            end
        end
    end, FFlagAXItemDetailsIxpExposure and { tbl1.extensions } or { var1, var2, var3 })

    if FFlagAXItemDetailsIxpExposure then
        React.useEffect(function()
            return function()
                for _, value in var5.current do
                    if value then
                        value:Disconnect()
                    end
                end
                var5.current = {}
            end
        end, {})
    end

    local collectObjectsFunc = React.useCallback(function(arg1)
        if not FFlagAXUnifiedImpressionsOnThumbnail then
            return CollectionService:GetTagged(UnifiedEventLogConstants.TAG_NAME)
        end

        local tagged = CollectionService:GetTagged(UnifiedEventLogConstants.TAG_NAME)
        if not arg1 then
            return tagged
        end

        local result = {}
        for _, value in tagged do
            if value:IsDescendantOf(arg1) then
                table.insert(result, value)
            end
        end
        return result
    end, {})

    return React.createElement(AvatarExperienceScreenSizeImpressionsDetector, {
        parentRef = tbl1.parentRef,
        pageFilter = tbl1.pageFilter,
        onRequestImpressionsSignal = tbl1.requestImpressionsSignal,
        filterImpressionFunc = filterImpressionFunc,
        onImpressionsDetected = onImpressionsDetected,
        collectObjectsFunc = collectObjectsFunc
    })
end
