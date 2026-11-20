-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T21:11:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent

local Url = require(scriptParentParent.Http).Url

local translate = require(scriptParent.translate)

local tbl1 = {
    PersonalizedRecommendations = "personalized-recommendations",
    AccountDataDeactivationAndDeletion = "privacy/AccountDataDeactivationAndDeletion"
}

local tbl2 = {
    PersonalizedRecommendations = "Feature.AccountSettings.Heading.Tab.PersonalizedRecommendations",
    AccountDataDeactivationAndDeletion = "Feature.AccountSettings.Heading.Tab.Privacy"
}

return {
    PersonalizedRecommendations = "PersonalizedRecommendations",
    AccountDataDeactivationAndDeletion = "AccountDataDeactivationAndDeletion",
    getUrl = function(str1: string): string
        return `{Url.WWW_URL}my/account#!/{tbl1[str1]}`
    end,
    getTitle = function(str1: string)
        return translate(tbl2[str1])
    end
}
