-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T13:31:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PYMKCarousel = script:FindFirstAncestor("PYMKCarousel")
local dependencies = require(PYMKCarousel.dependencies)

local SocialCommon = dependencies.SocialCommon
local RoduxUsers = dependencies.RoduxUsers
local transformOmniRecommendationsToActions = require(script.Parent.transformOmniRecommendationsToActions)
local _OmniTypes = require(PYMKCarousel.Common.OmniTypes)
local ContextualInfoTypes = SocialCommon.Enums.ContextualInfoTypes

local function func1(arg1)
    local tbl1

    if arg1.contextType == ContextualInfoTypes.Contacts then
        tbl1 = {
            id = arg1.ContactId or tostring(arg1.userId),
            username = arg1.ContactName or "",
            displayName = arg1.ContactName or ""
        }
    else
        tbl1 = { id = 0, username = 0, displayName = 0 }
        local userId = arg1.userId
        tbl1.id = tostring(userId)
        tbl1.username = arg1.userName
        tbl1.displayName = arg1.displayName
    end
    return RoduxUsers.Actions.UserUpdated(tbl1)
end

return function(arg1)
    return {
        AddContentMetadata = function<T>(arg2: T): {T}
            return { arg2 }
        end,
        AddOmniRecommendations = function(arg2)
            return transformOmniRecommendationsToActions(arg2.recommendations or {}, arg1, func1)
        end
    }
end
