-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:51:25Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local Icon = require(script.Parent.Parent.Icon)

return {
    [Enum.Platform.PS3] = Icon.Playstation,
    [Enum.Platform.PS4] = Icon.Playstation,
    [Enum.Platform.PS5] = Icon.Playstation,
    [Enum.Platform.XBoxOne] = Icon.Xbox,
    [Enum.Platform.XBox360] = Icon.Xbox,
    [Enum.Platform.Android] = Icon.Android,
    [Enum.Platform.IOS] = Icon.Apple,
    [Enum.Platform.OSX] = Icon.Apple,
    [Enum.Platform.Windows] = Icon.Microsoft,
    [Enum.Platform.MetaOS] = Icon.Meta
}
