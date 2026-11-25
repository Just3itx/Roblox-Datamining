-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:41:02Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParentParent = script.Parent.Parent
local SharedFlags = require(scriptParentParent.SharedFlags)

local GetFIntMaquettesAppPanelDistanceMultiplierPercentage = SharedFlags.GetFIntMaquettesAppPanelDistanceMultiplierPercentage
local num1 = if SharedFlags.GetFFlagEnableVRChartsTab() then 1 else 0.8

local var1 = GetFIntMaquettesAppPanelDistanceMultiplierPercentage() / 100

return {
    MainScreenResolution = Vector2.new(1120, 900),
    MainScreenSize = Vector2.new(3.15, 2.7) * var1,
    MainScreenCurvature = 0,
    MainScreenPosition = Vector3.new(0, 4.8, -4 * var1),
    AppSystemBarPosition = Vector3.new(-2.35 * var1 * 0.7 + -0.4, 4.8, -3.15 * var1 + -1.28),
    AppSystemBarSize = Vector2.new(0.495, num1 * 2.7) * var1,
    AppSystemBarResolution = Vector2.new(64, num1 * 360),
    CentralOverlayPosition = Vector3.new(0, 4.8, -3.5 * var1),
    ToastSize = Vector2.new(2.5, 1.5),
    ToastPosition = Vector3.new(0, 3.3, -2.8),
    ToastResolution = Vector2.new(650, 382),
    ToastCurvature = 50,
    DefaultCameraPosition = Vector3.new(0, 4.8, 0),
    FTUX = { UniverseId = "4510252459", PlaceId = "12887241816" },
    ROUNDED_CORNER_RADIUS = 15,
    PositionLockedPanelName = "PositionLocked"
}
