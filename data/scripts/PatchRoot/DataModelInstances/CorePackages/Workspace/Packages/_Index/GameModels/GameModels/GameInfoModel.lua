-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T20:11:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameModelsParent = script:FindFirstAncestor("GameModels").Parent
local Result = require(GameModelsParent.Result)
local trim = require(GameModelsParent.LuauPolyfill).String.trim
local _DiscoveryTypes = require(GameModelsParent.DiscoveryTypes)

local FFlagEnableTopSongsSort = require(GameModelsParent.SharedFlags).FFlagEnableTopSongsSort

local module = {}

function module.new(universeId: string, placeId: string, str1: string)
    return {
        universeId = universeId,
        placeId = placeId,
        name = trim(str1)
    }
end

function module._fromSharedJson(arg1, arg2)
    arg1.ageRecommendationDisplayName = arg2.ageRecommendationDisplayName
    arg1.minimumAge = arg2.minimumAge
    arg1.contentMaturity = arg2.contentMaturity
    arg1.playerCount = arg2.playerCount
    local var1 = if arg2.primaryMediaAsset and arg2.primaryMediaAsset.wideImageAssetId then tostring(arg2.primaryMediaAsset.wideImageAssetId) else nil
    arg1.primaryWideAssetId = var1
    local var2 = if arg2.primaryMediaAsset and arg2.primaryMediaAsset.wideImageListId then tostring(arg2.primaryMediaAsset.wideImageListId) else nil
    arg1.primaryWideListId = var2

    arg1.totalDownVotes = arg2.totalDownVotes
    arg1.totalUpVotes = arg2.totalUpVotes
    arg1.defaultLayoutData = arg2.defaultLayoutData
    arg1.layoutDataBySort = arg2.layoutDataBySort
end

function module.mock()
    local module2 = module.new("149757", "10395446", "test")

    module._fromSharedJson(module2, {
        ageRecommendationDisplayName = "Ages 13+",
        minimumAge = 13,
        contentMaturity = "moderate",
        playerCount = 5,
        primaryMediaAsset = { wideImageAssetId = "12046435434" },
        totalDownVotes = 2564,
        totalUpVotes = 10970
    })

    module2.creatorId = "22915773"
    module2.creatorName = "Jaegerblox"

    module2.defaultLayoutData = {}
    module2.friendActivityTitle = "Friend Activity"
    module2.friendVisitedString = "1 Friend visited"
    module2.friendVisits = {{ userId = "1894536079" }}

    module2.layoutDataBySort = {}

    return module2
end

function module.fromGamesApi(arg1)
    if type(arg1.universeId) ~= "number" and type(arg1.universeId) ~= "string" then
        return Result.error("GameInfoModel.fromGamesApi expects universeId to be a number or a string")
    end
    if type(arg1.placeId) ~= "number" and type(arg1.placeId) ~= "string" then
        return Result.error("GameInfoModel.fromGamesApi expects placeId to be a number or a string")
    end
    if type(arg1.creatorId) ~= "number" and type(arg1.creatorId) ~= "string" then
        return Result.error("GameInfoModel.fromGamesApi expects creatorId to be a number or a string")
    end

    local module2 = module.new(tostring(arg1.universeId), tostring(arg1.placeId), arg1.name)
    module._fromSharedJson(module2, arg1)
    module2.creatorId = tostring(arg1.creatorId)
    module2.creatorName = arg1.creatorName

    return Result.success(module2)
end

function module.fromExperienceApi(arg1)
    if type(arg1.universeId) ~= "number" and type(arg1.universeId) ~= "string" then
        return Result.error("Game.fromJsonData expects universeId to be a number or a string")
    end
    if type(arg1.rootPlaceId) ~= "number" and type(arg1.rootPlaceId) ~= "string" then
        return Result.error("Game.fromJsonData expects placeId to be a number or a string")
    end

    local module2 = module.new(tostring(arg1.universeId), tostring(arg1.rootPlaceId), arg1.name)
    module._fromSharedJson(module2, arg1)

    return Result.success(module2)
end

function module.fromOmniApi(arg1)
    if type(arg1.universeId) ~= "number" and type(arg1.universeId) ~= "string" then
        return Result.error("DiscoveryGame.fromJsonData expects universeId to be a number or a string")
    end
    if type(arg1.rootPlaceId) ~= "number" and type(arg1.rootPlaceId) ~= "string" then
        return Result.error("DiscoveryGame.fromJsonData expects rootPlaceId to be a number or a string")
    end

    local module2 = module.new(tostring(arg1.universeId), tostring(arg1.rootPlaceId), arg1.name)
    module._fromSharedJson(module2, arg1)
    module2.friendActivityTitle = arg1.friendActivityTitle
    module2.friendVisitedString = arg1.friendVisitedString
    module2.friendVisits = arg1.friendVisits
    local var1 = if arg1.navigationUid then tostring(arg1.navigationUid) else nil
    module2.navigationUniverseId = var1

    return Result.success(module2)
end

function module.fromOmniAutocompleteApi(arg1)
    if type(arg1.universeId) ~= "number" and type(arg1.universeId) ~= "string" then
        return Result.error("GameInfoModel.fromOmniAutocompleteApi expects universeId to be a number or a string")
    end
    if type(arg1.rootPlaceId) ~= "number" and type(arg1.rootPlaceId) ~= "string" then
        return Result.error("GameInfoModel.fromOmniAutocompleteApi expects placeId to be a number or a string")
    end

    local module2 = module.new(tostring(arg1.universeId), tostring(arg1.rootPlaceId), arg1.name)
    module._fromSharedJson(module2, arg1)

    return Result.success(module2)
end

function module.fromSearchApi(arg1)
    if type(arg1.universeId) ~= "number" and type(arg1.universeId) ~= "string" then
        return Result.error("GameInfoModel.fromSearchApi expects universeId to be a number or a string")
    end
    if type(arg1.rootPlaceId) ~= "number" and type(arg1.rootPlaceId) ~= "string" then
        return Result.error("GameInfoModel.fromSearchApi expects rootPlaceId to be a number or a string")
    end
    if type(arg1.creatorId) ~= "number" and type(arg1.creatorId) ~= "string" then
        return Result.error("GameInfoModel.fromSearchApi expects creatorId to be a number or a string")
    end

    local module2 = module.new(tostring(arg1.universeId), tostring(arg1.rootPlaceId), arg1.name)
    module._fromSharedJson(module2, arg1)
    module2.creatorId = tostring(arg1.creatorId)
    module2.creatorName = arg1.creatorName

    return Result.success(module2)
end

if FFlagEnableTopSongsSort then
    function module.fromMusicDiscoveryApi(arg1)
        if type(arg1.universeId) ~= "number" and type(arg1.universeId) ~= "string" then
            return Result.error("GameInfoModel.fromMusicDiscoveryApi expects universeId to be a number or a string")
        end
        if type(arg1.rootPlaceId) ~= "number" and type(arg1.rootPlaceId) ~= "string" then
            return Result.error("GameInfoModel.fromMusicDiscoveryApi expects rootPlaceId to be a number or a string")
        end

        local module2 = module.new(tostring(arg1.universeId), tostring(arg1.rootPlaceId), arg1.name)
        module2.playerCount = arg1.playerCount
        module2.totalDownVotes = arg1.downVotes
        module2.totalUpVotes = arg1.upVotes

        return Result.success(module2)
    end
end

return module
