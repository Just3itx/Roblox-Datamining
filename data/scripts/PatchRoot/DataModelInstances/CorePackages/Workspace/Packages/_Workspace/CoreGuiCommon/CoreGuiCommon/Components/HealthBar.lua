-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:51:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local StarterGui = game:GetService("StarterGui")

local CoreGuiCommon = script:FindFirstAncestor("CoreGuiCommon")
local CoreGuiCommonParent = CoreGuiCommon.Parent

local Constants = require(CoreGuiCommon.Constants)

local Foundation = require(CoreGuiCommonParent.Foundation)
local React = require(CoreGuiCommonParent.React)
local RobloxAppHooks = require(CoreGuiCommonParent.RobloxAppHooks)
local RobloxAppEnums = require(CoreGuiCommonParent.RobloxAppEnums)
local Signals = require(CoreGuiCommonParent.Signals)
local SignalsReact = require(CoreGuiCommonParent.SignalsReact)

local GetLocalHumanoidStore = require(CoreGuiCommon.Stores).GetLocalHumanoidStore
local View = Foundation.View
local useDeviceOrientation = RobloxAppHooks.useDeviceOrientation
local useTokens = Foundation.Hooks.useTokens
local HealthBarColors = Constants.HealthBarColors

local function getHealthBarColor(fraction)
    if fraction <= HealthBarColors.Red.Fraction then
        return HealthBarColors.Red.Color
    end

    if HealthBarColors.Green.Fraction <= fraction then
        return HealthBarColors.Green.Color
    end

    local vec3 = Vector3.new(0, 0, 0)
    local num1 = 0
    for _, healthBarColor in HealthBarColors do
        local vec3_2 = Vector3.new(healthBarColor.Color.R, healthBarColor.Color.G, healthBarColor.Color.B)
        local var1 = fraction - healthBarColor.Fraction
        if var1 == 0 then
            return Color3.new(vec3_2.X, vec3_2.Y, vec3_2.Z)
        end
        local var2 = 1 / (var1 * var1)
        vec3 += var2 * vec3_2
        num1 += var2
    end

    local var1 = vec3 / num1
    return Color3.new(var1.X, var1.Y, var1.Z)
end

return React.memo(function(tbl1) -- name: HealthBar
    local var1 = tbl1.mockStarterGui or StarterGui

    local var2 = useTokens()
    local var3 = useDeviceOrientation()
    local var4 = SignalsReact.useSignalState(GetLocalHumanoidStore)

    local var5, var6 = React.useState(var1:GetCoreGuiEnabled(Enum.CoreGuiType.Health))

    local var7, var8 = React.useBinding(Constants.InitialHealth)
    local var9, var10 = React.useBinding(Constants.InitialHealth)
    local var11, var12 = React.useBinding(false)

    local var13 = React.joinBindings({ var7, var9, var11 }):map(function(arg1)
        local var13 = arg1[1]
        local var14 = arg1[2]

        local num1 = 1

        if arg1[3] then
            return 0
        end

        if var14 > 0 then
            num1 = math.clamp(var13 / var14, 0, 1)
        end

        return num1
    end)

    local var14 = React.joinBindings({ var7, var9 }):map(function(tbl2): boolean
        return tbl2[1] < tbl2[2]
    end)

    React.useEffect(function()
        local effect = Signals.createEffect(function(arg1)
            local healthValue = var4.getHealthValue(arg1)

            var8(healthValue.health or Constants.InitialHealth)
            var10(healthValue.maxHealth or Constants.InitialHealth)
            var12(healthValue.isDead or false)
        end)

        local connection = var1.CoreGuiChangedSignal:Connect(function(coreGuiType: Enum.CoreGuiType, enabled: boolean)
            if coreGuiType == Enum.CoreGuiType.Health or coreGuiType == Enum.CoreGuiType.All then
                var6(enabled)
            end
        end)

        return function()
            effect()
            connection:Disconnect()
        end
    end, { var4 })

    if not var5 then
        return nil
    end

    local createElement = React.createElement
    local var15 = View
    local tbl2 = {
        tag = "anchor-top-right position-top-right",
        Visible = var14,
        Size = UDim2.fromOffset(
            if var3 == RobloxAppEnums.DeviceOrientationMode.Portrait then var2.Size.Size_2000 else var2.Size.Size_3000,
            var2.Size.Size_400
        ),
        LayoutOrder = tbl1.layoutOrder,
        testId = "health-bar"
    }

    return (createElement(var15, tbl2, {
        HealthBar = React.createElement(View, {
            tag = "bg-surface-300 radius-medium size-full",
            backgroundStyle = {
                Color3 = var2.Color.Extended.Gray.Gray_700.Color3,
                Transparency = 0.2
            },
            stroke = {
                Thickness = var2.Stroke.Thicker,
                Transparency = 0.2,
                BorderStrokePosition = Enum.BorderStrokePosition.Outer
            },
            Position = UDim2.fromScale(0, 0.5),
            AnchorPoint = Vector2.new(0, 0.5)
        }, {
            Fill = React.createElement(View, {
                tag = "anchor-left-center radius-medium",
                backgroundStyle = var13:map(function(fraction)
                    return {
                        Color3 = getHealthBarColor(fraction),
                        Transparency = 0
                    }
                end),
                Size = var13:map(function(xScale: number): UDim2
                    return UDim2.fromScale(xScale, 1)
                end),
                testId = "health-bar-fill"
            })
        })
    }))
end)
