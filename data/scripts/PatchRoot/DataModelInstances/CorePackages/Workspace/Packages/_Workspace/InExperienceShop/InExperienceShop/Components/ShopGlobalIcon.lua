-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:11:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local InExperienceShop = script:FindFirstAncestor("InExperienceShop")
local InExperienceShopParent = InExperienceShop.Parent

local React = require(InExperienceShopParent.React)
local Foundation = require(InExperienceShopParent.Foundation)
local SharedFlags = require(InExperienceShopParent.SharedFlags)

local FFlagEnableExperienceShopGlobalIcon = require(InExperienceShop.Flags.FFlagEnableExperienceShopGlobalIcon)
local FFlagEnableShopIconTelemetry = require(InExperienceShop.Flags.FFlagEnableShopIconTelemetry)
local FFlagEnableFreeTrialBlueDot = require(InExperienceShop.Flags.FFlagEnableFreeTrialBlueDot)
local FFlagOfferNotifyOnGlobalIcon = SharedFlags.FFlagOfferNotifyOnGlobalIcon
local FFlagEnableAnyFreeTrialToolTip = require(InExperienceShop.Flags.FFlagEnableAnyFreeTrialToolTip)
local num1 = game:DefineFastInt("ShopGlobalIconAnimGracePeriodMs", 3000)
local GetShopGlobalIconStore = require(InExperienceShop.Stores.GetShopGlobalIconStore)

local FFlagExperienceShopNewIconography = require(InExperienceShop.Flags.FFlagExperienceShopNewIconography)

local useTokens = Foundation.Hooks.useTokens
local IconName = Foundation.Enums.IconName
local IconVariant = Foundation.Enums.IconVariant

local num2 = if FFlagExperienceShopNewIconography then 0.23 else 0.2
local num3 = if FFlagExperienceShopNewIconography then 0.23 else 0.2

local tweenInfo = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local tweenInfo2 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
local tweenInfo3 = TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local tweenInfo4 = TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.In)

local var1 = nil
if game:IsLoaded() then
    var1 = tick()
else
    local connection = nil
    connection = game.Loaded:Connect(function()
        var1 = tick()
        connection:Disconnect()
    end)
end

local function ShopGlobalIcon(tbl1)
    if not FFlagEnableExperienceShopGlobalIcon then
        return nil
    end

    local var2 = useTokens()
    local buttonSize = tbl1.buttonSize
    local leftGap = tbl1.leftGap or 0
    local setIconInstance = if FFlagOfferNotifyOnGlobalIcon or FFlagEnableAnyFreeTrialToolTip then GetShopGlobalIconStore(false).setIconInstance else nil
    local var3, var4 = React.useState(0)
    local scale, var6 = React.useState(0)
    local var7, var8 = React.useState(false)

    local var9 = React.useRef(nil)
    local var10 = React.useRef(nil)
    local var11 = React.useRef(nil)
    local var12 = React.useRef(nil)
    local var13 = React.useRef(nil)
    local var14 = React.useRef(nil)

    local var15 = React.useRef(nil)
    local var16 = React.useRef(nil)

    local var17 = React.useRef(nil)
    local var18 = React.useRef(nil)
    local var19 = React.useRef(nil)

    local var20 = React.useRef(tbl1.hidden)
    var20.current = tbl1.hidden

    React.useEffect(function()
        local numberValue = Instance.new("NumberValue")
        numberValue.Value = 0
        var15.current = numberValue

        local numberValue2 = Instance.new("NumberValue")
        numberValue2.Value = 0
        var16.current = numberValue2

        local connection = numberValue:GetPropertyChangedSignal("Value"):Connect(function()
            var4(numberValue.Value)
        end)
        local connection2 = numberValue2:GetPropertyChangedSignal("Value"):Connect(function()
            var6(numberValue2.Value)
        end)

        local function stopAllAnimations()
            if var11.current then
                var11.current:Disconnect()
                var11.current = nil
            end
            if var12.current then
                var12.current:Disconnect()
                var12.current = nil
            end
            if var9.current then
                var9.current:Cancel()
                var9.current = nil
            end
            if var10.current then
                var10.current:Cancel()
                var10.current = nil
            end
            if var13.current then
                task.cancel(var13.current)
                var13.current = nil
            end
            if var14.current then
                task.cancel(var14.current)
                var14.current = nil
            end
        end

        local function showImmediate() -- Luacid: Inlined by compiler; 1 call site recovered
            numberValue.Value = buttonSize
            numberValue2.Value = 1
            var4(buttonSize)
            var6(1)
            var8(true)
        end

        local function showAnimated()
            stopAllAnimations()

            local num4 = num1
            if num4 > 0 then
                local var21 = var1 and tick() - var1
                if var21 == nil or var21 < num4 / 1000 then
                    showImmediate()
                    return
                end
            end

            numberValue.Value = 0
            numberValue2.Value = 0
            var8(false)

            local tween = TweenService:Create(numberValue, tweenInfo, { Value = buttonSize })
            var9.current = tween
            tween:Play()

            var13.current = task.delay(0.2, function()
                var13.current = nil
                var8(true)
                local tween2 = TweenService:Create(numberValue2, tweenInfo3, { Value = 1 })
                var10.current = tween2
                tween2:Play()
            end)
        end

        local function hideAnimated()
            stopAllAnimations()

            local tween = TweenService:Create(numberValue2, tweenInfo4, { Value = 0 })
            var10.current = tween
            var11.current = tween.Completed:Connect(function(playbackState: Enum.PlaybackState)
                if playbackState ~= Enum.PlaybackState.Completed then
                    return
                end
                var11.current = nil
                var8(false)
            end)
            tween:Play()

            var13.current = task.delay(0.2, function()
                var13.current = nil
                local tween2 = TweenService:Create(numberValue, tweenInfo2, { Value = 0 })
                var9.current = tween2
                var12.current = tween2.Completed:Connect(function(playbackState: Enum.PlaybackState)
                    if playbackState ~= Enum.PlaybackState.Completed then
                        return
                    end
                    var12.current = nil
                    var14.current = task.delay(1.5, function()
                        var14.current = nil
                        if var17.current then
                            var17.current()
                        end
                    end)
                end)
                tween2:Play()
            end)
        end

        var17.current = showAnimated
        var18.current = hideAnimated
        var19.current = stopAllAnimations

        if not var20.current then
            showAnimated()
        end

        return function()
            stopAllAnimations()
            connection:Disconnect()
            connection2:Disconnect()
            numberValue:Destroy()
            numberValue2:Destroy()
            var15.current = nil
            var16.current = nil
        end
    end, { buttonSize })

    local var21 = React.useRef(false)
    React.useEffect(function()
        if tbl1.hidden == nil then
            return
        end

        if not var21.current then
            var21.current = true
            return
        end

        local current = var15.current
        local current2 = var16.current
        if not (current and current2) then
            return
        end

        if var19.current then
            var19.current()
        end

        if tbl1.hidden then
            current.Value = 0
            current2.Value = 0
            var8(false)
            return
        end
        current.Value = buttonSize
        current2.Value = 1
        var8(true)
    end, { tbl1.hidden, buttonSize })

    React.useEffect(function()
        return function()
            if tbl1.onAreaChanged then
                tbl1.onAreaChanged("experience-shop-icon", Vector2.zero, Vector2.zero)
            end
        end
    end, { tbl1.onAreaChanged })

    local function reportArea(arg1)
        if not tbl1.onAreaChanged then
            return
        end

        if tbl1.hidden then
            tbl1.onAreaChanged("experience-shop-icon", Vector2.zero, Vector2.zero)
        else
            tbl1.onAreaChanged("experience-shop-icon", arg1.AbsolutePosition, arg1.AbsoluteSize)
        end
    end

    local function onActivated()
        if FFlagEnableFreeTrialBlueDot then
            local submitFreeTrialBlueDot = require(InExperienceShop.submitFreeTrialBlueDot)
            if submitFreeTrialBlueDot.isShopIconBlueDotShowing(false) then
                submitFreeTrialBlueDot.reportActivated()
            end
        end
        if FFlagEnableShopIconTelemetry and not RunService:IsStudio() then
            local loggingProtocol = require(InExperienceShopParent.LoggingProtocol)
            local shopIconClickEvent = require(InExperienceShop.Events.ShopIconClickEvent)
            loggingProtocol.default:logRobloxTelemetryEvent(shopIconClickEvent, { loggingProtocol.StandardizedFields.addPlaceId, loggingProtocol.StandardizedFields.addUniverseId, loggingProtocol.StandardizedFields.addSessionId }, {})
        end
        if tbl1.onActivated then
            tbl1.onActivated()
        end
    end

    local var22 = if buttonSize == 0 then 0 else var3 / buttonSize * leftGap

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        Size = UDim2.fromOffset(var22 + var3, buttonSize),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        LayoutOrder = tbl1.layoutOrder,
        [React.Change.AbsolutePosition] = reportArea,
        [React.Change.AbsoluteSize] = reportArea
    }
    local tbl3 = { Button = 0 }
    local var23

    if var7 then
        local createElement2 = React.createElement
        local view = Foundation.View
        local tbl4 = {
            ref = setIconInstance,
            Size = UDim2.fromOffset(buttonSize, buttonSize),
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new(1, -buttonSize / 2, 0.5, 0),
            cornerRadius = UDim.new(1, 0),
            backgroundStyle = var2.Color.OverMedia.OverMedia_0,
            onActivated = onActivated,
            scale = scale
        }
        local tbl5 = { Icon = 0, StatusIndicator = 0 }
        local element

        if FFlagExperienceShopNewIconography then
            element = React.createElement(Foundation.Icon, {
                name = IconName.ShoppingBasket,
                size = buttonSize * 0.55,
                variant = if tbl1.isActive then IconVariant.Filled else IconVariant.Regular,
                style = var2.Color.Content.Emphasis,
                Position = UDim2.fromScale(0.5, 0.5),
                AnchorPoint = Vector2.new(0.5, 0.5),
                ZIndex = 1
            })
        elseif tbl1.icon ~= nil then
            element = React.createElement("Frame", {
                BackgroundTransparency = 1,
                Size = UDim2.fromScale(1, 1),
                ZIndex = 1
            }, {
                Layout = React.createElement(
                    "UIListLayout",
                    {
                        HorizontalAlignment = Enum.HorizontalAlignment.Center,
                        VerticalAlignment = Enum.VerticalAlignment.Center
                    }
                ),
                CustomIcon = tbl1.icon
            })
        else
            element = React.createElement(Foundation.Icon, {
                name = IconName.BuildingStore,
                size = buttonSize * 0.55,
                variant = if tbl1.isActive then IconVariant.Filled else IconVariant.Regular,
                style = var2.Color.Content.Emphasis,
                Position = UDim2.fromScale(0.5, 0.5),
                AnchorPoint = Vector2.new(0.5, 0.5),
                ZIndex = 1
            })
        end

        tbl5.Icon = element

        tbl5.StatusIndicator = tbl1.showStatusIndicator
            and React.createElement("Frame", {
                Size = UDim2.fromOffset(8, 8),
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.fromScale(num3 + 0.5, 1 - (num2 + 0.5)),
                BackgroundColor3 = var2.Color.System.Emphasis.Color3,
                BackgroundTransparency = var2.Color.System.Emphasis.Transparency,
                BorderSizePixel = 0,
                ZIndex = 3
            }, {
                UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(1, 0) }),
                UIStroke = React.createElement("UIStroke", {
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                    Color = var2.Color.OverMedia.OverMedia_0.Color3,
                    Transparency = var2.Color.OverMedia.OverMedia_0.Transparency,
                    Thickness = 2
                })
            })
            or nil
        var23 = createElement2(view, tbl4, tbl5) or nil
    else
        var23 = nil
    end

    tbl3.Button = var23
    return createElement(str1, tbl2, tbl3)
end

return ShopGlobalIcon
