-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T03:01:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserSearchParent = script:FindFirstAncestor("UserSearch").Parent

local LocalizationService = game:GetService("LocalizationService")

local Enums = require(UserSearchParent.SocialLuaAnalytics).Analytics.Enums
local Contexts = Enums.Contexts
local EventTypes = Enums.EventTypes

local EventNames = require(script.Parent.EventNames)
local BtnValues = require(script.Parent.BtnValues)

local FFlagLuaAppSearchPeopleUnifiedSchemaFields = require(UserSearchParent.SharedFlags).FFlagLuaAppSearchPeopleUnifiedSchemaFields

local function concatToString(arg1): string
    if arg1 then
        return table.concat(arg1, ",")
    end

    return ""
end

local function acceptAnyValue<T>(arg1: T): T
    return arg1
end

return {
    [EventNames.PlayerTileImpressions] = {
        context = Contexts.PlayerSearch,
        eventType = EventTypes.PlayerTileImpressions,
        formatRulesForAdditionalInfo = {
            tilePos = concatToString,
            playerId = concatToString,
            playerName = concatToString,
            rowInSort = concatToString
        }
    },
    [EventNames.NavigateToAddFriendsBtn] = {
        context = Contexts.PlayerSearch,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            btn = BtnValues.NavigateToAddFriends
        }
    },
    [EventNames.PlayerFriendRequest] = {
        context = Contexts.PlayerSearch,
        eventType = EventTypes.PlayerFriendAdd,
        formatRulesForAdditionalInfo = {
            playerId = acceptAnyValue,
            tilePos = acceptAnyValue,
            contextualInfoType = acceptAnyValue,
            rowInSort = acceptAnyValue,
            positionInRow = if FFlagLuaAppSearchPeopleUnifiedSchemaFields then acceptAnyValue else nil,
            feedRowNumber = if FFlagLuaAppSearchPeopleUnifiedSchemaFields then acceptAnyValue else nil,
            interactionUuid = if FFlagLuaAppSearchPeopleUnifiedSchemaFields then acceptAnyValue else nil,
            pageContext = if FFlagLuaAppSearchPeopleUnifiedSchemaFields then acceptAnyValue else nil
        },
        additionalInfo = {
            locale = LocalizationService.RobloxLocaleId,
            contentType = if FFlagLuaAppSearchPeopleUnifiedSchemaFields then "User" else nil,
            actionType = if FFlagLuaAppSearchPeopleUnifiedSchemaFields then "RequestFriendship" else nil
        }
    },
    [EventNames.PlayerFriendAccept] = {
        context = Contexts.PlayerSearch,
        eventType = EventTypes.PlayerFriendAccept,
        formatRulesForAdditionalInfo = {
            playerId = acceptAnyValue,
            tilePos = acceptAnyValue,
            contextualInfoType = acceptAnyValue,
            rowInSort = acceptAnyValue,
            positionInRow = if FFlagLuaAppSearchPeopleUnifiedSchemaFields then acceptAnyValue else nil,
            feedRowNumber = if FFlagLuaAppSearchPeopleUnifiedSchemaFields then acceptAnyValue else nil,
            interactionUuid = if FFlagLuaAppSearchPeopleUnifiedSchemaFields then acceptAnyValue else nil,
            pageContext = if FFlagLuaAppSearchPeopleUnifiedSchemaFields then acceptAnyValue else nil
        },
        additionalInfo = {
            locale = LocalizationService.RobloxLocaleId,
            contentType = if FFlagLuaAppSearchPeopleUnifiedSchemaFields then "User" else nil,
            actionType = if FFlagLuaAppSearchPeopleUnifiedSchemaFields then "AcceptFriendship" else nil
        }
    },
    [EventNames.PlayerTileClick] = {
        context = Contexts.PlayerSearch,
        eventType = EventTypes.PlayerTileClick,
        formatRulesForAdditionalInfo = {
            playerId = acceptAnyValue,
            tilePos = acceptAnyValue,
            contextualInfoType = acceptAnyValue,
            rowInSort = acceptAnyValue,
            positionInRow = if FFlagLuaAppSearchPeopleUnifiedSchemaFields then acceptAnyValue else nil,
            feedRowNumber = if FFlagLuaAppSearchPeopleUnifiedSchemaFields then acceptAnyValue else nil,
            interactionUuid = if FFlagLuaAppSearchPeopleUnifiedSchemaFields then acceptAnyValue else nil,
            pageContext = if FFlagLuaAppSearchPeopleUnifiedSchemaFields then acceptAnyValue else nil
        },
        additionalInfo = {
            locale = LocalizationService.RobloxLocaleId,
            contentType = if FFlagLuaAppSearchPeopleUnifiedSchemaFields then "User" else nil,
            actionType = if FFlagLuaAppSearchPeopleUnifiedSchemaFields then "OpenProfile" else nil
        }
    },
    [EventNames.UserSearchLoadingTime] = {
        context = Contexts.PlayerSearch,
        eventType = EventTypes.LoadingTime,
        formatRulesForAdditionalInfo = {
            status = acceptAnyValue,
            loadingTime = acceptAnyValue,
            loadingThreshold = acceptAnyValue,
            nextPage = acceptAnyValue
        },
        additionalInfo = {
            fetch = "userSearch",
            locale = LocalizationService.RobloxLocaleId
        }
    },
    [EventNames.UserSearchLoaded] = {
        context = Contexts.PlayerSearch,
        eventType = EventTypes.PageLoad,
        formatRulesForAdditionalInfo = { status = acceptAnyValue, nextPage = acceptAnyValue },
        additionalInfo = {
            locale = LocalizationService.RobloxLocaleId
        }
    },
    [EventNames.UserSearchBarOpen] = {
        context = Contexts.PlayerSearch,
        eventType = EventTypes.Search,
        formatRulesForAdditionalInfo = { kwd = acceptAnyValue, currentPage = acceptAnyValue },
        additionalInfo = {
            act = "open",
            locale = LocalizationService.RobloxLocaleId
        }
    },
    [EventNames.UserSearchBarCancel] = {
        context = Contexts.PlayerSearch,
        eventType = EventTypes.Search,
        formatRulesForAdditionalInfo = { kwd = acceptAnyValue, currentPage = acceptAnyValue },
        additionalInfo = {
            act = "cancel",
            locale = LocalizationService.RobloxLocaleId
        }
    },
    [EventNames.UserSearchBarSubmit] = {
        context = Contexts.PlayerSearch,
        eventType = EventTypes.Search,
        formatRulesForAdditionalInfo = { kwd = acceptAnyValue, currentPage = acceptAnyValue },
        additionalInfo = {
            act = "search",
            locale = LocalizationService.RobloxLocaleId
        }
    }
}
