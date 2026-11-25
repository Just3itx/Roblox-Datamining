-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T03:04:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local React = require(scriptParentParentParent.React)

local LeaderboardStoreContext = require(scriptParentParent.Common.LeaderboardStoreContext)

local function useLeaderboardStore()
    return (React.useContext(LeaderboardStoreContext))
end

return useLeaderboardStore
