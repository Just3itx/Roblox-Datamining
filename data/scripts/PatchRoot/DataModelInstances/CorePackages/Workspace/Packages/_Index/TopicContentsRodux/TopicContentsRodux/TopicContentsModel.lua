-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T00:11:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TopicContentsRodux = script:FindFirstAncestor("TopicContentsRodux")
local TopicContentsEntryModel = require(TopicContentsRodux.TopicContentsEntryModel)

local TopicContentsRoduxParent = TopicContentsRodux.Parent
local DiscoveryTypes = require(TopicContentsRoduxParent.DiscoveryTypes)
local DiscoveryUtils = require(TopicContentsRoduxParent.DiscoveryUtils)
local OmniRecommendationsContentType = DiscoveryTypes.OmniRecommendationsContentType
local GameCollectionItemType = DiscoveryTypes.GameCollectionItemTypes.GameCollectionItemType
local DiscoveryEventErrorLogger = DiscoveryUtils.DiscoveryEventErrorLogger

local FFlagLuaAppEnableNxMRoduxApportioning = require(TopicContentsRoduxParent.SharedFlags).FFlagLuaAppEnableNxMRoduxApportioning

local FFlagLuaAppEnableOneByTwoTileFunnelTelemetry = require(TopicContentsRoduxParent.SharedFlags).FFlagLuaAppEnableOneByTwoTileFunnelTelemetry

local module = {}

function module.new()
    return {
        entries = {},
        rowsRequested = 0,
        hasMoreRows = false,
        nextPageExclusiveStartId = 0,
        updatedTimestamp = nil,
        nextPageToken = ""
    }
end

function module.mock()
    local module2 = module.new()

    module2.entries = { TopicContentsEntryModel.mock() }
    module2.rowsRequested = 1
    module2.hasMoreRows = false
    module2.nextPageExclusiveStartId = 0
    module2.updatedTimestamp = nil

    module2.nextPageToken = ""

    return module2
end

function module.fromData(arg1)
    return {
        entries = arg1.entries,
        rowsRequested = arg1.rowsRequested,
        hasMoreRows = arg1.hasMoreRows,
        nextPageExclusiveStartId = arg1.nextPageExclusiveStartId,
        updatedTimestamp = arg1.updatedTimestamp,
        nextPageToken = if arg1.nextPageToken then arg1.nextPageToken else ""
    }
end

function module.fromContentList(tbl1, arg1, arg2, updatedTimestamp: number?, str1: string?)
    local module2 = module.new()

    module2.updatedTimestamp = updatedTimestamp
    module2.entries = {}
    module2.hasMoreRows = false
    if tbl1 then
        for _, value in ipairs(tbl1) do
            if module2.hasMoreRows then
                return module2
            end

            local fromOmniRecommendations = TopicContentsEntryModel.fromOmniRecommendations
            local var1 = if FFlagLuaAppEnableOneByTwoTileFunnelTelemetry then str1 else nil

            fromOmniRecommendations(value, var1):match(function(arg3)
                if FFlagLuaAppEnableNxMRoduxApportioning
                    and arg3.componentType == GameCollectionItemType.OneByTwoTile
                    and not (arg3.primaryVideoAssetId and arg3.primaryImageAssetId)
                then
                    DiscoveryEventErrorLogger.reportError(
                        "TopicContentsModel_OneByTwoTileMissingAssets",
                        "OneByTwoTile entry dropped: missing primaryVideoAssetId or primaryImageAssetId",
                        {
                            contentType = tostring(arg3.contentType),
                            hasVideo = arg3.primaryVideoAssetId ~= nil,
                            hasImage = arg3.primaryImageAssetId ~= nil
                        }
                    )
                    return
                end

                if FFlagLuaAppEnableNxMRoduxApportioning and arg3.contentType == OmniRecommendationsContentType.AdLink then
                    if not arg3.clickoutUrl or arg3.clickoutUrl == "" then
                        DiscoveryEventErrorLogger.reportError(
                            "TopicContentsModel_AdLinkMissingClickoutUrl",
                            "AdLink entry dropped: missing clickoutUrl"
                        )
                        return
                    end

                    if arg3.universeId ~= nil then
                        DiscoveryEventErrorLogger.reportError(
                            "TopicContentsModel_AdLinkUnexpectedUniverseId",
                            "AdLink entry unexpectedly has universe ID"
                        )
                    end
                    table.insert(module2.entries, arg3)
                else
                    local contentType = value.contentType
                    local var2 = arg1(contentType)
                    if var2 ~= nil then
                        local var3 = arg2(arg3, var2)
                        if var3 ~= nil then
                            table.insert(module2.entries, var3)
                            return
                        end
                        module2.hasMoreRows = true
                    end
                end
            end):matchError(function(arg3)
                warn(arg3)
            end)
        end
    end

    return module2
end

return module
