-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T14:01:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameDetailRoduxParent = script:FindFirstAncestor("GameDetailRodux").Parent

local DateTime = require(GameDetailRoduxParent.Time).DateTime

local getZendeskUrl = require(GameDetailRoduxParent.DiscoveryUtils).getZendeskUrl
local FFlagLuaAppEdpNonSduiBuildAttribution = require(GameDetailRoduxParent.SharedFlags).FFlagLuaAppEdpNonSduiBuildAttribution

local module = {}

function module.new()
    return {}
end

function module.mock(id, name, maxPlayers)
    local module2 = module.new()

    local dateTime = DateTime.new()
    local unixTimestamp = DateTime.fromUnixTimestamp(dateTime:GetUnixTimestamp() + 60)

    module2.id = id
    module2.rootPlaceId = "370731277"
    module2.name = name
    module2.description = "This is MeepCity"
    module2.creator = {
        id = 123247,
        name = "alexnewtron",
        type = "User",
        isRNVAccount = false,
        hasVerifiedBadge = false
    }

    module2.price = nil
    module2.isExperimental = false
    module2.allowedGearGenres = { "TownAndCity" }
    module2.allowedGearCategories = {}
    module2.playing = 49252
    module2.visits = 2358954901
    module2.maxPlayers = maxPlayers or 110
    module2.created = dateTime:GetIsoDate()
    module2.updated = unixTimestamp:GetIsoDate()
    module2.studioAccessToApisAllowed = true
    module2.universeAvatarType = "MorphToR15"
    module2.genre = "Town and City"
    module2.genre_l1 = "Test Genre"
    module2.genre_l2 = "Test Subgenre"
    return module2
end

function module.fromJsonData(arg1)
    local module2 = module.new()

    module2.id = tostring(arg1.id)
    module2.rootPlaceId = tostring(arg1.rootPlaceId)
    module2.name = arg1.name
    module2.description = arg1.description
    module2.creator = {
        id = arg1.creator.id,
        name = arg1.creator.name,
        type = arg1.creator.type,
        isRNVAccount = arg1.creator.isRNVAccount,
        hasVerifiedBadge = arg1.creator.hasVerifiedBadge
    }
    module2.price = arg1.price
    module2.isExperimental = arg1.isExperimental
    module2.allowedGearGenres = arg1.allowedGearGenres
    module2.allowedGearCategories = arg1.allowedGearCategories
    module2.playing = arg1.playing
    module2.visits = arg1.visits
    module2.maxPlayers = arg1.maxPlayers
    module2.created = arg1.created
    module2.updated = arg1.updated
    module2.studioAccessToApisAllowed = arg1.studioAccessToApisAllowed
    module2.universeAvatarType = arg1.universeAvatarType
    module2.genre = arg1.genre
    module2.genre_l1 = arg1.genre_l1
    module2.genre_l2 = arg1.genre_l2
    module2.licenseDescription = arg1.licenseDescription

    module2.localizedFiatPrice = arg1.localizedFiatPrice

    module2.refundLink = arg1.refundLink

    if arg1.refundPolicy then
        module2.refundPolicy = {
            policyText = arg1.refundPolicy.policyText,
            learnMoreUrl = getZendeskUrl(arg1.refundPolicy.learnMoreBaseUrl, arg1.refundPolicy.locale, arg1.refundPolicy.articleId)
        }
    end

    if FFlagLuaAppEdpNonSduiBuildAttribution then
        module2.creationSource = arg1.creationSource
    end

    return module2
end

return module
