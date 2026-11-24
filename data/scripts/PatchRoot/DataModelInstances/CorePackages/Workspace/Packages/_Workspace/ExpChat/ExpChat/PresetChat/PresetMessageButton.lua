-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:11:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TweenService = game:GetService("TweenService")

local ExpChatParent = script:FindFirstAncestor("ExpChat").Parent
local ExpChatShared = require(ExpChatParent.ExpChatShared)
local Foundation = require(ExpChatParent.Foundation)
local React = require(ExpChatParent.React)

local PresetCooldownContext = require(script.Parent.PresetCooldownContext)

local var1 = ExpChatShared.Flags.FIntPresetChatCooldownLuaMs / 1000

return React.memo(function(tbl1) -- name: PresetMessageButton
    local var2 = Foundation.Hooks.useTokens()
    local circle = var2.Radius.Circle
    local var3 = React.useContext(PresetCooldownContext)
    local isCooldownActive = not (var3 == nil) and var3.isCooldownActive
    local endsAt = if var3 == nil then nil else var3.endsAt

    local onActivated = React.useCallback(function()
        tbl1.onActivated(tbl1.presetId)
    end, { tbl1.onActivated, tbl1.presetId })

    local var5, var6 = React.useState(nil)
    local ref = React.useRef(nil)

    local onAbsoluteSizeChanged = React.useCallback(function(arg1)
        if var5 == nil and arg1 and arg1.AbsoluteSize.X > 0 then
            var6(arg1.AbsoluteSize)
        end
    end, { var5 })

    React.useEffect(function()
        if endsAt == nil or var5 == nil then
            return
        end
        local current = ref.current
        if current == nil then
            return
        end
        local time = endsAt - os.clock()
        if time <= 0 then
            return
        end
        local num1 = math.clamp(time / var1, 0, 1)
        current.Size = UDim2.fromOffset(var5.X * num1, var5.Y)
        local tween = TweenService:Create(current, TweenInfo.new(time, Enum.EasingStyle.Linear), { Size = UDim2.fromOffset(0, var5.Y) })

        tween:Play()
        return function()
            tween:Cancel()
            tween:Destroy()
        end
    end, { endsAt, var5 })

    local createElement = React.createElement
    local view = Foundation.View
    local tbl2 = {
        onAbsoluteSizeChanged = onAbsoluteSizeChanged,
        LayoutOrder = tbl1.layoutOrder or 0,
        tag = "size-0-800 auto-x radius-circle clip",
        backgroundStyle = var2.Color.ActionStandard.Background,
        onActivated = onActivated,
        isDisabled = isCooldownActive,
        cursor = {
            radius = UDim.new(0, circle),
            offset = math.floor(var2.Stroke.Thicker) * 2,
            borderWidth = math.floor(var2.Stroke.Thicker)
        },
        ref = tbl1.buttonRef
    }
    local tbl3 = { CooldownClipFrame = 0, Text = 0 }
    local element

    if isCooldownActive and endsAt ~= nil and var5 ~= nil then
        element = React.createElement("Frame", {
            ref = ref,
            Size = UDim2.fromOffset(var5.X, var5.Y),
            BackgroundTransparency = 1,
            ClipsDescendants = true,
            BorderSizePixel = 0,
            ZIndex = 1
        }, {
            CooldownOverlay = React.createElement(
                "Frame",
                {
                    Size = UDim2.new(0, var5.X, 1, 0),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    BackgroundColor3 = var2.Color.Shift.Shift_400.Color3,
                    BackgroundTransparency = var2.Color.Shift.Shift_400.Transparency,
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
        textStyle = var2.Color.ActionStandard.Foreground,
        tag = "size-0-full auto-x text-label-medium",
        padding = {
            left = UDim.new(0, var2.Padding.Medium),
            right = UDim.new(0, var2.Padding.Medium)
        },
        ZIndex = 2
    })
    return createElement(view, tbl2, tbl3)
end)
