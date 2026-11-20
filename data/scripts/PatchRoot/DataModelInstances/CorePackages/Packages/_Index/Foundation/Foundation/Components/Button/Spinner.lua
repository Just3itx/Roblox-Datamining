-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:01:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent
local React = require(FoundationParent.React)
local isPluginSecurity = require(Foundation.Utility.isPluginSecurity)

local Motion = require(FoundationParent.Motion)
local useMotion = Motion.useMotion
local usePresence = Motion.usePresence

local useSpinnerMotionStates = require(script.Parent.useSpinnerMotionStates)

local Flags = require(Foundation.Utility.Flags)
local Image = require(Foundation.Components.Image)
local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)
local useRotation = require(Foundation.Utility.useRotation)
local withDefaults = require(Foundation.Utility.withDefaults)

local function IconSpinner(tbl1)
    local rotation = useRotation(2)

    return React.createElement(Image, {
        Image = "icons/status/loading_large",
        imageStyle = tbl1.style,
        Rotation = rotation,
        tag = "position-center-center anchor-center-center size-full-full",
        testId = tbl1.testId
    }, {
        UIScale = React.createElement("UIScale", { Scale = tbl1.scale })
    })
end

local tbl1 = {
    Path2DControlPoint.new(UDim2.fromScale(1, 0.5), UDim2.fromScale(0, 0.25), UDim2.fromScale(0, -0.25)),
    Path2DControlPoint.new(UDim2.fromScale(0.5, 0), UDim2.fromScale(0.25, 0), UDim2.fromScale(-0.25, 0)),
    Path2DControlPoint.new(UDim2.fromScale(0, 0.5), UDim2.fromScale(0, -0.33), UDim2.fromScale(0, 0.33)),
    Path2DControlPoint.new(UDim2.fromScale(0.5, 1), UDim2.fromScale(-0.25, 0), UDim2.fromScale(0.25, 0))
}

local function Path2DSpinner(tbl2)
    local ref = React.useRef(nil)
    local rotation = useRotation(2)

    React.useEffect(function()
        local current = ref.current
        if current ~= nil then
            current:SetControlPoints(tbl1)
        end
    end, {})

    local createElement = React.createElement
    local var3 = View
    local tbl3 = {
        tag = "position-center-center anchor-center-center size-full",
        Rotation = rotation,
        testId = tbl2.testId
    }

    local tbl4 = {
        Circle = React.createElement("Path2D", {
            ref = ref,
            Closed = false,
            Color3 = tbl2.style:map(function(arg1)
                return arg1.Color3
            end),
            Transparency = if isPluginSecurity() then tbl2.style:map(function(arg1)
                return arg1.Transparency
            end) else nil,
            Thickness = tbl2.Thickness
        }),
        UIScale = React.createElement("UIScale", { Scale = tbl2.scale })
    }

    return createElement(var3, tbl3, tbl4)
end

local tbl2 = {
    style = {}
}

return React.memo(React.forwardRef(function(tbl3, ref) -- name: Spinner
    local var1 = withDefaults(tbl3, tbl2)

    local var2 = useSpinnerMotionStates()
    local var3, var4 = useMotion(var2.Default)
    local var5 = usePresence()

    React.useEffect(function()
        if var5.isPresent then
            var4(var2.Loading)
            return
        end
        var4(var2.Default, { onAnimationComplete = var5.onExitComplete })
    end, { var5.isPresent })

    local createElement = React.createElement
    local var6 = View
    local tbl4 = {
        tag = "position-center-center anchor-center-center",
        Size = var1.Size,
        ref = ref
    }

    local tbl5 = {
        Spinner = React.createElement(if Flags.FoundationUsePath2DSpinner then Path2DSpinner else IconSpinner, {
            scale = var3.scale,
            style = React.joinBindings({ style = var1.style, transparency = var3.transparency }):map(function(arg1)
                return {
                    Color3 = arg1.style.Color3,
                    Transparency = arg1.style.Transparency + arg1.transparency / 2
                }
            end),
            Thickness = math.max(math.floor(var1.Size.X.Offset / 8), 1),
            testId = var1.testId
        })
    }

    return createElement(var6, tbl4, tbl5)
end))
