-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:50:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DeviceOrientationRoduxParent = script:FindFirstAncestor("DeviceOrientationRodux").Parent
return require(DeviceOrientationRoduxParent.Rodux).makeActionCreator(script.Name, function(deviceOrientation)
    return { deviceOrientation = deviceOrientation }
end)
