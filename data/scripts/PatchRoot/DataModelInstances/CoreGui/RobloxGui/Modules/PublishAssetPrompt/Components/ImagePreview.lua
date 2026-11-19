-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:11:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local React = require(CorePackages.Packages.React)
local Foundation = require(CorePackages.Packages.Foundation)

local Image = Foundation.Image
local View = Foundation.View
local useTokens = Foundation.Hooks.useTokens

local function ImagePreview(tbl1)
    local var1 = useTokens()

    local var2 = React.useMemo(function()
        return {
            {
                id = "Black",
                style = var1.Color.Extended.Black.Black_100
            },
            {
                id = "White",
                style = var1.Color.Extended.White.White_100
            },
            {
                id = "Checkerboard",
                style = var1.Color.Extended.White.White_0,
                image = "rbxassetid://6372755229"
            }
        }
    end, { var1 })

    local var3, var4 = React.useState(1)

    local var5 = React.useRef(false)
    local var6 = if tbl1.autoRotateSeconds then tbl1.autoRotateSeconds / #var2 else 0

    React.useEffect(function()
        if var6 <= 0 then
            return function() end
        end

        task.spawn(function()
            for _ = 2, #var2 do
                task.wait(var6)
                if var5.current then
                    return
                end
                var4(function(arg1): number
                    return arg1 % #var2 + 1
                end)
            end
        end)

        return function()
            var5.current = true
        end
    end, { var6, var2 })

    local backgroundStyle, var8 = React.useBinding(var2[1].style)
    local time300 = var1.Time.Time_300

    React.useEffect(function()
        local value = backgroundStyle:getValue()
        local style = var2[var3].style
        local bool1 = false

        task.spawn(function()
            local num1 = 0

            while num1 < time300 do
                num1 += task.wait()
                if bool1 then
                    return
                end
                local num2 = math.min(num1 / time300, 1)
                var8({
                    Color3 = value.Color3:Lerp(style.Color3, num2),
                    Transparency = value.Transparency + (style.Transparency - value.Transparency) * num2
                })
            end
        end)

        return function()
            bool1 = true
        end
    end, {
        var3,
        var2,
        time300,
        backgroundStyle,
        var8
    })
    local tbl2 = ({})
    for layoutOrder, value2 in var2 do
        local id = value2.id
        local createElement = React.createElement
        local var9 = View
        local tbl3 = {
            LayoutOrder = layoutOrder,
            tag = {
                ["size-350 radius-small"] = true,
                ["stroke-thick stroke-emphasis"] = layoutOrder == var3,
                ["stroke-standard stroke-default"] = layoutOrder ~= var3
            },
            backgroundStyle = value2.style,
            onActivated = 0,
            testId = 0
        }

        function tbl3.onActivated()
            var5.current = true
            var4(layoutOrder)
        end
        tbl3.testId = `ImagePreviewBackgroundSwatch{value2.id}`
        local tbl4 = {
            Checkerboard = if value2.image then React.createElement(Image, {
                tag = "size-full radius-small",
                Image = value2.image,
                ScaleType = Enum.ScaleType.Tile,
                TileSize = UDim2.fromOffset(var1.Size.Size_150, var1.Size.Size_150)
            })
                or nil else nil
        }
        tbl2[id] = createElement(var9, tbl3, tbl4)
    end

    return React.createElement(View, { tag = "col align-x-center gap-xsmall size-full" }, {
        Preview = React.createElement(Image, {
            LayoutOrder = 1,
            tag = "size-full aspect-1-1 radius-small clip",
            backgroundStyle = backgroundStyle,
            imageStyle = backgroundStyle:map(function(arg1)
                return {
                    Color3 = var1.Color.Extended.White.White_100.Color3,
                    Transparency = 1 - arg1.Transparency
                }
            end),
            Image = "rbxassetid://6372755229",
            ScaleType = Enum.ScaleType.Tile,
            TileSize = UDim2.fromOffset(var1.Size.Size_400, var1.Size.Size_400),
            testId = "ImagePreviewBackground"
        }, {
            Asset = React.createElement(Image, {
                tag = "size-full",
                ImageContent = tbl1.imageContent,
                ScaleType = Enum.ScaleType.Fit,
                ZIndex = 2,
                testId = "ImagePreviewAsset"
            })
        }),
        Swatches = React.createElement(View, { tag = "row gap-xsmall auto-xy", LayoutOrder = 2, testId = "ImagePreviewSwatches" }, tbl2)
    })
end

return ImagePreview
