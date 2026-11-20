-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:00:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local var1 = require(scriptParentParentParentParent.UIBlox.Core.Utility.GetEngineFeatureSafe)("EnablePreferredTextSizeSetting")

local tbl1 = {
    ThemeName = { Dark = "Dark", Light = "Light" },
    FontName = { Gotham = "Gotham", Classic = "Classic" },
    ComicNeueFontFamily = "rbxassetid://127896232205472",
    DeviceType = {
        Desktop = "Desktop",
        Tablet = "Tablet",
        Phone = "Phone",
        Console = "Console",
        VR = "VR",
        Unknown = "Unknown"
    },
    Layout = {
        ActionBar = { PositionOffset = 24 }
    }
}

tbl1.DefaultThemeName = tbl1.ThemeName.Light
tbl1.DefaultFontName = tbl1.FontName.Gotham
tbl1.DefaultDeviceType = tbl1.DeviceType.Desktop

tbl1.DefaultSettings = {
    preferredTransparency = 1,
    reducedMotion = false,
    preferredTextSize = if var1 then Enum.PreferredTextSize.Medium else nil,
    scale = 1
}

return tbl1
