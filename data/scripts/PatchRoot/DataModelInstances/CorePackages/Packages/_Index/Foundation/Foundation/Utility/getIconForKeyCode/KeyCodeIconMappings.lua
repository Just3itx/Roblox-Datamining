-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:01:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local BuilderIcons = require(FoundationParent.BuilderIcons)

local InputPlatform = require(Foundation.Enums.InputPlatform)

local tbl1 = {
    ButtonA = "PsX",
    ButtonB = "PsCircle",
    ButtonX = "PsSquare",
    ButtonY = "PsTriagle",
    ButtonL1 = "PsL1",
    ButtonL2 = "PsL2",
    ButtonL3 = "PsL3",
    ButtonR1 = "PsR1",
    ButtonR2 = "PsR2",
    ButtonR3 = "PsR3",
    Thumbstick1 = "PsStickLeft",
    Thumbstick2 = "PsStickRight",
    DPadDown = "PsDpadDown",
    DPadUp = "PsDpadUp",
    DPadLeft = "PsDpadLeft",
    DPadRight = "PsDpadRight",
    ButtonDown = "PsDpadDown",
    ButtonUp = "PsDpadUp",
    ButtonLeft = "PsDpadLeft",
    ButtonRight = "PsDpadRight"
}

local function merge(tbl2, tbl3) -- Luacid: Inlined by compiler; 2 call sites recovered
    local var1 = table.clone(tbl2)
    for value, value2 in tbl3 do
        var1[value] = value2
    end
    return var1
end

local iconKeysByPlatform = {
    [InputPlatform.PS4] = merge(tbl1, { ButtonStart = "Ps4Options", ButtonSelect = "Ps4Share", ButtonBack = "Ps4Share" }),
    [InputPlatform.PS5] = merge(tbl1, { ButtonStart = "Ps5Options", ButtonSelect = "Ps5Share", ButtonBack = "Ps5Share" }),
    [InputPlatform.Xbox] = {
        ButtonA = "XboxA",
        ButtonB = "XboxB",
        ButtonX = "XboxX",
        ButtonY = "XboxY",
        ButtonL1 = "XboxLb",
        ButtonL2 = "XboxLt",
        ButtonL3 = "XboxStickLeft",
        ButtonR1 = "XboxRb",
        ButtonR2 = "XboxRt",
        ButtonR3 = "XboxStickRight",
        ButtonStart = "XboxMenu",
        ButtonSelect = "XboxView",
        ButtonBack = "XboxView",
        Thumbstick1 = "XboxStickLeftDirectional",
        Thumbstick2 = "XboxStickRightDirectional",
        DPadDown = "XboxDpadDown",
        DPadUp = "XboxDpadUp",
        DPadLeft = "XboxDpadLeft",
        DPadRight = "XboxDpadRight",
        ButtonDown = "XboxDpadDown",
        ButtonUp = "XboxDpadUp",
        ButtonLeft = "XboxDpadLeft",
        ButtonRight = "XboxDpadRight"
    },
    [InputPlatform.Default] = {
        Backspace = "KeyBackspace",
        CapsLock = "KeyCapsLock",
        Escape = "SquareTextEsc",
        Return = "KeyReturn",
        KeypadEnter = "KeyReturn",
        Space = "KeySpace",
        Tab = "KeyTab",
        Down = "KeyArrowDown",
        Left = "KeyArrowLeft",
        Right = "KeyArrowRight",
        Up = "KeyArrowUp",
        LeftAlt = "KeyAlt",
        RightAlt = "KeyAlt",
        LeftControl = "KeyControl",
        RightControl = "KeyControl",
        LeftMeta = "KeyCommand",
        RightMeta = "KeyCommand",
        LeftSuper = "KeyCommand",
        RightSuper = "KeyCommand",
        LeftShift = "KeyShift",
        RightShift = "KeyShift",
        Asterisk = "KeyAsterisk",
        KeypadMultiply = "KeyAsterisk",
        Backquote = "KeyGraveAccent",
        Caret = "KeyCaret",
        Comma = "KeyComma",
        Period = "KeyPeriod",
        KeypadPeriod = "KeyPeriod",
        Quote = "KeyApostrophe",
        MouseLeftButton = "MouseButtonLeft",
        MouseMiddleButton = "MouseButtonCenter",
        MouseRightButton = "MouseButtonRight",
        MouseWheel = "MouseScrollwheel"
    }
}

local function resolveIconAsset(str1: string): string? -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = BuilderIcons.Icon[str1]
    return if typeof(var1) == "string" and var1 ~= "" then var1 else nil
end

local tbl3 = ({})
for value, value2 in iconKeysByPlatform do
    local tbl4 = ({})
    for value3, value4 in value2 do
        local var1 = resolveIconAsset(value4)

        if var1 then
            tbl4[value3] = var1
        end
    end
    tbl3[value] = tbl4
end

local function getFallbackPlatform(default: string) -- Luacid: Inlined by compiler; 1 call site recovered
    return if default == InputPlatform.Default then InputPlatform.Xbox else InputPlatform.Default
end

return {
    getIconForKeyName = function(str1: string, default: string)
        return tbl3[default][str1] or tbl3[getFallbackPlatform(default)][str1]
    end,
    iconKeysByPlatform = iconKeysByPlatform
}
