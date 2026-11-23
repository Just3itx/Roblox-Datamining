-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T03:10:59Z
-- Luau bytecode version: 14 | Luau type version: 3
local UserSearch = script:FindFirstAncestor("UserSearch")
local UserSearchParent = UserSearch.Parent

local RoduxPresence = require(UserSearch.Rodux.RoduxPresence)
local convertActions = require(UserSearchParent.SocialReducerAdaptors).convertActions
local presenceActionAdaptor = require(UserSearchParent.SocialReducerAdaptors).presenceActionAdaptor

return convertActions(
    RoduxPresence.installReducer(),
    presenceActionAdaptor(RoduxPresence),
    {
        byUserId = {},
        byGameId = {},
        byGameInstanceId = {},
        byPlaceId = {}
    }
)
