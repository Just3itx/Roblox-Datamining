-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:01:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TweenService = game:GetService("TweenService")

local ChatUIPrimitives = script:FindFirstAncestor("ChatUIPrimitives")
local ChatUIPrimitivesParent = ChatUIPrimitives.Parent
local Foundation = require(ChatUIPrimitivesParent.Foundation)
local React = require(ChatUIPrimitivesParent.React)
local _Types = require(ChatUIPrimitives.UniversalMessage.Types)

local FFlagExpChatExpressionPillSelectableOnCooldown = require(ChatUIPrimitives.Flags.FFlagExpChatExpressionPillSelectableOnCooldown)

return React.memo(function(tbl1) -- name: ExpressionPillView
    local var1 = Foundation.Hooks.useTokens()
    local circle = var1.Radius.Circle
    local cooldownEndsAt = tbl1.cooldownEndsAt
    local cooldownDurationSeconds = tbl1.cooldownDurationSeconds
    local bool1 = not (cooldownEndsAt == nil) and os.clock() < cooldownEndsAt
    local var2, var3 = React.useState(nil)
    local ref = React.useRef(nil)

    local onAbsoluteSizeChanged = React.useCallback(function(arg1)
        if var2 == nil and arg1 and arg1.AbsoluteSize.X > 0 then
            var3(arg1.AbsoluteSize)
        end
    end, { var2 })

    local var6 = React.useCallback(function()
        tbl1.onActivated(tbl1.content)
    end, { tbl1.onActivated, tbl1.content })

    local onActivated = if FFlagExpChatExpressionPillSelectableOnCooldown then React.useCallback(function()
        if cooldownEndsAt ~= nil and cooldownEndsAt > os.clock() then
            return
        end
        var6()
    end, { cooldownEndsAt, var6 }) else var6

    React.useEffect(function()
        if cooldownEndsAt == nil or var2 == nil then
            return
        end
        local current = ref.current
        if current == nil then
            return
        end
        local time = cooldownEndsAt - os.clock()
        if time <= 0 then
            return
        end
        local num1 = math.clamp(time / cooldownDurationSeconds, 0, 1)
        current.Size = UDim2.fromOffset(var2.X * num1, var2.Y)
        local tween = TweenService:Create(current, TweenInfo.new(time, Enum.EasingStyle.Linear), { Size = UDim2.fromOffset(0, var2.Y) })

        tween:Play()
        return function()
            tween:Cancel()
            tween:Destroy()
        end
    end, { cooldownEndsAt, var2, cooldownDurationSeconds })

    local createElement = React.createElement
    local view = Foundation.View
    local tbl2 = {
        onAbsoluteSizeChanged = onAbsoluteSizeChanged,
        LayoutOrder = tbl1.layoutOrder or 0,
        tag = "size-0-800 auto-x radius-circle clip",
        backgroundStyle = var1.Color.ActionStandard.Background,
        onActivated = onActivated,
        isDisabled = not FFlagExpChatExpressionPillSelectableOnCooldown and bool1,
        cursor = {
            radius = UDim.new(0, circle),
            offset = math.floor(var1.Stroke.Thicker) * 2,
            borderWidth = math.floor(var1.Stroke.Thicker)
        },
        ref = tbl1.buttonRef
    }
    local tbl3 = { CooldownClipFrame = 0, Text = 0 }
    local element

    if bool1 and cooldownEndsAt ~= nil and var2 ~= nil then
        element = React.createElement("Frame", {
            ref = ref,
            Size = UDim2.fromOffset(var2.X, var2.Y),
            BackgroundTransparency = 1,
            ClipsDescendants = true,
            BorderSizePixel = 0,
            ZIndex = 1
        }, {
            CooldownOverlay = React.createElement(
                "Frame",
                {
                    Size = UDim2.new(0, var2.X, 1, 0),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    BackgroundColor3 = var1.Color.Shift.Shift_400.Color3,
                    BackgroundTransparency = var1.Color.Shift.Shift_400.Transparency,
                    BorderSizePixel = 0
                },
                {
                    UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(0, circle) })
                }
            )
        })
    else
        element = nil
    end

    tbl3.CooldownClipFrame = element

    tbl3.Text = React.createElement(Foundation.Text, {
        Text = tbl1.text,
        textStyle = var1.Color.ActionStandard.Foreground,
        tag = "size-0-full auto-x text-label-medium",
        padding = {
            left = UDim.new(0, var1.Padding.Medium),
            right = UDim.new(0, var1.Padding.Medium)
        },
        ZIndex = 2
    })
    return createElement(view, tbl2, tbl3)
end)
