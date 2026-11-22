-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T23:40:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent

local React = require(scriptParentParent.React)

local GetThemeBackgroundStore = require(scriptParent.Stores.GetThemeBackgroundStore)
local ThemeBackgroundFill = require(scriptParent.ThemeBackgroundFill)
local ThemeBackgroundClippedFill = require(scriptParent.ThemeBackgroundClippedFill)

local function ThemeBackgroundLayer(tbl1)
    local themeBackgroundStore = GetThemeBackgroundStore(false)
    local image = tbl1.image
    local baseColor = tbl1.baseColor

    React.useLayoutEffect(function()
        themeBackgroundStore.setThemeBackground(image and { image = image, baseColor = baseColor } or nil)
        return function()
            themeBackgroundStore.setThemeBackground(nil)
        end
    end, { themeBackgroundStore, image, baseColor })

    local onPageChanged = React.useCallback(function(arg1)
        if arg1 then
            themeBackgroundStore.setGeometry({ position = arg1.AbsolutePosition, size = arg1.AbsoluteSize })
        end
    end, { themeBackgroundStore })

    local overscan = tbl1.overscan or 0
    local clipRight = tbl1.clipRight
    return React.createElement(React.Fragment, nil, {
        ThemeBackgroundClip = if image and clipRight ~= nil then React.createElement(
            ThemeBackgroundClippedFill,
            {
                image = image,
                baseColor = baseColor,
                onPageChanged = onPageChanged,
                overscan = overscan,
                clipRight = clipRight
            }
        ) else nil,
        ThemeBackground = if image and clipRight == nil then React.createElement(ThemeBackgroundFill, {
            image = image,
            baseColor = baseColor,
            onPageChanged = onPageChanged,
            Position = UDim2.fromOffset(-overscan, -overscan),
            Size = UDim2.new(1, overscan * 2, 1, overscan * 2)
        }) else nil,
        Content = React.createElement(React.Fragment, nil, tbl1.children)
    })
end

return ThemeBackgroundLayer
