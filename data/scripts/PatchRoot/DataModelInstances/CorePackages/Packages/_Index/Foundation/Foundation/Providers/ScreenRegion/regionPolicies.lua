-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T06:41:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local Foundation = script:FindFirstAncestor("Foundation")

local DisplacedBehavior = require(Foundation.Providers.ScreenRegion.DisplacedBehavior)
local RegionOrder = require(Foundation.Providers.ScreenRegion.RegionOrder)
local ScreenRegion = require(Foundation.Providers.ScreenRegion.ScreenRegion)
local ScreenRegionKind = require(Foundation.Providers.ScreenRegion.ScreenRegionKind)

return {
    [ScreenRegion.Bottom] = {
        capacity = 1,
        order = RegionOrder.Newest,
        displaced = {
            [ScreenRegionKind.FloatingBanner] = DisplacedBehavior.Suspend
        },
        sequential = true
    }
}
