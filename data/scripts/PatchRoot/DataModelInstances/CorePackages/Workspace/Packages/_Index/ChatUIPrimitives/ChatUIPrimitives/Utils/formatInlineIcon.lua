-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:50:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitives = script:FindFirstAncestor("ChatUIPrimitives")

local escapeRichText = require(ChatUIPrimitives.Utils.escapeRichText)

local function formatInlineIcon(str1: string, tbl1): string
    local tbl2 = { "family" }
    local tbl3 = {
        family = "rbxasset://LuaPackages/Packages/_Index/BuilderIcons/BuilderIcons/BuilderIcons.json"
    }
    if tbl1 ~= nil then
        for value, value2 in tbl1 do
            if value == "family" then
                continue
            end

            if tbl3[value] == nil then
                table.insert(tbl2, value)
            end
            tbl3[value] = value2
        end
    end

    table.sort(tbl2)

    local var1 = table.create(#tbl2)
    for value, value2 in tbl2 do
        var1[value] = `{escapeRichText(value2)}='{escapeRichText(tbl3[value2])}'`
    end

    return `<font {table.concat(var1, " ")}>{escapeRichText(str1)}</font>`
end

return formatInlineIcon
