-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:20:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local NotificationsCommonParent = script:FindFirstAncestor("NotificationsCommon").Parent
local scriptParentParent = script.Parent.Parent
local dependencies = require(scriptParentParent.dependencies)
local useStyle = dependencies.UIBlox.Core.Style.useStyle
local _type = require(scriptParentParent.type)
local AppCommonLibText = require(NotificationsCommonParent.AppCommonLib).Text

local React = dependencies.React
local _Foundation = require(NotificationsCommonParent.Foundation)

local bool1 = game:DefineFastFlag("EnableNotificationStyledTextUtf16Offsets", false)

local tbl1 = {
    highlight = function(str1: string): string
        return "<b>" .. str1 .. "</b>"
    end,
    warning = function(str1: string): string
        return "<b>" .. str1 .. "</b>"
    end
}

function utf8Sub(str1: string, num1: number, position: number): string
    local num2 = utf8.offset(str1, num1)
    local num3 = utf8.offset(str1, position + 1)
    if num2 == nil or num3 == nil then
        return string.sub(str1, num1, position)
    end
    return string.sub(str1, num2, num3 - 1)
end

local function utf16IndexToCodepointIndex(text: string, num1: number): number
    local num2 = 0
    local num3 = 0
    for _, value in utf8.codes(text) do
        if num1 <= num2 then
            break
        end

        num2 += if value > 65535 then 2 else 1
        num3 += 1
    end
    return num3
end

local function formatString(text)
    if not bool1 then
        local var1 = text.text .. " "
        local styledElements = text.styledElements

        local tbl2 = {
            { Position = 0, ReferenceCount = 0, Format = "highlight" },
            {
                Position = utf8.len(text.text),
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
            local var2 = tbl2[i]
            local var3 = tbl2[i + 1]
            if var2.Format then
                local format = var2.Format
                tbl3[format] += var2.ReferenceCount
            end
            if var2.Position == var3.Position then
                continue
            end

            local var4 = utf8Sub(var1, var2.Position + 1, var3.Position)
            for k, value in pairs(tbl1) do
                if tbl3[k] > 0 then
                    var4 = value(var4)
                end
            end
            str1 ..= var4
        end

        return AppCommonLibText.Trim(str1)
    end

    local text2 = text.text
    local var1 = utf8.len(text2)
    if var1 == nil then
        return text2
    end
    local styledElements = text.styledElements

    local tbl2 = {
        { Position = 0, ReferenceCount = 0, Format = "highlight" },
        { Position = var1, ReferenceCount = 0, Format = "highlight" }
    }

    if styledElements then
        for _, styledElement in pairs(styledElements) do
            table.insert(tbl2, {
                Position = utf16IndexToCodepointIndex(text2, styledElement.offset),
                ReferenceCount = 1,
                Format = styledElement.styledElementType
            })
            table.insert(tbl2, {
                Position = utf16IndexToCodepointIndex(text2, styledElement.offset + styledElement.length),
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
        local var2 = tbl2[i]
        local var3 = tbl2[i + 1]
        if var2.Format then
            local format = var2.Format
            tbl3[format] += var2.ReferenceCount
        end
        if var2.Position == var3.Position then
            continue
        end

        local var4 = utf8Sub(text2, var2.Position + 1, var3.Position)
        for k, value in pairs(tbl1) do
            if tbl3[k] > 0 then
                var4 = value(var4)
            end
        end
        str1 ..= var4
    end

    return AppCommonLibText.Trim(str1)
end

return function(tbl2)
    local var1 = useStyle()
    local var2 = if tbl2.Text then formatString(tbl2.Text) else ""

    return React.createElement("TextLabel", {
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
        TextWrapped = true,
        LayoutOrder = tbl2.LayoutOrder
    })
end
