-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:41:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Players = game:GetService("Players")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")

local Cryo = require(CorePackages.Packages.Cryo)

local module = {}
module.__index = module

local LocalPlayer = Players.LocalPlayer
while not LocalPlayer do
    Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
    LocalPlayer = Players.LocalPlayer
end

function module.new(localUserId: number?, tbl1)
    localUserId = localUserId or LocalPlayer.UserId

    assert(localUserId, "BlockingAnalytics must be passed the ID of the local user")

    local tbl2 = {
        _eventStreamImpl = tbl1 and tbl1.EventStream or RbxAnalyticsService,
        localUserId = localUserId
    }
    setmetatable(tbl2, module)

    return tbl2
end

function module:action(arg1, arg2, arg3)
    arg3 = Cryo.Dictionary.join(arg3 or {}, { blockerUserId = self.localUserId })

    self._eventStreamImpl:SendEventDeferred("AccountSettingsApi", arg1, arg2, arg3)
end

return module
