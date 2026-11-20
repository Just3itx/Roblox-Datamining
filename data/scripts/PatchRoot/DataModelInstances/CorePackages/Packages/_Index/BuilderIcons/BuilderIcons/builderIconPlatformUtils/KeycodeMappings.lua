-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T02:31:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Platform = require(script.Parent.Platform)
local Icon = require(script.Parent.Parent.Icon)

local function merge(tbl1, tbl2) -- Luacid: unused: defined but never referenced
    for value, value2 in tbl2 do
        tbl1[value] = value2
    end
    return tbl1
end

local tbl1 = {
    ButtonA = Icon.PsX,
    ButtonB = Icon.PsCircle,
    ButtonX = Icon.PsSquare,
    ButtonY = Icon.PsTriagle,
    ButtonL1 = Icon.PsL1,
    ButtonL2 = Icon.PsL2,
    ButtonL3 = Icon.PsL3,
    ButtonR1 = Icon.PsR1,
    ButtonR2 = Icon.PsR2,
    ButtonR3 = Icon.PsR3,
    Thumbstick1 = Icon.PsStickLeft,
    Thumbstick2 = Icon.PsStickRight,
    DPadDown = Icon.PsDpadDown,
    DPadUp = Icon.PsDpadUp,
    DPadLeft = Icon.PsDpadLeft,
    DPadRight = Icon.PsDpadRight
}

local tbl2 = {}
local PS4 = Platform.PS4

for value, value2 in {
    ButtonStart = Icon.Ps4Options,
    ButtonSelect = Icon.Ps4Share
} do
    tbl1[value] = value2
end

tbl2[PS4] = tbl1

local PS5 = Platform.PS5

for value, value2 in {
    ButtonStart = Icon.Ps5Options,
    ButtonSelect = Icon.Ps5Share
} do
    tbl1[value] = value2
end

tbl2[PS5] = tbl1

tbl2[Platform.Xbox] = {
    ButtonA = Icon.XboxA,
    ButtonB = Icon.XboxB,
    ButtonX = Icon.XboxX,
    ButtonY = Icon.XboxY,
    ButtonL1 = Icon.XboxLb,
    ButtonL2 = Icon.XboxLt,
    ButtonL3 = Icon.XboxStickLeft,
    ButtonR1 = Icon.XboxRb,
    ButtonR2 = Icon.XboxRt,
    ButtonR3 = Icon.XboxStickRight,
    ButtonStart = Icon.XboxMenu,
    ButtonSelect = Icon.XboxView,
    Thumbstick1 = Icon.XboxStickLeftDirectional,
    Thumbstick2 = Icon.XboxStickRightDirectional,
    DPadDown = Icon.XboxDpadDown,
    DPadUp = Icon.XboxDpadUp,
    DPadLeft = Icon.XboxDpadLeft,
    DPadRight = Icon.XboxDpadRight
}
tbl2[Platform.Default] = {
    LeftAlt = Icon.KeyAlt,
    RightAlt = Icon.KeyAlt,
    Down = Icon.KeyArrowDown,
    Up = Icon.KeyArrowUp,
    Left = Icon.KeyArrowLeft,
    Right = Icon.KeyArrowRight,
    Asterisk = Icon.KeyAsterisk,
    Backspace = Icon.KeyBackspace,
    CapsLock = Icon.KeyCapsLock,
    Caret = Icon.KeyCaret,
    Comma = Icon.KeyComma,
    LeftControl = Icon.KeyControl,
    RightControl = Icon.KeyControl,
    Backquote = Icon.KeyGraveAccent,
    Period = Icon.KeyPeriod,
    Return = Icon.KeyReturn,
    LeftShift = Icon.KeyShift,
    RightShift = Icon.KeyShift,
    Space = Icon.KeySpace,
    Tab = Icon.KeyTab,
    Thumbstick1Down = Icon.GenericStickLDown,
    Thumbstick1Left = Icon.GenericStickLLeft,
    Thumbstick1Right = Icon.GenericStickLRight,
    Thumbstick1Up = Icon.GenericStickLUp,
    Thumbstick2Down = Icon.GenericStickRDown,
    Thumbstick2Left = Icon.GenericStickRLeft,
    Thumbstick2Right = Icon.GenericStickRRight,
    Thumbstick2Up = Icon.GenericStickRUp
}
return tbl2
