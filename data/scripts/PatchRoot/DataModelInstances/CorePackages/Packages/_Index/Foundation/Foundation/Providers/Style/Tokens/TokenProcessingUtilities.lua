-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T06:50:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local Logger = require(Foundation.Utility.Logger)
local _Types = require(Foundation.Components.Types)

local function isColorStyle(arg1): boolean -- Luacid: Inlined by compiler; 4 call sites recovered
    return type(arg1) == "table"
        and arg1.Color3 ~= nil
        and typeof(arg1.Color3) == "Color3"
        and arg1.Transparency ~= nil
        and typeof(arg1.Transparency) == "number"
end

local function getRoundedNumber(num1: number): number -- Luacid: Inlined by compiler; 7 call sites recovered
    return math.round(num1 * 1000) / 1000
end

local function getRGBAValues(color3: Color3, num1: number?) -- Luacid: Inlined by compiler; 7 call sites recovered
    local num2 = math.round(color3.R * 255)
    local num3 = math.round(color3.G * 255)
    local num4 = math.round(color3.B * 255)
    if num1 then
        return num2, num3, num4, (getRoundedNumber(1 - num1))
    end
    return num2, num3, num4
end

local function collectTokens(arg1, category: string, str1: string?, bool1: boolean?)
    local result = {}

    for key, value in arg1 do
        local fullPath = if str1 then `{str1}.{key}` else key

        if type(value) ~= "table" or getmetatable(value) or bool1 and isColorStyle(value) then
            table.insert(result, { key = key, value = value, category = category, fullPath = fullPath })
        else
            for _, value3 in (collectTokens(value, category, fullPath, bool1)) do
                table.insert(result, value3)
            end
        end
    end

    return result
end

local function getTokenValue(arg1, str1: string)
    for _, value in string.split(str1, ".") do
        if arg1 == nil or type(arg1) ~= "table" then
            return nil
        end
        arg1 = arg1[value]
    end
    return arg1
end

local function tokenOverrideValuesCompatible(arg1, arg2)
    if arg1 == nil or arg2 == nil then
        return false
    end
    if type(arg1) ~= "table" or type(arg2) ~= "table" then
        return typeof(arg1) == typeof(arg2)
    end
    for value, value2 in arg1 do
        if not tokenOverrideValuesCompatible(value2, arg2[value]) then
            return false
        end
    end
    for value in arg2 do
        if arg1[value] == nil then
            return false
        end
    end
    return true
end

local function resolveTokenOverrideSource(arg1, arg2) -- Luacid: Inlined by compiler; 1 call site recovered
    if type(arg2) ~= "string" then
        return arg2
    end

    local tokenValue = getTokenValue(arg1, arg2)
    if tokenValue ~= nil then
        return tokenValue
    end

    Logger:warning(`Token override skipped: unknown source token path "{arg2}"`)
    return nil
end

return {
    isColorStyle = isColorStyle,
    formatColorPreviewHTML = function(color3: Color3, num1: number?): string
        local var1, var2, var3 = getRGBAValues(color3, false)
        local roundedNumber = if num1 then getRoundedNumber(1 - num1) else nil
        return `<span class="color-preview" style="background-color: rgba({var1},{var2},{var3},{roundedNumber or 1});"></span>`
    end,
    formatTokenValue = function(arg1): string
        if typeof(arg1) == "Color3" then
            local var1, var2, var3 = getRGBAValues(arg1, false)
            return `rgb({var1}, {var2}, {var3})`
        end

        if typeof(arg1) == "number" then
            return tostring((getRoundedNumber(arg1)))
        end

        if not isColorStyle(arg1) then
            return tostring(arg1)
        end

        local color3 = arg1.Color3
        local transparency = arg1.Transparency
        local var1, var2, var3 = getRGBAValues(color3, false)
        local roundedNumber = if transparency then getRoundedNumber(1 - transparency) else nil
        return `rgba({var1}, {var2}, {var3}, {roundedNumber})`
    end,
    formatTokenValueHTML = function(arg1): string
        if typeof(arg1) == "Color3" then
            local var1, var2, var3 = getRGBAValues(arg1, false)
            local var4, var5, var6 = getRGBAValues(arg1, false)
            return `<span class="color">{`<span class="color-preview" style="background-color: rgba({var4},{var5},{var6},{nil or 1});"></span>`} rgb({var1}, {var2}, {var3})</span>`
        end

        if typeof(arg1) == "number" then
            return tostring((getRoundedNumber(arg1)))
        end

        if not isColorStyle(arg1) then
            return tostring(arg1)
        end

        local color3 = arg1.Color3
        local transparency = arg1.Transparency
        local var1, var2, var3 = getRGBAValues(color3, false)
        local roundedNumber = if transparency then getRoundedNumber(1 - transparency) else nil
        local color3_2 = arg1.Color3
        local transparency2 = arg1.Transparency
        local var4, var5, var6 = getRGBAValues(color3_2, false)
        local roundedNumber2 = if transparency2 then getRoundedNumber(1 - transparency2) else nil
        return `<span class="color">{`<span class="color-preview" style="background-color: rgba({var4},{var5},{var6},{roundedNumber2 or 1});"></span>`} rgba({var1}, {var2}, {var3}, {roundedNumber})</span>`
    end,
    collectTokens = collectTokens,
    collectTokensWithSubcategories = function(arg1, category: string, str1: string?, bool1: boolean?)
        local result = ({})

        for key, value in arg1 do
            local fullPath = if str1 then `{str1}.{key}` else key

            if type(value) == "table" then
                if bool1 and isColorStyle(value) then
                    local str2 = if str1 then str1:split(".")[1] else "Default"
                    if not result[str2] then
                        result[str2] = {}
                    end
                    table.insert(result[str2], { key = key, value = value, category = category, fullPath = fullPath })
                elseif not str1 then
                    local tbl1 = collectTokens(value, category, key, bool1)
                    if #tbl1 > 0 then
                        result[key] = tbl1
                    end
                else
                    local tbl1 = collectTokens(value, category, fullPath, bool1)
                    local str2 = str1:split(".")[1]
                    if not result[str2] then
                        result[str2] = {}
                    end
                    for _, value3 in tbl1 do
                        table.insert(result[str2], value3)
                    end
                end
            else
                local str2 = if str1 then str1:split(".")[1] else "Default"
                if not result[str2] then
                    result[str2] = {}
                end
                table.insert(result[str2], { key = key, value = value, category = category, fullPath = fullPath })
            end
        end

        return result
    end,
    hasSubcategories = function(arg1)
        for _, value in arg1 do
            if type(value) ~= "table" then
                continue
            end
            local bool1 = false
            for _, value2 in value do
                if type(value2) == "table" or typeof(value2) == "Color3" or typeof(value2) == "number" then
                    bool1 = true
                    break
                end
            end

            if bool1 then
                return true
            end
        end

        return false
    end,
    sortTokens = function(str1: string, str2: string, bool1: boolean?): boolean
        if not (str1:find("(%u%a+)_(%d+)%.?(%u?%w*)") and str2:find("(%u%a+)_(%d+)%.?(%u?%w*)")) then
            if not bool1 then
                return str1 < str2
            end

            local var1 = str1:match("| (%-?[%d.]+) |$")
            local var2 = str2:match("| (%-?[%d.]+) |$")
            return tonumber(var1) < tonumber(var2)
        end

        local var1, var2, var3 = str1:match("(%u%a+)_(%d+)%.?(%u?%w*)")
        local var4, var5, var6 = str2:match("(%u%a+)_(%d+)%.?(%u?%w*)")

        if var1 == var4 then
            if var2 == var5 then
                return var3 < var6
            end

            return tonumber(var2) < tonumber(var5)
        end

        return str1 < str2
    end,
    orderedTokenCategories = {
        "Color",
        "Stroke",
        "Size",
        "Radius",
        "Padding",
        "Margin",
        "Gap",
        "Typography",
        "FontSize",
        "FontWeight",
        "LineHeight",
        "Ease",
        "Time",
        "Inverse",
        "DarkMode",
        "LightMode",
        "Config"
    },
    getTokenValue = getTokenValue,
    setTokenValue = function(arg1, str1: string, arg2)
        local tbl1 = string.split(str1, ".")

        for i = 1, #tbl1 - 1 do
            local str2 = tbl1[i]
            if arg1[str2] == nil then
                return
            end
            arg1 = arg1[str2]
        end

        local str2 = tbl1[#tbl1]
        if arg1 and str2 then
            arg1[str2] = arg2
        end
    end,
    resolveTokenOverride = function(arg1, str1: string, arg2)
        local var1 = resolveTokenOverrideSource(arg1, arg2)

        if var1 == nil then
            return nil
        end
        local tokenValue = getTokenValue(arg1, str1)
        if tokenValue == nil then
            Logger:warning(`Token override skipped: unknown target token path "{str1}"`)
            return nil
        end
        if tokenOverrideValuesCompatible(tokenValue, var1) then
            return var1
        end

        Logger:warning(`Token override skipped: type or shape mismatch for "{str1}"`)
        return nil
    end,
    _resolveTokenOverrideSource = resolveTokenOverrideSource
}
