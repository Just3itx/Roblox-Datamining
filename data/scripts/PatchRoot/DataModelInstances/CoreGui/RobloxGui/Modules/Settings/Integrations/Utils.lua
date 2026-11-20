-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:10:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local RobloxAppEnums = require(CorePackages.Workspace.Packages.RobloxAppEnums)
local AppCommonLib = require(CorePackages.Workspace.Packages.AppCommonLib)

local DeviceOrientationMode = RobloxAppEnums.DeviceOrientationMode

local function getViewportSize(): Vector2 -- Luacid: Inlined by compiler; 2 call sites recovered
    return workspace.CurrentCamera.ViewportSize
end

local function getDeviceOrientation() -- Luacid: Inlined by compiler; 1 call site recovered
    local vector2 = getViewportSize()

    return if vector2.X > vector2.Y then DeviceOrientationMode.Landscape else DeviceOrientationMode.Portrait
end

return {
    getDeviceType = function()
        return AppCommonLib.getDeviceType((getDeviceOrientation()))
    end,
    DeviceTypes = RobloxAppEnums.DeviceType,
    getDeviceOrientation = getDeviceOrientation,
    getViewportSize = getViewportSize
}
