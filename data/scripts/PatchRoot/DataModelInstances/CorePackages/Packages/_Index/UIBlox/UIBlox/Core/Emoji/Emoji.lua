-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:20:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParentParentParent = scriptParent.Parent.Parent.Parent

local React = require(scriptParentParentParentParent.React)
local normalizeFontFace = require(scriptParentParentParentParent.Foundation).Utility.normalizeFontFace

local Emoji = require(scriptParent.Enum.Emoji)
local constants = require(scriptParent.constants)

local function getEmojiString(emoji: string) -- Luacid: Inlined by compiler; 1 call site recovered
    if not Emoji.isEnumValue(emoji) then
        return ""
    end

    local var1 = emoji.rawValue()
    return constants[var1]
end

local function Emoji2(tbl1)
    return React.createElement(if tbl1.onActivated then "TextButton" else "TextLabel", {
        Size = UDim2.fromScale(0, 1),
        Text = getEmojiString(tbl1.emoji),
        TextColor3 = Color3.fromHex("#fff"),
        AutomaticSize = Enum.AutomaticSize.X,
        FontFace = normalizeFontFace(tbl1.textFont),
        TextSize = tbl1.textSize,
        Position = tbl1.Position,
        BackgroundTransparency = 1,
        [React.Event.Activated] = tbl1.onActivated
    })
end

return Emoji2
