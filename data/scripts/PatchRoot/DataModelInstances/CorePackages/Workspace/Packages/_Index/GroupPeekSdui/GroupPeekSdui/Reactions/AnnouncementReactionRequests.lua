-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T23:49:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GroupPeekSdui = script:FindFirstAncestor("GroupPeekSdui")
local GroupPeekSduiParent = GroupPeekSdui.Parent

local HttpClient = require(GroupPeekSduiParent.HttpClient)

local getAnnouncementReactionUrl = require(GroupPeekSdui.Reactions.getAnnouncementReactionUrl)

local function requestAnnouncementReaction(arg1, method: string, network)
    return HttpClient.asPromise(
        HttpClient.fetch({
            method = method,
            url = getAnnouncementReactionUrl(arg1),
            body = {},
            analyticsKey = "groups.announcement-reaction." .. string.lower(method),
            network = network,
            retry = false,
            decode = function(_)
                return nil
            end
        })
    )
end
return {
    addAnnouncementReaction = function(arg1, network)
        return requestAnnouncementReaction(arg1, "POST", network)
    end,
    removeAnnouncementReaction = function(arg1, network)
        return requestAnnouncementReaction(arg1, "DELETE", network)
    end
}
