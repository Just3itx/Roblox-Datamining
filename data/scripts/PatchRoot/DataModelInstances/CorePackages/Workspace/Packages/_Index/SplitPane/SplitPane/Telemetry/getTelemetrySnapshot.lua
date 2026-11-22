-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:31:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SplitPaneParent = script:FindFirstAncestor("SplitPane").Parent
local Display = require(SplitPaneParent.Display)
local LocalUserIdStore = require(SplitPaneParent.LocalUserIdStore).LocalUserIdStore
local SplitPaneTelemetry = require(script.Parent.SplitPaneTelemetry)

local function getTelemetrySnapshot(tbl1, arg1)
    local displayStore = Display.GetDisplayStore(arg1)
    local viewportSize = displayStore.getViewportSize(arg1)
    local platformScale = displayStore.getPlatformScale(arg1)
    local designSpaceViewportWidth = displayStore.getDesignSpaceViewportWidth(arg1)
    local currentScreenOrientation = tbl1.getCurrentScreenOrientation(arg1)
    local isLandscape = currentScreenOrientation == Enum.ScreenOrientation.LandscapeLeft
        or currentScreenOrientation == Enum.ScreenOrientation.LandscapeRight
    local var1 = if viewportSize == Vector2.new(1, 1) or currentScreenOrientation == nil then nil else Vector2.new(math.round(designSpaceViewportWidth), math.round(viewportSize.Y / platformScale))
    return {
        viewportSize = var1,
        isLandscape = isLandscape,
        view = if tbl1.getIsSplitPaneCollapsedOrNotActive(arg1) then SplitPaneTelemetry.View.Hidden else SplitPaneTelemetry.View.Shown,
        userId = LocalUserIdStore.getCurrentUserId(arg1)
    }
end

return getTelemetrySnapshot
