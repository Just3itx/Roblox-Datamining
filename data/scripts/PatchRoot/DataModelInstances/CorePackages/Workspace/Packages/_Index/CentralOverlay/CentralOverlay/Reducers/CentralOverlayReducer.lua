-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T06:21:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CentralOverlay = script:FindFirstAncestor("CentralOverlay")
local SetCentralOverlay = require(CentralOverlay.Actions.SetCentralOverlay)

return function(arg1, arg2)
    return arg2.type == SetCentralOverlay.name
        and {
            OverlayType = arg2.overlayType,
            Arguments = not arg2.arguments and {} or arg2.arguments or {},
            Configs = arg2.configs and arg2.configs or {}
        }
        or arg1
        or {
            OverlayType = nil,
            Arguments = {},
            Configs = {}
        }
end
