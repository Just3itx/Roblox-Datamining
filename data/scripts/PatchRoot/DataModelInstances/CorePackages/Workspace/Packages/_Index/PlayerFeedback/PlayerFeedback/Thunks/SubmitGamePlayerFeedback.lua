-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T10:01:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PlayerFeedback = script:FindFirstAncestor("PlayerFeedback")
local PlayerFeedbackParent = PlayerFeedback.Parent
local Promise = require(PlayerFeedbackParent.Promise)
local PerformFetch = require(PlayerFeedbackParent.Http).PerformFetch
local PostGamePlayerFeedback = require(PlayerFeedback.Utils.PostGamePlayerFeedback)
local FeedbackChannel = require(PlayerFeedback.Enums.FeedbackChannel)

local function fetchKeymapper(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    return "luaapp.asset-review-api.channels.reviews" .. arg1
end

local module = {}

function module.Post(arg1, str1: string, str2: string, tbl1, str3: string)
    return PerformFetch.Single(fetchKeymapper(str1), function(_)
        return PostGamePlayerFeedback(arg1, FeedbackChannel.ExperienceDiscoveryPage, str1, str2, tbl1, str3):andThen(function(arg2)
            return Promise.resolve(arg2)
        end, function(arg2)
            return Promise.reject(arg2)
        end)
    end)
end

function module.GetPostingStatus(arg1, arg2)
    return PerformFetch.GetStatus(arg1, (fetchKeymapper(arg2)))
end

return module
