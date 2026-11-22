-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T23:40:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent

local React = require(scriptParentParent.React)
local SignalsReact = require(scriptParentParent.SignalsReact)

local GetThemeBackgroundStore = require(scriptParent.Stores.GetThemeBackgroundStore)
local ThemeBackgroundImage = require(scriptParent.ThemeBackgroundImage)
local _ThemeBackgroundTypes = require(scriptParent.ThemeBackgroundTypes)

local function ThemeBackgroundSlice(tbl1)
    local var1 = SignalsReact.useSignalBinding(GetThemeBackgroundStore(false).getGeometry)
    local var2, var3 = React.useBinding(Vector2.zero)
    local ref = React.useCallback(function(arg1)
        if arg1 then
            var3(arg1.AbsolutePosition)
        end
    end, {})

    local var5 = React.useMemo(function()
        return React.joinBindings({ var1, var2 }):map(function(arg1): UDim2
            local var5 = arg1[1]
            local var6 = arg1[2]
            local var7 = var5.position - var6
            return UDim2.fromOffset(var7.X, var7.Y)
        end)
    end, { var1 })

    local var6 = React.useMemo(function()
        return var1:map(function(arg1): UDim2
            return UDim2.fromOffset(arg1.size.X, arg1.size.Y)
        end)
    end, { var1 })

    return React.createElement(
        "Frame",
        {
            BackgroundColor3 = tbl1.baseColor,
            BackgroundTransparency = 0,
            BorderSizePixel = 0,
            ClipsDescendants = true,
            Size = UDim2.fromScale(1, 1),
            ZIndex = -1,
            ref = ref,
            [React.Change.AbsolutePosition] = ref
        },
        {
            Image = React.createElement(ThemeBackgroundImage, { image = tbl1.image, Position = var5, Size = var6 })
        }
    )
end

return ThemeBackgroundSlice
