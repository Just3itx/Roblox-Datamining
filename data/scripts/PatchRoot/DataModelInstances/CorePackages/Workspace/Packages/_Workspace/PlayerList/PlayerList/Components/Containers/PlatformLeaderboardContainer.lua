-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T03:01:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local React = require(scriptParentParentParentParent.React)
local PlatformLeaderboardsClient = require(scriptParentParentParentParent.PlatformLeaderboardsClient)
local SharedFlags = require(scriptParentParentParentParent.SharedFlags)

local PlatformLeaderboardStoreContext = require(scriptParentParentParent.Common.PlatformLeaderboardStoreContext)

local FFlagPlatformLeaderboardPersistStoreOnRemount = SharedFlags.FFlagPlatformLeaderboardPersistStoreOnRemount

local PlatformLeaderboardClientStore = PlatformLeaderboardsClient.PlatformLeaderboardClientStore

return React.memo(function(tbl1)
    local platformLeaderboardClientStore = if FFlagPlatformLeaderboardPersistStoreOnRemount and tbl1.store == nil then PlatformLeaderboardsClient.getPlatformLeaderboardClientStore() else nil

    local var1 = React.useMemo(function()
        if FFlagPlatformLeaderboardPersistStoreOnRemount or tbl1.store ~= nil or not PlatformLeaderboardClientStore then
            return nil
        end
        return PlatformLeaderboardClientStore.new()
    end, {})

    React.useEffect(function()
        return function()
            if not FFlagPlatformLeaderboardPersistStoreOnRemount and var1 then
                var1:destroy()
            end
        end
    end, { var1 })

    local value = tbl1.store or platformLeaderboardClientStore or var1
    if value == nil then
        return tbl1.children
    end
    return React.createElement(PlatformLeaderboardStoreContext.Provider, { value = value }, tbl1.children)
end)
