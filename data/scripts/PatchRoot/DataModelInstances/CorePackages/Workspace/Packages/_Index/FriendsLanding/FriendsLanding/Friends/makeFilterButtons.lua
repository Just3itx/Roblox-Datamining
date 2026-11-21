-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T16:00:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsLanding = script:FindFirstAncestor("FriendsLanding")
local filterStates = require(FriendsLanding.Friends.filterStates)

return function(arg1, _)
    return {
        {
            text = arg1.all,
            id = filterStates.All
        },
        {
            text = arg1.online,
            id = filterStates.Online
        },
        {
            text = arg1.inExperience,
            id = filterStates.InExperience
        }
    }
end
