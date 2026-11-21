-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:40:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitivesParent = script:FindFirstAncestor("ChatUIPrimitives").Parent
local _Foundation = require(ChatUIPrimitivesParent.Foundation)

local function fade(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    local var1 = (1 - (arg1.Transparency or 0)) * 0.5
    return {
        Color3 = arg1.Color3,
        Transparency = 1 - var1
    }
end

local function getBubbleTone(bool1: boolean, arg1, bool2: boolean?)
    local tbl1 = bool1 and {
        backgroundStyle = arg1.Color.System.Emphasis,
        textStyle = arg1.Color.ActionEmphasis.Foreground
    }
        or {
            backgroundStyle = arg1.Color.Shift.Shift_400,
            textStyle = arg1.Color.Content.Emphasis
        }

    if bool2 then
        return {
            backgroundStyle = fade(tbl1.backgroundStyle),
            textStyle = fade(tbl1.textStyle)
        }
    end

    return tbl1
end

return getBubbleTone
