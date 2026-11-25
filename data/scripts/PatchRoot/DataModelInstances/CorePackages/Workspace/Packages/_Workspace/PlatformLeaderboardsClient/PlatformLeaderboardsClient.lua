-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T02:41:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local PlatformLeaderboardClientStore = if game:DefineFastFlag("PlatformLeaderboardEnabled", false) then require(script.PlatformLeaderboardClientStore) else nil
local var1 = nil

return {
    ["jest.config"] = script["jest.config"],
    PlatformLeaderboardClientStore = PlatformLeaderboardClientStore,
    getPlatformLeaderboardClientStore = function()
        if var1 == nil and PlatformLeaderboardClientStore ~= nil then
            var1 = PlatformLeaderboardClientStore.new()
        end
        return var1
    end,
    reset = function()
        if var1 ~= nil then
            var1:destroy()
            var1 = nil
        end
    end
}
