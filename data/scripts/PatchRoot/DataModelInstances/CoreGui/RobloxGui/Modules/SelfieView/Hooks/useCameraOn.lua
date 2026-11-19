-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:21:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local useTrackerMode = require(script.Parent.useTrackerMode)

local function useCameraOn(): boolean
    local var1 = useTrackerMode()
    return var1 == Enum.TrackerMode.Video or var1 == Enum.TrackerMode.AudioVideo
end

return useCameraOn
