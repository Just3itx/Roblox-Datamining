-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:41:13Z
-- Luau bytecode version: 14 | Luau type version: 3
local CorePackages = game:GetService("CorePackages")

if not require(CorePackages.Workspace.Packages.SharedFlags).FFlagPlatformLeaderboardRccEnabled then
    return
end

local PlatformLeaderboardsRcc = require(CorePackages.Workspace.Packages.PlatformLeaderboardsRcc)
local var1 = assert(PlatformLeaderboardsRcc.PlatformLeaderboardFetcher)
local var2 = assert(PlatformLeaderboardsRcc.PlatformLeaderboardConfigService)
local var3 = assert(PlatformLeaderboardsRcc.PlatformLeaderboardController)

local var4 = var2.new(var1)
var3.new(var4, var1):initialize()
