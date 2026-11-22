-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T11:40:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
return {
    ["jest.config"] = script.Parent["jest.config"],
    FFlagProfileQRCodeGamepadBackFix = require(script.Parent.Flags.FFlagProfileQRCodeGamepadBackFix),
    installReducer = require(script.Parent.Rodux).installReducer,
    ProfileQRCodeEntryPoint = require(script.Parent.Components.ProfileQRCodeEntryPoint),
    RoduxKey = require(script.Parent.Common.Constants).RODUX_KEY,
    TitleKey = require(script.Parent.Common.TextKeys).Title
}
