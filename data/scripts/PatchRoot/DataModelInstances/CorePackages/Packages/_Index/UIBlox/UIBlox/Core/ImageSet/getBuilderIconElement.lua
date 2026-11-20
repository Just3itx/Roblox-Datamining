-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:21:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParentParentParent = scriptParent.Parent.Parent.Parent
local Roact = require(scriptParentParentParentParent.Roact)
local _React = require(scriptParentParentParentParent.React)
local BuilderIcons = require(scriptParentParentParentParent.BuilderIcons)
local migrationSizeExceptions = require(scriptParent.migrationSizeExceptions)

local tbl1 = { ImageLabel = "TextLabel", ImageButton = "TextButton" }

local tbl2 = {
    ["icons/common/goldrobux"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0.97, 0.93, 0.72)), ColorSequenceKeypoint.new(0.6, Color3.new(0.67, 0.58, 0.36)), ColorSequenceKeypoint.new(1, Color3.new(0.99, 0.88, 0.64)) }),
    ["icons/common/goldrobux_small"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0.78, 0.71, 0.43)), ColorSequenceKeypoint.new(0.5, Color3.new(0.65, 0.55, 0.32)), ColorSequenceKeypoint.new(1, Color3.new(0.83, 0.71, 0.44)) })
}

local function func2(uDim2: UDim2): UDim2 | UDim2
    local bool1 = not (uDim2 and (uDim2.X.Offset == 0 or uDim2.Y.Scale == 0)) or not (uDim2.Y.Offset == 0) and uDim2.X.Scale ~= 0

    if bool1 or uDim2.X.Offset == uDim2.Y.Offset and uDim2.X.Scale == uDim2.Y.Scale or uDim2.X.Offset == 0 then
        return uDim2
    end

    local num1 = math.min(uDim2.X.Offset, uDim2.Y.Offset)
    return UDim2.fromOffset(num1, num1)
end

local function func3(uDim2: UDim2): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    local bool1 = not (uDim2 and (uDim2.X.Offset == 0 or uDim2.Y.Scale == 0)) or not (uDim2.Y.Offset == 0) and uDim2.X.Scale ~= 0

    if not bool1 and uDim2.X.Offset == 0 then
        bool1 = true
    end

    return bool1
end

local function func4(uDim2: UDim2, bool1: boolean, arg1, arg2, num1: number) -- Luacid: Inlined by compiler; 2 call sites recovered
    local offset = uDim2.Y.Offset
    if offset ~= 0 and not (bool1 or migrationSizeExceptions[arg2.name]) then
        local size100 = arg1.Size.Size_100
        local size600 = arg1.Size.Size_600
        local num2 = num1 * 38

        if size600 <= offset and offset <= num2 then
            return size600
        end
        offset = math.round(offset / size100) * size100
    end

    return offset
end

local function getBuilderIconElement(arg1, str1: string, arg2, str2: string, arg3, num1: number, num2: number?)
    assert(arg1.ImageRectOffset == nil and arg1.ImageRectSize == nil, "ImageRect props not supported for migration icons")

    assert(arg1.SliceCenter == nil and arg1.SliceScale == nil, "Image slices not supported for migration icons")

    local var1 = table.clone(arg1)
    if typeof(var1.Size) == "table" then
        local size = var1.Size
        var1.Size = size:map(func2)
        var1.TextScaled = size:map(func3)
        var1.TextSize = size:map(function(uDim2)
            local bool1 = func3(uDim2)
            local var2 = arg3
            local var3 = arg2
            local num3 = num2 or 1
            local var4 = func4(uDim2, true, nil, nil, nil)
            if var4 ~= 0 and not (bool1 or migrationSizeExceptions[var3.name]) then
                local size100 = var2.Size.Size_100
                local size600 = var2.Size.Size_600
                local num4 = num3 * 38

                if size600 <= var4 and var4 <= num4 then
                    return size600
                end
                var4 = math.round(var4 / size100) * size100
            end

            return var4
        end)
    else
        local size = var1.Size
        var1.Size = func2(size)
        local textScaled = func3(size)
        var1.TextScaled = textScaled
        local num3 = num2 or 1
        local var2 = func4(size, true, nil, nil, nil)
        local size600

        if var2 == 0 or textScaled or migrationSizeExceptions[arg2.name] then
            size600 = var2
        else
            local size100 = arg3.Size.Size_100
            size600 = arg3.Size.Size_600
            local num4 = num3 * 38

            if not (size600 <= var2 and var2 <= num4) then
                size600 = math.round(var2 / size100) * size100
            end
        end

        var1.TextSize = size600
    end

    var1.Text = arg2.name
    var1.FontFace = BuilderIcons.Font[arg2.variant]

    var1.TextColor3 = var1.ImageColor3 or arg3.Color.Content.Emphasis.Color3
    var1.TextTransparency = var1.ImageTransparency or arg3.Color.Content.Emphasis.Transparency

    var1.ImageColor3 = nil
    var1.ImageTransparency = nil
    var1.ResampleMode = nil
    var1.ScaleType = nil
    var1.TileSize = nil
    var1.Image = nil

    local var2 = tbl1[str1]

    if var2 == nil then
        error("Unsupported inner component for image set icon migration: " .. str1)
    end

    local var3 = nil
    if num1 > 0 then
        var3 = var3 == nil and {} or var3

        var3.UITextSizeConstraint = Roact.createElement("UITextSizeConstraint", { MaxTextSize = var1.TextSize })
    end

    local var4 = tbl2[str2]
    if var4 then
        var3 = var3 == nil and {} or var3

        var1.TextColor3 = Color3.new(1, 1, 1)
        var3.UIGradient = Roact.createElement("UIGradient", { Color = var4, Rotation = 90 })
    end

    if var3 == nil then
        return Roact.createElement(var2, var1)
    end

    var3.Children = Roact.createFragment(arg1[Roact.Children])
    return Roact.createElement(var2, var1, var3)
end

return getBuilderIconElement
