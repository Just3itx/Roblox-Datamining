-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T16:30:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsMenuParent = script:FindFirstAncestor("FriendsMenu").Parent

local useUserExperiment = require(FriendsMenuParent.RoactAppExperiment).useUserExperiment

local str1 = game:DefineFastString("SortInvitesByScoreExperimentLayer", "Social.Friends")

return {
    FFlagEnableSortInvitesByScoreExperiment = game:DefineFastFlag("EnableSortInvitesByScoreExperiment", false),
    FFlagSortInvitesByScoreEnabledForAll = game:DefineFastFlag("SortInvitesByScoreEnabledForAll", false),
    useSortInvitesByScoreExperiment = function()
        return (useUserExperiment({ str1 }, function(arg1)
            return (arg1[str1] or {}).sortInvitesByScore
        end))
    end
}
