-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T03:04:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local React = require(scriptParentParentParent.React)

local PlatformLeaderboardStoreContext = require(scriptParentParent.Common.PlatformLeaderboardStoreContext)

local function usePlatformLeaderboard()
    return (React.useContext(PlatformLeaderboardStoreContext))
end

return usePlatformLeaderboard
