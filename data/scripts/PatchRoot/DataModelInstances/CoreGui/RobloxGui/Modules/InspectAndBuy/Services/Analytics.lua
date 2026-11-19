-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:21:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Players = game:GetService("Players")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local Cryo = require(CorePackages.Packages.Cryo)
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

local default = require(CorePackages.Workspace.Packages.LoggingProtocol).default
local EventStreamReporter = require(CorePackages.Workspace.Packages.TelemetryService).EventStreamReporter

local FFlagAXEnableInspectAndBuyVersionAnalytics = require(script.Parent.Parent.Flags.FFlagAXEnableInspectAndBuyVersionAnalytics)
local UnifiedEventLogEnums = require(CorePackages.Workspace.Packages.AvatarExperienceAnalytics).UnifiedEventLogEnums

local UnifiedLoggingSurface = require(CorePackages.Workspace.Packages.AvatarExperienceNavigation).Enums.UnifiedLoggingSurface

local UnifiedEventLogConstants = require(CorePackages.Workspace.Packages.AvatarExperienceAnalytics).UnifiedEventLogConstants
local ItemTypeEnum = require(CorePackages.Workspace.Packages.AvatarExperienceModel).Enums.ItemTypeEnum

local TIMED_OPTION_BY_DAYS = require(CorePackages.Workspace.Packages.AvatarExperienceAnalytics).Constants.TIMED_OPTION_BY_DAYS
local AXUnifiedEventFilter = require(CorePackages.Workspace.Packages.AvatarExperienceAnalytics).AXUnifiedEventFilter

local UnifiedEventCounterAggregator = require(CorePackages.Workspace.Packages.AvatarExperienceAnalytics).UnifiedEventCounterAggregator

local FFlagAXUnifiedEventCounters = require(CorePackages.Workspace.Packages.AvatarExperienceFlags).FFlagAXUnifiedEventCounters

local FFlagAXUnifiedEventStrictPayloads = require(CorePackages.Workspace.Packages.AvatarExperienceFlags).FFlagAXUnifiedEventStrictPayloads

local getMarketplaceUnifiedItemType = require(CorePackages.Workspace.Packages.AvatarExperienceAnalytics).Utils.getMarketplaceUnifiedItemType

local getMarketplaceUnifiedAssetType = require(CorePackages.Workspace.Packages.AvatarExperienceAnalytics).Utils.getMarketplaceUnifiedAssetType

local getMarketplaceUnifiedBundleType = require(CorePackages.Workspace.Packages.AvatarExperienceAnalytics).Utils.getMarketplaceUnifiedBundleType

local module = {}

module.__index = module
function module.__tostring(): string
    return "Service(Analytics)"
end

function module.new(inspecteeUid, ctx, version: number?)
    local module2 = {}

    setmetatable(module2, module)

    module2.eventStream = EventStreamReporter.new(default)

    local placeId = game.PlaceId
    module2.pid = tostring(placeId)
    local userId = Players.LocalPlayer.UserId
    module2.uid = tostring(userId)
    module2.feature = "inspectAndBuy"
    module2.inspecteeUid = inspecteeUid
    module2.ctx = ctx
    if not FFlagAXEnableInspectAndBuyVersionAnalytics then
        version = nil
    end

    module2.version = version

    function module2.reportOpenInspectMenu()
        module2:report("inspectUser", {})
    end

    function module2.reportTryOnButtonClicked(itemType, itemId)
        module2:report("tryItem", { itemType = itemType, itemID = itemId })
    end

    function module2.reportFavoriteItem(itemType, itemId, favorite, success, failureReason, favoriteCount)
        module2:report("favoriteItem", {
            itemType = itemType,
            itemID = itemId,
            favorite = favorite,
            success = success,
            failureReason = failureReason,
            favoriteCount = favoriteCount
        })
    end
    function module2.reportPurchaseAttempt(itemType, itemId)
        module2:report("purchaseAttemptItem", { itemType = itemType, itemID = itemId })
    end

    function module2.reportPurchaseAttemptUnifiedEvent(itemType, itemId, tbl1)
        module2:reportUnifiedEvent({
            action = UnifiedEventLogEnums.MarketplaceUnifiedAction.PURCHASE_ATTEMPT,
            itemId = if FFlagAXUnifiedEventStrictPayloads and itemId ~= nil then tostring(itemId) else itemId,
            itemType = if FFlagAXUnifiedEventStrictPayloads then getMarketplaceUnifiedItemType(itemType) else itemType,
            organicTimedOption = if tbl1.timedOptionDays == nil then nil else TIMED_OPTION_BY_DAYS[tbl1.timedOptionDays],
            assetType = if itemType ~= ItemTypeEnum.Asset then nil elseif FFlagAXUnifiedEventStrictPayloads then getMarketplaceUnifiedAssetType(tbl1.itemSubType) else tbl1.itemSubType,
            bundleType = if itemType ~= ItemTypeEnum.Bundle then nil elseif FFlagAXUnifiedEventStrictPayloads then getMarketplaceUnifiedBundleType(tbl1.itemSubType) else tbl1.itemSubType,
            organicItemPrice = tbl1.price or 0
        })

        module2:report("purchaseAttemptItem", { itemType = itemType, itemID = itemId })
    end

    function module2.reportPurchaseSuccessUnifiedEvent(itemType, itemId, tbl1)
        module2:reportUnifiedEvent({
            action = UnifiedEventLogEnums.MarketplaceUnifiedAction.PURCHASE_SUCCESS,
            itemId = if FFlagAXUnifiedEventStrictPayloads and itemId ~= nil then tostring(itemId) else itemId,
            itemType = if FFlagAXUnifiedEventStrictPayloads then getMarketplaceUnifiedItemType(itemType) else itemType,
            organicTimedOption = if tbl1.timedOptionDays == nil then nil else TIMED_OPTION_BY_DAYS[tbl1.timedOptionDays],
            assetType = if itemType ~= ItemTypeEnum.Asset then nil elseif FFlagAXUnifiedEventStrictPayloads then getMarketplaceUnifiedAssetType(tbl1.itemSubType) else tbl1.itemSubType,
            bundleType = if itemType ~= ItemTypeEnum.Bundle then nil elseif FFlagAXUnifiedEventStrictPayloads then getMarketplaceUnifiedBundleType(tbl1.itemSubType) else tbl1.itemSubType,
            organicItemPrice = tbl1.price or 0
        })

        module2:report("purchaseSuccessItem", { itemType = itemType, itemID = itemId })
    end

    function module2.reportPurchaseSuccess(itemType, itemId)
        module2:report("purchaseSuccessItem", { itemType = itemType, itemID = itemId })
    end

    function module2.reportItemDetailPageOpened(itemType, itemId)
        module2:report("itemDetailView", { itemType = itemType, itemID = itemId })
    end

    module2.platformStr = (function() -- name: getPlatformString
        local platform = UserInputService:GetPlatform()
        local str1 = "Unknown"

        if platform == Enum.Platform.Windows then
            return "Windows"
        end

        if platform == Enum.Platform.OSX then
            return "OSX"
        end

        if platform == Enum.Platform.IOS then
            return "IOS"
        end

        if platform == Enum.Platform.Android then
            local userAgent = HttpService:GetUserAgent()
            str1 = if string.find(userAgent, "AmazonAppStore") then "Amazon" else "Android"

            if string.find(userAgent, "OculusQuest3Store") then
                return "Quest"
            end
        else
            if platform == Enum.Platform.XBoxOne or platform == Enum.Platform.XBox360 then
                return "XBox"
            end

            if platform == Enum.Platform.UWP then
                return "UWP"
            end

            if platform == Enum.Platform.PS4 or platform == Enum.Platform.PS3 or platform == Enum.Platform.PS5 then
                str1 = "PlayStation"
            end
        end

        return str1
    end)()

    function module2.sendCounter(arg1)
        if RunService:IsStudio() then
            return
        end
        local counterName = "inspectAndBuy" .. "_" .. module2.platformStr .. "_" .. arg1

        RbxAnalyticsService:ReportCounter(counterName)
    end

    return module2
end

function module:report(arg1, arg2)
    local tbl1 = {
        pid = self.pid,
        uid = self.uid,
        inspecteeUid = self.inspecteeUid,
        feature = "inspectAndBuy",
        event_sender_api = 2,
        inspectAndBuyVersion = if FFlagAXEnableInspectAndBuyVersionAnalytics then self.version else nil
    }

    local var1 = Cryo.Dictionary.join(tbl1, arg2)
    self.eventStream:sendTelemetryEvent(self.ctx, arg1, var1)
end

function module:reportUnifiedEvent(arg1)
    local tbl1 = {
        surface = UnifiedLoggingSurface.IN_EXPERIENCE_INSPECT_BUY
    }

    local var1 = Cryo.Dictionary.join(tbl1, arg1)

    if FFlagAXUnifiedEventCounters then
        UnifiedEventCounterAggregator.record(var1, AXUnifiedEventFilter.filter(var1, { skipReporting = true }))
    end

    self.eventStream:sendTelemetryEvent(self.ctx, UnifiedEventLogConstants.EVENT_NAME, var1)
end

return module
