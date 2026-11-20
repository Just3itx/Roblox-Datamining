-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:31:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local UserInputService = require(Foundation.Utility.Wrappers.Services).UserInputService

local _InputPlatform = require(Foundation.Enums.InputPlatform)
local getIconForKeyCode = require(Foundation.Utility.getIconForKeyCode)

local tbl1 = {}
for _, enumItem in Enum.KeyCode:GetEnumItems() do
    tbl1[enumItem.Name] = enumItem
end

local tbl2 = {
    RightAlt = "LeftAlt",
    RightControl = "LeftControl",
    RightMeta = "LeftMeta",
    RightShift = "LeftShift",
    RightSuper = "LeftSuper"
}

local tbl3 = {
    BackSlash = "\\",
    Backquote = "`",
    Comma = ",",
    Equals = "=",
    LeftBracket = "[",
    Minus = "-",
    PageDown = "Page Down",
    PageUp = "Page Up",
    Period = ".",
    Quote = "'",
    RightBracket = "]",
    Semicolon = ";",
    Slash = "/",
    QuotedDouble = "\"",
    Hash = "#",
    Dollar = "$",
    Percent = "%",
    Ampersand = "&",
    LeftParenthesis = "(",
    RightParenthesis = ")",
    Plus = "+",
    LessThan = "<",
    GreaterThan = ">",
    Question = "?",
    At = "@",
    Underscore = "_",
    Colon = ":",
    Pipe = "|",
    LeftCurly = "{",
    RightCurly = "}",
    Tilde = "~",
    Euro = "€",
    MouseLeftButton = "Left mouse button",
    MouseMiddleButton = "Middle mouse button",
    MouseRightButton = "Right mouse button",
    MouseWheel = "Mouse wheel",
    Thumbstick1Up = "Left stick up",
    Thumbstick1Down = "Left stick down",
    Thumbstick1Left = "Left stick left",
    Thumbstick1Right = "Left stick right",
    Thumbstick2Up = "Right stick up",
    Thumbstick2Down = "Right stick down",
    Thumbstick2Left = "Right stick left",
    Thumbstick2Right = "Right stick right"
}

local tbl4 = {
    MouseDelta = true,
    MousePosition = true,
    None = true,
    TouchPosition = true,
    TrackpadPan = true,
    TrackpadPinch = true,
    Unknown = true
}

local function isGamepadKeyCode(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    local name = arg1.Name
    return name:match("^Button") ~= nil or name:match("^DPad") ~= nil or name:match("^Thumbstick") ~= nil
end

local function normalizeModifier(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = tbl2[arg1.Name]
    return if var1 == nil then arg1 else tbl1[var1] or arg1
end

local function getStringForKeyCode(arg1): string? -- Luacid: Inlined by compiler; 1 call site recovered
    local success, result = pcall(function()
        return UserInputService:GetStringForKeyCode(arg1)
    end)

    return if success and typeof(result) == "string" and result ~= "" then result else nil
end

local function isNonDisplayable(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return tbl4[arg1.Name] == true
end

return {
    isNonDisplayable = isNonDisplayable,
    resolveKey = function(arg1, arg2)
        if isNonDisplayable(arg1) then
            return nil
        end

        local var1 = normalizeModifier(arg1)
        local icon = getIconForKeyCode(var1, arg2)
        if icon then
            return if isGamepadKeyCode(var1) then { kind = "GamepadIcon", icon = icon } else {
                kind = "Icon",
                icon = icon
            }
        end

        local text = tbl3[var1.Name]
        if text then
            return { kind = "Text", text = text }
        end

        return {
            kind = "Text",
            text = getStringForKeyCode(var1) or var1.Name
        }
    end
}
