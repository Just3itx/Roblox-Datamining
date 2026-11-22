-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T18:50:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialExperienceJoinParent = script:FindFirstAncestor("SocialExperienceJoin").Parent
local SocialLuaAnalytics = require(SocialExperienceJoinParent.SocialLuaAnalytics)
local Contexts = SocialLuaAnalytics.Analytics.Enums.Contexts
local EventTypes = SocialLuaAnalytics.Analytics.Enums.EventTypes
local SubPages = SocialLuaAnalytics.Analytics.Enums.SubPages
local EventNames = require(script.Parent.EventNames)
local BtnValues = require(script.Parent.BtnValues)

local function func1<T>(arg1: T): T
    return arg1
end

local PlayerProfile = Contexts.PlayerProfile
local PeekView = SubPages.PeekView

return function(tbl1)
    local context = tbl1 and tbl1.context or PlayerProfile
    local subpage = tbl1 and tbl1.subpage or PeekView
    return {
        [EventNames.JoinExperience] = {
            context = context,
            eventType = EventTypes.JoinGameInPeopleList,
            additionalInfo = {
                btn = BtnValues.JoinExperience,
                subpage = subpage
            },
            formatRulesForAdditionalInfo = {
                placeId = func1,
                rootPlaceId = func1,
                gameInstanceId = func1,
                profileUserId = func1,
                uid = func1,
                isHomePageCarousel = func1,
                absolutePosition = func1,
                joinAttemptId = func1,
                status = func1
            }
        },
        [EventNames.PurchaseExperience] = {
            context = context,
            eventType = EventTypes.ButtonClick,
            additionalInfo = {
                btn = BtnValues.PurchaseExperience,
                subpage = subpage
            },
            formatRulesForAdditionalInfo = { profileUserId = func1, uid = func1 }
        },
        [EventNames.PurchaseExperienceAttempt] = {
            context = context,
            eventType = EventTypes.PurchaseExperienceAttempt,
            additionalInfo = { subpage = subpage },
            formatRulesForAdditionalInfo = {
                universeId = func1,
                profileUserId = func1,
                status = func1
            }
        },
        [EventNames.CancelPurchaseExperience] = {
            context = context,
            eventType = EventTypes.ButtonClick,
            additionalInfo = {
                btn = BtnValues.CancelPurchaseExperience,
                subpage = subpage
            },
            formatRulesForAdditionalInfo = { universeId = func1, profileUserId = func1 }
        },
        [EventNames.UnableToJoinViewDetails] = {
            context = context,
            eventType = EventTypes.ButtonClick,
            additionalInfo = {
                btn = BtnValues.UnableToJoinViewDetails,
                subpage = subpage
            },
            formatRulesForAdditionalInfo = { universeId = func1, profileUserId = func1 }
        },
        [EventNames.UnableToJoinCancel] = {
            context = context,
            eventType = EventTypes.ButtonClick,
            additionalInfo = {
                btn = BtnValues.UnableToJoinCancel,
                subpage = subpage
            },
            formatRulesForAdditionalInfo = { universeId = func1, profileUserId = func1 }
        }
    }
end
