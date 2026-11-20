-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:21:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Markdown = script:FindFirstAncestor("Markdown")

local MarkdownParent = Markdown.Parent
local Dash = require(MarkdownParent.Dash)
local InlineLayout = require(MarkdownParent.InlineLayout)

local getRowContext = require(script.Parent.getRowContext)
local mergeContexts = require(Markdown.Utils.mergeContexts)
local _Types = require(Markdown.Types)

local HardBreakElement = InlineLayout.Components.InlineLayoutElements.HardBreakElement
local isInlineElement = InlineLayout.Utils.isInlineElement

local function measureUnwrappedWidth(tbl1): number
    local num1 = 0
    local num2 = 0

    for _, value in tbl1 do
        if value == HardBreakElement then
            num2 = 0
        else
            num2 += value:getWidth()
            num1 = math.max(num1, num2)
        end
    end

    return math.ceil(num1)
end

local function getStyleKey(arg1)
    return Dash.pretty({
        textStyles = arg1.textStyles,
        codeStyles = arg1.codeStyles,
        linkStyles = arg1.linkStyles,
        imageStyles = arg1.imageStyles
    }, { depth = 4 })
end

local function getContentKey(arg1)
    local text = arg1.text or ""
    local str1 = `{arg1.name}:{#text}:{text}`

    if arg1.attributes then
        str1 ..= Dash.pretty(arg1.attributes)
    end

    for _, child in arg1.children do
        str1 ..= `({getContentKey(child)})`
    end

    return str1
end

return {
    MIN_COLUMN_CONTENT_WIDTH = 80,
    createWidthCache = function()
        return {
            styleKey = "",
            cellWidths = {}
        }
    end,
    measureColumnContentWidths = function(arg1, arg2, tbl1)
        local styleKey = getStyleKey(arg2)
        local var1 = tbl1.styleKey ~= styleKey and {} or tbl1.cellWidths
        local cellWidths = ({})
        local result = ({})

        for _, child in arg1.children do
            local var2 = mergeContexts(getRowContext(child, arg2), { isInline = true })

            for k, child2 in child.children do
                local var3 = child.name .. getContentKey(child2)
                local var4 = cellWidths[var3] or var1[var3]
                if not var4 then
                    local var5 = Dash.filter(var2.processChildren(child2, var2), isInlineElement)
                    var4 = measureUnwrappedWidth(var5)
                end

                cellWidths[var3] = var4
                local var5 = result[k] or 0
                result[k] = math.max(var5, var4)
            end
        end

        tbl1.styleKey = styleKey
        tbl1.cellWidths = cellWidths

        return result
    end,
    computeColumnWidths = function(tbl1, num1: number, num2: number)
        local tbl2 = ({})
        local tbl3 = ({})
        local num3 = 0
        local num4 = 0

        for value, value2 in tbl1 do
            tbl2[value] = value2 + num2
            tbl3[value] = math.min(value2, 80) + num2
            num3 += tbl2[value]
            num4 += tbl3[value]
        end

        if num3 <= num1 then
            return tbl2
        end

        if num1 <= num4 then
            return tbl3
        end

        local var1 = (num1 - num4) / (num3 - num4)

        return Dash.map(tbl3, function(arg1, arg2): number
            return math.floor(arg1 + (tbl2[arg2] - arg1) * var1)
        end)
    end,
    fillUnmeasuredColumns = function(tbl1, num1: number)
        if num1 <= #tbl1 then
            return tbl1
        end

        local var1 = table.clone(tbl1)
        for i = #tbl1 + 1, num1 do
            var1[i] = 80
        end

        return var1
    end
}
