-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T11:41:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TextService = game:GetService("TextService")

local module = {
    PADDING = Vector2.new(2, 2)
}

function module.GetTextBounds(string: string, font: Enum.Font, fontSize: number, frameSize: Vector2)
    return TextService:GetTextSize(string, fontSize, font, frameSize) + module.PADDING
end

function module.GetTextWidth(arg1, font, textSize)
    return module.GetTextBounds(arg1, font, textSize, Vector2.new(10000, 10000)).X
end

function module.GetTextHeight(arg1, font, fontSize, x: number?)
    return module.GetTextBounds(arg1, font, fontSize, Vector2.new(x, 10000)).Y
end

function module.Truncate(text, font, textSize, arg1, arg2)
    arg2 = arg2 or ""

    if not (arg1 < module.GetTextWidth(text, font, textSize)) then
        return text
    end

    local str1 = ""
    for _, value in utf8.graphemes(text) do
        local var1 = string.sub(text, 1, value) .. arg2
        if arg1 < module.GetTextWidth(var1, font, textSize) then
            return str1
        end

        str1 = var1
    end

    return ""
end

function module.TruncateTextLabel(arg1, arg2)
    arg1.Text = module.Truncate(arg1.Text, arg1.Font, arg1.TextSize, arg1.AbsoluteSize.X, arg2)
end

function module.Trim(arg1)
    if type(arg1) ~= "string" then
        error(string.format("Text.Trim called on non-string type %s.", type(arg1)), 2)
    end
    return (arg1:gsub("^%s*(.-)%s*$", "%1"))
end

function module.RightTrim(arg1)
    if type(arg1) ~= "string" then
        error(string.format("Text.RightTrim called on non-string type %s.", type(arg1)), 2)
    end
    return (arg1:gsub("%s+$", ""))
end

function module.LeftTrim(arg1)
    if type(arg1) ~= "string" then
        error(string.format("Text.LeftTrim called on non-string type %s.", type(arg1)), 2)
    end
    return (arg1:gsub("^%s+", ""))
end

function module.SpaceNormalize(arg1)
    if type(arg1) ~= "string" then
        error(string.format("Text.SpaceNormalize called on non-string type %s.", type(arg1)), 2)
    end
    return (arg1:gsub("%s+", " "):gsub("^%s+", ""):gsub("%s+$", ""))
end

function module.Split(arg1, arg2)
    local var1, var2

    if type(arg1) ~= "string" then
        error(string.format("Text.Split called on non-string type %s.", type(arg1)), 2)
        var1 = 1
        var2 = {}
    elseif type(arg2) ~= "string" then
        error(string.format("Text.Split called with a pattern that is non-string type %s.", type(arg2)), 2)
        var1 = 1
        var2 = {}
    elseif arg2 == "" then
        error("Text.Split called with an empty pattern.", 2)
        var1 = 1
        var2 = {}
    else
        var1 = 1
        var2 = {}
    end

    while true do
        local var3, var4 = string.find(arg1, arg2, var1, true)
        if not (var3 and var4) then
            break
        end

        table.insert(var2, string.sub(arg1, var1, var3 - 1))
        var1 = var4 + 1
    end

    table.insert(var2, string.sub(arg1, var1, string.len(arg1)))

    return var2
end

return module
