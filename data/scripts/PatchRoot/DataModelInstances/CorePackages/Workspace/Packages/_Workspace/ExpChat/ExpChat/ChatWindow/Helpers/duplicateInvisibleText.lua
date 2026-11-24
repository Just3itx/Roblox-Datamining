-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:01:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local Config = require(ExpChat.Config)

return function(arg1, font, arg2)
    font = font or Config.ChatWindowFont
    arg2 = arg2 or Config.ChatWindowTextSize

    local var1 = string.gsub(arg1, "transparency=[\"']%d%.?%d*[\"']", "transparency='1.0'")

    local var2 = string.format(
        "<font transparency='1.0' family='%s' weight='%s' size='%s'><stroke transparency='1.0'>%s</stroke></font>",
        font.Family,
        string.gsub(tostring(font.Weight), "Enum.FontWeight.", ""),
        arg2,
        var1
    )

    if font.Style == Enum.FontStyle.Italic then
        var2 = "<i>" .. var2 .. "</i>"
    end

    return var2
end
