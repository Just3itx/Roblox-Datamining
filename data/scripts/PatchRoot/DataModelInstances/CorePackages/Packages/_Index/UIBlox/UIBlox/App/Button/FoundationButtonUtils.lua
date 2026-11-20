-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:21:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local Core = scriptParentParentParent.Core

local Foundation = require(scriptParentParentParentParent.Foundation)
local ButtonVariant = Foundation.Enums.ButtonVariant
local InputSize = Foundation.Enums.InputSize

local GetTextSize = require(Core.Text.GetTextSize)

local uiblox = require(scriptParentParentParentParent.BuilderIcons).Migration.uiblox

local ButtonType = require(scriptParent.Enum.ButtonType)
local StandardButtonSize = require(Core.Button.Enum.StandardButtonSize)

local ImagesInverse = require(scriptParentParent.ImageSet.ImagesInverse)

local buttonMapping = {
    [ButtonType.Alert] = ButtonVariant.Alert,
    [ButtonType.PrimaryContextual] = ButtonVariant.Emphasis,
    [ButtonType.PrimarySystem] = ButtonVariant.SubEmphasis,
    [ButtonType.Secondary] = ButtonVariant.Subtle
}

local sizeMapping = {
    [StandardButtonSize.Regular] = InputSize.Large,
    [StandardButtonSize.Small] = InputSize.Small,
    [StandardButtonSize.XSmall] = InputSize.XSmall
}

local tbl3 = {
    [StandardButtonSize.Regular] = false,
    [StandardButtonSize.Small] = false,
    [StandardButtonSize.XSmall] = true
}

local tbl4 = {
    [InputSize.XSmall] = { padding = "Small", typography = "Small", height = "Size_600" },
    [InputSize.Small] = { padding = "Small", typography = "Small", height = "Size_800" },
    [InputSize.Medium] = { padding = "Medium", typography = "Medium", height = "Size_1000" },
    [InputSize.Large] = { padding = "Medium", typography = "Large", height = "Size_1200" }
}

local vector2 = Vector2.new(10000, 10000)

return {
    buttonMapping = buttonMapping,
    sizeMapping = sizeMapping,
    findIcon = function(arg1)
        if not arg1 then
            return nil
        end

        local var1 = if arg1.Image and uiblox[arg1.Image] ~= nil then arg1.Image else ImagesInverse[arg1]

        if var1 == nil then
            warn("Icon not found")
        end
        return var1
    end,
    getSizeMapping = function(arg1, uDim2: UDim2?, arg2)
        if arg1 then
            return sizeMapping[arg1]
        end

        if not uDim2 then
            return nil
        end

        if uDim2.Y.Offset >= arg2.Size.Size_1200 then
            return InputSize.Large
        end

        if uDim2.Y.Scale > 0 then
            return InputSize.Medium
        end

        if uDim2.Y.Offset >= arg2.Size.Size_1000 then
            return InputSize.Medium
        end

        if uDim2.Y.Offset >= arg2.Size.Size_800 then
            return InputSize.Small
        end

        return InputSize.XSmall
    end,
    getWidth = function(str1: string?, uDim2: UDim2?, bool1: boolean?)
        if str1 then
            local var1 = tbl3[str1]
            if bool1 ~= nil then
                var1 = bool1
            end

            if var1 then
                return nil
            end

            return UDim.new(1, 0)
        elseif uDim2 then
            return uDim2.X
        elseif bool1 then
            return nil
        else
            return UDim.new(1, 0)
        end
    end,
    getMaxWidth = function(str1: string?, num1: number?): number?
        return if str1 == nil then nil elseif num1 == nil then 640 else num1
    end,
    getFitContentSize = function(str1: string, str2: string?, tbl5)
        local var1 = if str2 then sizeMapping[str2] else nil
        local var2 = if var1 then tbl4[var1] else nil

        if not var2 then
            return nil
        end

        local var3 = tbl5.Typography["Label" .. var2.typography]
        local textSizeX = GetTextSize(str1, var3.FontSize, var3.Font, vector2).X

        return Vector2.new(math.ceil(textSizeX) + tbl5.Padding[var2.padding] * 2, tbl5.Size[var2.height])
    end,
    getTestId = function(str1: string?)
        if not str1 or #str1 == 0 then
            return nil
        end

        return str1:match("data%-testid=([^%s]+)")
    end
}
