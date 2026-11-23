-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:20:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppBloxParent = script:FindFirstAncestor("AppBlox").Parent

local DeviceType = require(AppBloxParent.RobloxAppEnums).DeviceType

local tbl1 = {
    [DeviceType.Desktop] = {
        startingOffsetPosition = 500,
        thumbnailHeight = 200,
        dualPanelBreakpoint = 1280,
        headerBarBackgroundHeight = 80,
        sideMargin = 48
    },
    [DeviceType.Tablet] = {
        startingOffsetPosition = 200,
        thumbnailHeight = 150,
        dualPanelBreakpoint = math.huge,
        headerBarBackgroundHeight = 80,
        sideMargin = 48
    },
    [DeviceType.Phone] = {
        startingOffsetPosition = 250,
        thumbnailHeight = 100,
        dualPanelBreakpoint = math.huge,
        headerBarBackgroundHeight = 24,
        sideMargin = 24
    },
    [DeviceType.Console] = {
        startingOffsetPosition = 500,
        thumbnailHeight = 200,
        dualPanelBreakpoint = 1280,
        headerBarBackgroundHeight = 80,
        sideMargin = 48
    },
    [DeviceType.VR] = {
        startingOffsetPosition = 500,
        thumbnailHeight = 200,
        dualPanelBreakpoint = 1280,
        headerBarBackgroundHeight = 80,
        sideMargin = 48
    }
}

local function getPlatformConfig(arg1)
    local var1 = tbl1[arg1]
    return if var1 == nil then tbl1[DeviceType.Desktop] else var1
end

return getPlatformConfig
