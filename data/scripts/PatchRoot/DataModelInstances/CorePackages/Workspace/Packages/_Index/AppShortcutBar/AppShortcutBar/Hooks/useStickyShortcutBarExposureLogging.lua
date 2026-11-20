-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T23:11:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local AppShortcutBar = script:FindFirstAncestor("AppShortcutBar")
local AppShortcutBarParent = AppShortcutBar.Parent

local React = require(AppShortcutBarParent.React)
local IXPServiceWrapper = require(AppShortcutBarParent.IxpServiceWrapper).IXPServiceWrapper
local logUnifyShortcutBarExposureLogged = require(AppShortcutBar.Telemetry.logUnifyShortcutBarExposureLogged)

local FFlagEnableStickyShortcutBarOnAllPlatforms = require(AppShortcutBarParent.SharedFlags).FFlagEnableStickyShortcutBarOnAllPlatforms

local FStringEnableStickyShortcutBarOnAllPlatformsIxpLayer = require(AppShortcutBar.Flags).FStringEnableStickyShortcutBarOnAllPlatformsIxpLayer
local FFlagUnifyShortcutBarExposureTelemetry = require(AppShortcutBar.Flags).FFlagUnifyShortcutBarExposureTelemetry

local bool1 = false

local function useStickyShortcutBarExposureLogging(bool2: boolean)
    React.useEffect(function()
        if bool1 or not bool2 then
            return
        end

        bool1 = true
        if FFlagUnifyShortcutBarExposureTelemetry then
            logUnifyShortcutBarExposureLogged(FFlagEnableStickyShortcutBarOnAllPlatforms)
        end
        IXPServiceWrapper:LogFlagLinkedUserLayerExposure(FStringEnableStickyShortcutBarOnAllPlatformsIxpLayer)
    end, { bool2 })
end

return useStickyShortcutBarExposureLogging
