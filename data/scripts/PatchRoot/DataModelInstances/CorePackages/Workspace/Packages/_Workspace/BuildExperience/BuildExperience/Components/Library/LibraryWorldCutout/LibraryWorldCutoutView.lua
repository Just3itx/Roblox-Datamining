-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:51:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)

local Skeleton = Foundation.Skeleton
local FoundationText = Foundation.Text
local View = Foundation.View

local Radius = Foundation.Enums.Radius

local isTapRelease = require(script.Parent.isTapRelease)

local uDim2 = UDim2.new(1, 0, 0, 100000)
local aspectRatio = {
    AspectRatio = 16 / 9,
    DominantAxis = Enum.DominantAxis.Width
}

local function useScreenHeight(arg1)
    local var1, var2 = React.useState(0)
    React.useEffect(function()
        local var3 = if arg1 == nil then nil else arg1:FindFirstAncestorWhichIsA("LayerCollector")

        if var3 == nil then
            return nil
        end
        var2(var3.AbsoluteSize.Y)
        local connection = var3:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
            var2(var3.AbsoluteSize.Y)
        end)
        return function()
            connection:Disconnect()
        end
    end, { arg1 })
    return var1
end

local function LibraryWorldCutoutView(arg1)
    local var1 = Foundation.Hooks.useTokens()
    local uDim = UDim.new(0, arg1.inset)
    local var2 = React.useRef(nil)
    local var3, ref = React.useState(nil)
    local var5 = useScreenHeight(var3)
    local var6 = if var5 > 0 then math.min(800, math.floor(var5 * 0.5 * 16 / 9)) else 800
    local onActivated = arg1.onActivated
    local var4 = React.useCallback(function(_, arg2)
        local current = var2.current
        var2.current = nil
        if isTapRelease(current, arg2) then
            onActivated()
        end
    end, { onActivated })
    local var8 = React.useCallback(function(_, arg2)
        if arg2.UserInputType == Enum.UserInputType.Touch or arg2.UserInputType == Enum.UserInputType.MouseButton1 then
            var2.current = arg2.Position
        end
    end, {})
    local createElement = React.createElement
    local var9 = View
    local tbl2 = {
        LayoutOrder = arg1.LayoutOrder,
        tag = "col gap-large size-full-0 auto-y",
        testId = "Library.WorldCutout"
    }

    local tbl3 = { Header = 0, Cell = 0 }
    local createElement2 = React.createElement
    local var10 = View
    local tbl4 = {
        LayoutOrder = 1,
        padding = { left = uDim, right = uDim },
        tag = "row align-y-center size-full-600",
        testId = "Library.WorldCutout.Header"
    }

    local tbl5 = { Title = 0 }
    local element

    if arg1.isLoading then
        element = React.createElement(Skeleton, {
            Size = UDim2.fromOffset(var1.Size.Size_2800, var1.Size.Size_600),
            radius = Radius.Small,
            testId = "Library.WorldCutout.TitleSkeleton"
        })
    else
        element = React.createElement(FoundationText, {
            Text = arg1.title,
            tag = "auto-xy text-heading-small text-align-x-left content-emphasis",
            testId = "Library.WorldCutout.Title"
        })
    end

    tbl5.Title = element
    tbl3.Header = createElement2(var10, tbl4, tbl5)

    local createElement3 = React.createElement
    local var11 = View
    local tbl6 = {
        LayoutOrder = 2,
        padding = { left = uDim, right = uDim },
        ref = ref,
        sizeConstraint = {
            MaxSize = Vector2.new(var6 + 2 * arg1.inset, math.huge)
        },
        tag = "size-full-0 auto-y"
    }
    local tbl7 = { Window = 0 }
    local element2

    if arg1.isLoading then
        element2 = React.createElement(
            View,
            { Size = uDim2, aspectRatio = aspectRatio, testId = "Library.WorldCutout.Skeleton" },
            {
                Skeleton = React.createElement(Skeleton, { radius = Radius.Medium })
            }
        )
    else
        local createElement4 = React.createElement
        local var12 = View
        local tbl8 = {
            Size = uDim2,
            aspectRatio = aspectRatio,
            backgroundStyle = { Transparency = 1 },
            onActivated = var4,
            selection = { Selectable = true },
            stateLayer = {
                affordance = Foundation.Enums.StateLayerAffordance.None
            },
            ref = arg1.onRectChanged,
            onAbsolutePositionChanged = arg1.onRectChanged,
            onAbsoluteSizeChanged = arg1.onRectChanged,
            tag = "radius-medium",
            testId = "Library.WorldCutout.Window"
        }

        local tbl9 = {
            PressTracker = React.createElement(
                "Frame",
                {
                    BackgroundTransparency = 1,
                    Size = UDim2.fromScale(1, 1),
                    [React.Event.InputBegan] = var8
                }
            )
        }
        element2 = createElement4(var12, tbl8, tbl9)
    end

    tbl7.Window = element2
    tbl3.Cell = createElement3(var11, tbl6, tbl7)
    return createElement(var9, tbl2, tbl3)
end

return LibraryWorldCutoutView
