-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T10:21:25Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local _Types = require(Foundation.Components.Types)

local IconSize = require(Foundation.Enums.IconSize)

local Flags = require(Foundation.Utility.Flags)
local devAssert = require(Foundation.Utility.devAssert)
local useTokens = require(Foundation.Providers.Style.useTokens)

local function isNumber(arg1): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return typeof(arg1) == "number" or typeof(arg1) == "table" and typeof(arg1:getValue()) == "number"
end

local function useIconSize(arg1, bool1: boolean, bool2: boolean?)
    local var1 = useTokens()
    local tbl1

    if bool1 then
        tbl1 = {
            [IconSize.XSmall] = if bool2 then var1.Size.Size_400 else var1.Size.Size_300,
            [IconSize.Small] = if bool2 then var1.Size.Size_500 else var1.Size.Size_400,
            [IconSize.Medium] = if bool2 then var1.Size.Size_600 else var1.Size.Size_500,
            [IconSize.Large] = if bool2 then var1.Size.Size_700 else var1.Size.Size_600,
            [IconSize.XLarge] = if bool2 then var1.Size.Size_800 else var1.Size.Size_700,
            [IconSize.XXLarge] = if bool2 then var1.Size.Size_900 else var1.Size.Size_800
        }
    else
        tbl1 = {
            [IconSize.XSmall] = var1.Size.Size_200,
            [IconSize.Small] = var1.Size.Size_400,
            [IconSize.Medium] = var1.Size.Size_900,
            [IconSize.Large] = var1.Size.Size_1200,
            [IconSize.XLarge] = var1.Size.Size_2400,
            [IconSize.XXLarge] = 24 * var1.Size.Size_200
        }
    end
    local var2 = nil

    if bool1 and isNumber(arg1) then
        var2 = arg1
    elseif not isNumber(arg1) then
        var2 = tbl1[arg1]
    end

    if var2 == nil then
        if Flags.FoundationDevOnlyPropAsserts then
            devAssert(false, "Invalid icon size: " .. tostring(arg1))
            var2 = tbl1[IconSize.Medium]
        else
            error("Invalid icon size: " .. tostring(arg1))
        end
    end

    if typeof(var2) == "table" then
        return (var2:map(function(num1: number): UDim2
            return UDim2.fromOffset(num1, num1)
        end))
    end

    return UDim2.fromOffset(var2, var2)
end

return useIconSize
