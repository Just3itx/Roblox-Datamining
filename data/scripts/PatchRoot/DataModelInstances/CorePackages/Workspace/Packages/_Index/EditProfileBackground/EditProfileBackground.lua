-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T12:30:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local DisplayBackground = require(script.Components.DisplayBackground)

return {
    EditProfileBackgroundPage = require(script.Components.EditProfileBackgroundPage),
    DisplayBackground = DisplayBackground,
    BackgroundUtils = require(script.Common.BackgroundUtils),
    AvatarModelPrefetch = require(script.Common.AvatarModelPrefetch),
    ["jest.config"] = script["jest.config"],
    installReducer = require(script.installReducer),
    Analytics = require(script.Analytics)
}
