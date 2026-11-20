-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T23:10:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppShortcutBarParent = script:FindFirstAncestor("AppShortcutBar").Parent

local React = require(AppShortcutBarParent.React)
local Foundation = require(AppShortcutBarParent.Foundation)
local Motion = require(AppShortcutBarParent.Motion)
local isBuilderIcon = Foundation.Utility.isBuilderIcon

local useTokens = Foundation.Hooks.useTokens
local Icon = Foundation.Icon

local function useAnimationValues(progress)
    local var1 = React.useMemo(function()
        return {
            initial = Motion.createState({ scale = 1, ringScale = 1 }, { default = Motion.transition({ duration = 0.2 }) }),
            target = Motion.createState({ scale = 0.8, ringScale = 1.15 }, { default = Motion.transition({ duration = 0.3 }) })
        }
    end, {})

    local var2, var3 = Motion.useMotion(var1.initial)
    React.useEffect(function()
        var3(if progress then var1.target else var1.initial)
    end, { progress, var3, var1 })

    return var2
end

local function CircularProgress(tbl1)
    local var1 = useTokens()
    local size = tbl1.size
    local progress = tbl1.progress

    local var2 = React.useMemo(function(): NumberSequence
        return NumberSequence.new({
            NumberSequenceKeypoint.new(0, var1.Color.Content.Emphasis.Transparency),
            NumberSequenceKeypoint.new(0.4999, var1.Color.Content.Emphasis.Transparency),
            NumberSequenceKeypoint.new(0.5, 0.5),
            NumberSequenceKeypoint.new(1, 0.5)
        })
    end, { var1 })

    local var3 = React.useMemo(function(): ColorSequence
        return ColorSequence.new({
            ColorSequenceKeypoint.new(0, var1.Color.Content.Emphasis.Color3),
            ColorSequenceKeypoint.new(0.4999, var1.Color.Content.Emphasis.Color3),
            ColorSequenceKeypoint.new(0.5, var1.Color.Content.Muted.Color3),
            ColorSequenceKeypoint.new(1, var1.Color.Content.Muted.Color3)
        })
    end, { var1 })

    local rotation = React.useMemo(function()
        if progress then
            return (progress:map(function(num1: number): number
                return math.clamp(num1 * 360, 180, 360)
            end))
        end

        return 180
    end, { progress })

    local var4 = React.useMemo(function()
        if progress then
            return (progress:map(function(num1: number): number
                return math.clamp(num1 * 360, 0, 180)
            end))
        end

        return 0
    end, { progress })

    return React.createElement("Frame", { Size = size, BackgroundTransparency = 1 }, {
        Left = React.createElement(
            "Frame",
            {
                Size = UDim2.fromScale(0.5, 1),
                BackgroundTransparency = 1,
                ClipsDescendants = true
            },
            {
                Image = React.createElement(
                    "ImageLabel",
                    {
                        Image = "rbxasset://textures/ui/Controls/RadialFill@3x.png",
                        Size = UDim2.fromScale(2, 1),
                        BackgroundTransparency = 1
                    },
                    {
                        Gradient = React.createElement("UIGradient", { Transparency = var2, Color = var3, Rotation = rotation })
                    }
                )
            }
        ),
        Right = React.createElement("Frame", {
            Size = UDim2.fromScale(0.5, 1),
            BackgroundTransparency = 1,
            ClipsDescendants = true,
            Position = UDim2.fromScale(0.5, 0)
        }, {
            Image = React.createElement(
                "ImageLabel",
                {
                    Image = "rbxasset://textures/ui/Controls/RadialFill@3x.png",
                    Size = UDim2.fromScale(2, 1),
                    Position = UDim2.fromScale(-1, 0),
                    BackgroundTransparency = 1
                },
                {
                    Gradient = React.createElement("UIGradient", { Transparency = var2, Color = var3, Rotation = var4 })
                }
            )
        })
    })
end

function IconWithHoldAnimation(tbl1)
    local layoutOrder = tbl1.layoutOrder
    local size = tbl1.size
    local position = tbl1.position
    local anchorPoint = tbl1.anchorPoint
    local progress = tbl1.progress
    local icon = tbl1.icon
    local iconSize = tbl1.iconSize

    local var1 = useAnimationValues(progress)

    local var2, var3 = React.useBinding(iconSize)
    React.useEffect(function()
        var3(iconSize)
    end, { iconSize })

    local default = useTokens().Color.Content.Default

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        LayoutOrder = layoutOrder,
        Size = size,
        Position = position,
        AnchorPoint = anchorPoint,
        BackgroundTransparency = 1
    }
    local tbl3 = { AnimationFrame = 0 }
    local createElement2 = React.createElement
    local str2 = "Frame"
    local tbl4 = {
        Size = UDim2.fromScale(1, 1),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        BackgroundTransparency = 1
    }
    local tbl5 = {
        UIScale = React.createElement("UIScale", { Scale = var1.scale }),
        RingFrame = React.createElement("Frame", {
            Size = UDim2.fromScale(1, 1),
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5),
            BackgroundTransparency = 1
        }, {
            RingScale = React.createElement("UIScale", { Scale = var1.ringScale }),
            Progress = React.createElement(CircularProgress, { size = UDim2.fromScale(1, 1), progress = progress })
        }),
        IconFrame = 0
    }

    local createElement3 = React.createElement
    local str3 = "Frame"
    local tbl6 = {
        Size = UDim2.fromScale(1, 1),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        BackgroundTransparency = 1
    }
    local tbl7 = { Icon = 0 }
    local element

    if not isBuilderIcon(icon) then
        element = React.createElement("ImageLabel", {
            Image = icon,
            BackgroundTransparency = 1,
            ImageColor3 = default.Color3,
            ImageTransparency = default.Transparency,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromOffset(iconSize, iconSize)
        })
    else
        element = React.createElement(
            Icon,
            {
                name = icon,
                size = var2,
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.fromScale(0.5, 0.5)
            }
        )
    end

    tbl7.Icon = element
    tbl5.IconFrame = createElement3(str3, tbl6, tbl7)
    tbl3.AnimationFrame = createElement2(str2, tbl4, tbl5)
    return createElement(str1, tbl2, tbl3)
end

return IconWithHoldAnimation
