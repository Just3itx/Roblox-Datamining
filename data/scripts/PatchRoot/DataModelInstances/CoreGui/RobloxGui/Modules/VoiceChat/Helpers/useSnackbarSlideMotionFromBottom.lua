-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:31:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local UserGameSettings = UserSettings():GetService("UserGameSettings")

local React = require(CorePackages.Packages.React)
local Foundation = require(CorePackages.Packages.Foundation)
local Motion = require(CorePackages.Packages.Motion)
local Responsive = require(CorePackages.Workspace.Packages.Responsive)

local function useSnackbarSlideMotionFromBottom(num1: number?)
    local var1 = Foundation.Hooks.useTokens()
    local var2 = Responsive.useDeviceInsets()
    local current = React.useRef(UserGameSettings.ReducedMotion).current
    local num2 = math.max(num1 or var1.Padding.XLarge, var2.bottom)

    local var3 = React.useMemo(function()
        return Motion.createState(
            {
                anchorPoint = Vector2.new(0.5, 0),
                position = UDim2.fromScale(0.5, 1)
            },
            {
                default = {
                    duration = if current then 0 else 0.15,
                    easingStyle = var1.Ease.StandardIn
                }
            }
        )
    end, { var1, current })

    local var4 = React.useMemo(function()
        return Motion.createState(
            {
                anchorPoint = Vector2.new(0.5, 1),
                position = UDim2.new(0.5, 0, 1, -num2)
            },
            {
                default = {
                    duration = if current then 0 else var1.Time.Time_200,
                    easingStyle = var1.Ease.StandardOut
                }
            }
        )
    end, { var1, current, num2 })

    local var5, var6 = Motion.useMotion(if current then var4 else var3)

    local var7 = React.useRef(var6)
    var7.current = var6
    local var8 = React.useRef(false)

    local var9 = React.useRef(var4)
    var9.current = var4

    React.useEffect(function()
        if not var8.current then
            var7.current(var4)
        end
    end, { var4 })

    local exit = React.useCallback(function(callback: (...any) -> (...any))
        var8.current = true
        var7.current(var3, {
            onAnimationComplete = function(arg1)
                if arg1 == true then
                    callback()
                end
            end
        })
    end, { var3 })

    local enter = React.useCallback(function()
        if var8.current then
            var8.current = false

            var7.current(var9.current)
        end
    end, {})

    return {
        anchorPoint = var5.anchorPoint,
        position = var5.position,
        enter = enter,
        exit = exit
    }
end

return useSnackbarSlideMotionFromBottom
