-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T10:01:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PlayerFeedback = script:FindFirstAncestor("PlayerFeedback")
local PlayerFeedbackParent = PlayerFeedback.Parent
local Promise = require(PlayerFeedbackParent.Promise)
local PerformFetch = require(PlayerFeedbackParent.Http).PerformFetch
local GameGetPlayerFeedbackMetadata = require(PlayerFeedback.Utils.GameGetPlayerFeedbackMetadata)
local FeedbackChannel = require(PlayerFeedback.Enums.FeedbackChannel)
local VoteStatus = require(PlayerFeedbackParent.GameVotesRodux).Enums.VoteStatus
local t = require(PlayerFeedbackParent.t)
local flaggedMutedError = require(PlayerFeedbackParent.Loggers).flaggedMutedError
local _Types = require(PlayerFeedback.Types)

local function fetchKeymapper(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    return "luaapp.asset-review-api.channels" .. arg1
end

local tbl1 = {
    [VoteStatus.VotedUp] = "Upvote",
    [VoteStatus.VotedDown] = "Downvote"
}

local function findCategoryByType(categories, type) -- Luacid: Inlined by compiler; 1 call site recovered
    for _, value in ipairs(categories) do
        if value.type == type then
            return value
        end
    end
    return nil
end

local module = {}

local var1 = t.interface({
    capabilities = t.interface({ can_submit_review = t.boolean, can_submit_category_options = t.boolean, can_submit_comment = t.boolean }),
    categories = t.array(
        t.interface({
            type = t.string,
            label = t.string,
            allows_multiple_selections = t.boolean,
            options = t.array(t.interface({ id = t.string, label = t.string }))
        })
    ),
    comment = t.interface({ label = t.string, placeholder_text = t.string, minimum_length = t.number, maximum_length = t.number }),
    metadata = t.interface({ disclaimer_label = t.string, submit_button_label = t.string, form_title_label = t.string })
})

function module.Get(arg1, _: string, rootPlaceId: string, str1: string)
    return PerformFetch.Single(fetchKeymapper(rootPlaceId), function(_)
        return GameGetPlayerFeedbackMetadata(arg1, FeedbackChannel.ExperienceDiscoveryPage, rootPlaceId):andThen(function(arg2)
            local responseBody = arg2 and arg2.responseBody
            local var2, var3 = var1(responseBody)
            if not var2 then
                flaggedMutedError("PlayerFeedbackMetadata", var3)
                return Promise.reject({ HttpError = Enum.HttpError.OK })
            end

            local response = tbl1[str1]
            local category = findCategoryByType(responseBody.categories, response)
            if category == nil then
                flaggedMutedError(
                    "PlayerFeedbackMetadata",
                    string.format("Invalid category from player feedback metadata response: %s", response)
                )
                return Promise.reject({ HttpError = Enum.HttpError.OK })
            end

            local tbl2 = {
                rootPlaceId = rootPlaceId,
                canSubmitReview = responseBody.capabilities.can_submit_review,
                canSubmitComment = responseBody.capabilities.can_submit_comment,
                categoryType = response,
                category = category,
                comment = responseBody.comment,
                metadata = responseBody.metadata
            }
            return Promise.resolve(tbl2)
        end, function(arg2)
            return Promise.reject(arg2)
        end)
    end)
end

function module.GetFetchingStatus(arg1, arg2)
    return PerformFetch.GetStatus(arg1, (fetchKeymapper(arg2)))
end

return module
