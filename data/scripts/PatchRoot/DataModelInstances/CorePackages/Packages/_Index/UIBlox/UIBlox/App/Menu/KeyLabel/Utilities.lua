-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:41:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local _Types = require(scriptParent.Types)
local Constants = require(scriptParent.Constants)
local _Fonts = require(scriptParentParentParent.Style.Fonts)
local Images = require(scriptParentParentParent.ImageSet.Images)
local GetTextSize = require(scriptParentParentParentParent.Core.Text.GetTextSize)
local GetFontFromFontStyle = require(scriptParentParentParentParent.Core.Text.GetFontFromFontStyle)
local platformIconMap = require(scriptParentParent.platformIconMap)

local UserInputService = game:GetService("UserInputService")

local DIRECTIONAL_GAMEPAD_ICONS = platformIconMap.DIRECTIONAL_GAMEPAD_ICONS

local GAMEPAD_ICONS = platformIconMap.GAMEPAD_ICONS

local tbl1 = {
    [Enum.KeyCode.Escape] = "Esc",
    [Enum.KeyCode.Print] = "Prt Sc",
    [Enum.KeyCode.ScrollLock] = "Sc Lock",
    [Enum.KeyCode.Pause] = "Pause",
    [Enum.KeyCode.Insert] = "Ins",
    [Enum.KeyCode.PageUp] = "PgUp",
    [Enum.KeyCode.NumLock] = "Num Lock",
    [Enum.KeyCode.Delete] = "Del",
    [Enum.KeyCode.End] = "End",
    [Enum.KeyCode.PageDown] = "PgDn",
    [Enum.KeyCode.CapsLock] = "Caps",
    [Enum.KeyCode.Return] = "Enter",
    [Enum.KeyCode.LeftShift] = "Shift",
    [Enum.KeyCode.LeftControl] = "Ctrl",
    [Enum.KeyCode.LeftAlt] = "Alt",
    [Enum.KeyCode.Space] = "Space",
    [Enum.KeyCode.LeftMeta] = "Fn",
    [Enum.KeyCode.LeftSuper] = "Cmd",
    [Enum.KeyCode.Tilde] = "~",
    [Enum.KeyCode.Up] = Images["icons/controls/keys/arrowUp"],
    [Enum.KeyCode.Down] = Images["icons/controls/keys/arrowDown"],
    [Enum.KeyCode.Left] = Images["icons/controls/keys/arrowLeft"],
    [Enum.KeyCode.Right] = Images["icons/controls/keys/arrowRight"]
}

local function getKeyCodeContent(arg1)
    if type(arg1) == "table" then
        return {
            inputType = "gamepad",
            content = DIRECTIONAL_GAMEPAD_ICONS[arg1.key][arg1.axis]
        }
    end

    if GAMEPAD_ICONS[arg1] then
        return {
            inputType = "gamepad",
            content = GAMEPAD_ICONS[arg1]
        }
    end
    local stringForKeyCode = UserInputService:GetStringForKeyCode(arg1)
    local tbl2 = { inputType = "keyboard", content = 0 }

    local var1 = tbl1[arg1]

    if var1 then
        stringForKeyCode = var1
    elseif stringForKeyCode == "" then
        stringForKeyCode = arg1.Name
    end

    tbl2.content = stringForKeyCode
    return tbl2
end

local function getWidthFromContent(arg1, arg2)
    if arg1.inputType ~= "keyboard" then
        if arg1.inputType == "gamepad" then
            local var1 = if typeof(arg1.content) == "string" then Constants.DEFAULT_GAMEPAD_ICON_SIZE else arg1.content.ImageRectSize

            return var1.X * Constants.HEIGHT / var1.Y
        end
        assert(false, string.format("Unreachable: Invalid inputType value: %q", arg1.inputType))
        return
    end

    if type(arg1.content) == "string" then
        local baseSize = arg2.BaseSize

        local captionBody = arg2.CaptionBody
        local var1 = baseSize * captionBody.RelativeSize

        local fontFromFontStyle = GetFontFromFontStyle(captionBody)
        local textSizeX = GetTextSize(arg1.content, var1, fontFromFontStyle, Vector2.zero).X
        if textSizeX + 2 * Constants.MIN_SIDE_PADDING > Constants.PREFERRED_WIDTH then
            return textSizeX + 2 * Constants.SIDE_PADDING
        end
    end
    return Constants.PREFERRED_WIDTH
end

function getKeyLabelWidth(arg1, arg2)
    local keyCodeContent = getKeyCodeContent(arg1)
    return getWidthFromContent(keyCodeContent, arg2)
end

return {
    getKeyLabelWidth = getKeyLabelWidth,
    getKeyCodeContent = getKeyCodeContent,
    getWidthFromContent = getWidthFromContent
}
