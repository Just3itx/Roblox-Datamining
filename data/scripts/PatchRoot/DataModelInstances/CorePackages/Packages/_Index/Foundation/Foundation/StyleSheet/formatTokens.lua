-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T10:01:25Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local colorScopeKeepPrefix = require(script.Parent.colorScopeKeepPrefix)
local _Tokens = require(Foundation.Providers.Style.Tokens)
local _Types = require(script.Parent.Rules.Types)

local function pascalToKebab(str1: string)
    str1 = str1:gsub("_", "-")

    local var1 = string.gsub(str1, "(%u)", function(arg1)
        return "-" .. arg1:lower()
    end)

    if var1:sub(1, 1) == "-" then
        var1 = var1:sub(2, #var1)
    end

    return var1
end

local function formatTokens(arg1)
    local colors = ({})
    local variants = {}
    local strokes = {}
    local gaps = {}
    local radii = {}
    local sizes = {}
    local typography = ({})
    local paddings = {}
    local margins = {}
    local gutters = {}
    local tbl11 = {
        colors = colors,
        variants = variants,
        strokes = strokes,
        gaps = gaps,
        radii = radii,
        sizes = sizes,
        typography = typography,
        paddings = paddings,
        margins = margins,
        gutters = gutters
    }

    if arg1 == nil or next(arg1) == nil then
        return tbl11
    end

    for k, value in pairs(arg1.Color) do
        if value.Background then
            variants[pascalToKebab(k)] = value
        else
            colors[k] = {}
            for value2, value3 in value do
                if colorScopeKeepPrefix[k] then
                    value2 = k .. value2
                end

                colors[k][pascalToKebab(value2)] = value3
            end
        end
    end

    for k, value in pairs(arg1.Inverse) do
        if k ~= "Content" then
            continue
        end

        for value2, value3 in value do
            if colorScopeKeepPrefix[k] then
                value2 = k .. value2
            end

            colors[k][`inverse-{pascalToKebab(value2)}`] = value3
        end
    end

    for k, size in pairs(arg1.Stroke) do
        table.insert(strokes, { name = pascalToKebab(k), size = size })
    end

    table.insert(strokes, { name = "none", size = 0 })

    table.sort(strokes, function(arg2, arg3): boolean
        return arg2.size < arg3.size
    end)

    for k, value in pairs(arg1.Gap) do
        table.insert(gaps, { name = string.lower(k), size = UDim.new(0, value) })
    end

    table.sort(gaps, function(arg2, arg3): boolean
        return arg2.size.Offset < arg3.size.Offset
    end)

    for k, value in pairs(arg1.Radius) do
        table.insert(radii, { name = string.lower(k), size = UDim.new(0, value) })
    end

    table.sort(radii, function(arg2, arg3): boolean
        return arg2.size.Offset < arg3.size.Offset
    end)

    for k, value in pairs(arg1.Size) do
        local str1 = string.split(k, "_")[2]
        table.insert(sizes, { name = pascalToKebab(str1), size = UDim.new(0, value) })
    end

    table.insert(sizes, { name = "full", size = UDim.new(1, 0) })

    table.sort(sizes, function(arg2, arg3): boolean
        return arg2.size.Offset < arg3.size.Offset
    end)

    for k, value in pairs(arg1.Typography) do
        local var1 = pascalToKebab(k)
        typography[var1] = {
            Font = value.Font,
            TextSize = value.FontSize,
            LineHeight = value.LineHeight
        }
    end

    for k, value in pairs(arg1.Padding) do
        table.insert(paddings, { name = string.lower(k), size = UDim.new(0, value) })
    end

    table.sort(paddings, function(arg2, arg3): boolean
        return arg2.size.Offset < arg3.size.Offset
    end)

    for k, value in pairs(arg1.Margin) do
        table.insert(margins, { name = string.lower(k), size = UDim.new(0, value) })
    end

    table.sort(margins, function(arg2, arg3): boolean
        return arg2.size.Offset < arg3.size.Offset
    end)

    for k, value in pairs(arg1.Gutter) do
        table.insert(gutters, { name = string.lower(k), size = UDim.new(0, value) })
    end

    table.sort(gutters, function(arg2, arg3): boolean
        return arg2.size.Offset < arg3.size.Offset
    end)

    return tbl11
end

return formatTokens
