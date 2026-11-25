-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:31:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local dependencies = require(scriptParentParent.dependencies)
local useStyle = dependencies.UIBlox.Core.Style.useStyle
local _type = require(scriptParentParent.type)

local React = dependencies.React
local _Foundation = require(scriptParentParentParent.Foundation)

local tbl1 = {
    highlight = function(str1: string): string
        return "<b>" .. str1 .. "</b>"
    end
}

local function formatString(text)
    local text2 = text.text
    local styledElements = text.styledElements

    local tbl2 = {
        { Position = 0, ReferenceCount = 0, Format = "highlight" },
        {
            Position = #text.text,
            ReferenceCount = 0,
            Format = "highlight"
        }
    }

    if styledElements then
        for _, styledElement in pairs(styledElements) do
            table.insert(tbl2, { Position = styledElement.offset, ReferenceCount = 1, Format = styledElement.styledElementType })

            table.insert(tbl2, {
                Position = styledElement.offset + styledElement.length,
                ReferenceCount = -1,
                Format = styledElement.styledElementType
            })
        end
    end
    table.sort(tbl2, function(arg1, arg2): boolean
        return arg1.Position < arg2.Position
    end)

    local tbl3 = ({})
    for k in pairs(tbl1) do
        tbl3[k] = 0
    end

    local str1 = ""
    for i = 1, #tbl2 - 1 do
        local var1 = tbl2[i]
        local var2 = tbl2[i + 1]
        if var1.Format then
            local format = var1.Format
            tbl3[format] += var1.ReferenceCount
        end
        if var1.Position == var2.Position then
            continue
        end

        local var3 = text2:sub(var1.Position + 1, var2.Position)
        for k, value in pairs(tbl1) do
            if tbl3[k] > 0 then
                var3 = value(var3)
            end
        end
        str1 ..= var3
    end

    return str1
end

return function(tbl2)
    local var1 = useStyle()
    local var2 = if tbl2.Text then formatString(tbl2.Text) else ""

    return React.createElement(
        "TextLabel",
        {
            RichText = true,
            Text = var2,
            BackgroundTransparency = 1,
            TextColor3 = tbl2.TextColor3 or var1.Theme.TextDefault.Color,
            TextTransparency = tbl2.TextTransparency or var1.Theme.TextDefault.Transparency,
            Font = if tbl2.FontFace then nil else tbl2.Font or var1.Font.Body.Font,
            FontFace = tbl2.FontFace,
            AutomaticSize = tbl2.AutomaticSize,
            Size = tbl2.Size,
            TextSize = tbl2.TextSize,
            Position = tbl2.Position,
            AnchorPoint = tbl2.AnchorPoint,
            TextXAlignment = tbl2.TextXAlignment,
            TextTruncate = Enum.TextTruncate.AtEnd,
            TextWrapped = true
        },
        {
            UISizeConstraint = if tbl2.MaxSize then React.createElement("UISizeConstraint", { MaxSize = tbl2.MaxSize }) else nil
        }
    )
end
