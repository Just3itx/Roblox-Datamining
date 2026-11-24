-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:40:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local _MomentsTypes = require(DataHydrationParent.MomentsTypes)

local REACTION_IDS = {
    feedItemId = "aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa",
    commentId = "bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb",
    secondCommentId = "cccccccc-cccc-cccc-cccc-cccccccccccc",
    otherFeedItemId = "dddddddd-dddd-dddd-dddd-dddddddddddd",
    otherCommentId = "eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee",
    nonexistentCommentId = "ffffffff-ffff-ffff-ffff-ffffffffffff",
    thumbsUpEmoteId = "ceaa4d10-c6e5-4dbe-97ef-9c2ee37f9a30",
    unknownEmoteId = "b19f82d3-774b-45a3-a9f7-729d643d126e"
}

local AUTHORS = {
    roblox = { userId = "1", username = "Roblox", displayName = "Roblox", hasVerifiedBadge = true },
    builderman = {
        userId = "156",
        username = "builderman",
        displayName = "builderman",
        hasVerifiedBadge = true
    },
    shedletsky = { userId = "261", username = "Shedletsky", displayName = "Shedletsky" },
    sceleratis = { userId = "1237666", username = "Sceleratis", displayName = "Sceleratis" },
    webGL3D = { userId = "48103520", username = "WebGL3D", displayName = "WebGL3D" },
    unavailableAvatar = { userId = "999999999999999" },
    malformedAvatar = { userId = "not-a-user-id" }
}

local function makeEnvelope(tbl3) -- Luacid: Inlined by compiler; 1 call site recovered
    local tbl4 = {
        count = 25,
        countIsCapped = false,
        creatorEnabled = true,
        viewerCanRead = true,
        viewerCanWrite = true
    }

    if tbl3 then
        for value, value2 in tbl3 do
            tbl4[value] = value2
        end
    end
    return tbl4
end

local cappedEnvelope = makeEnvelope({ count = 99, countIsCapped = true })

return {
    AUTHORS = AUTHORS,
    ERRORS = {
        TextFilterRejected = {
            errorCode = "TextFilterRejected",
            message = "text did not pass filter"
        },
        RateLimited = { errorCode = "RateLimited", message = "too many requests" },
        ViewerNotEligibleToReact = {
            errorCode = "ViewerNotEligibleToReact",
            message = "the viewer cannot react to comments"
        }
    },
    REACTION_IDS = REACTION_IDS,
    REACTIONS = {
        empty = {
            counts = {},
            userReaction = nil
        },
        selectedThumbsUp = {
            counts = {{
                emoteId = REACTION_IDS.thumbsUpEmoteId,
                count = 3
            }},
            userReaction = {
                emoteId = REACTION_IDS.thumbsUpEmoteId
            }
        },
        selectedUnknown = {
            counts = {{
                emoteId = REACTION_IDS.unknownEmoteId,
                count = 1
            }},
            userReaction = {
                emoteId = REACTION_IDS.unknownEmoteId
            }
        }
    },
    makeComment = function(tbl3)
        local tbl4 = {
            commentId = "c-1",
            feedItemId = "feed-1",
            status = "Active",
            author = AUTHORS.roblox,
            text = "This moment is fire",
            createdAt = "2026-08-12T12:00:00Z",
            isAuthoredByViewer = false
        }

        if tbl3 then
            for value, value2 in tbl3 do
                tbl4[value] = value2
            end
        end
        return tbl4
    end,
    makeEnvelope = makeEnvelope,
    cappedEnvelope = cappedEnvelope
}
