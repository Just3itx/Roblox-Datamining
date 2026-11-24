-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:41:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local ExpChat = script:FindFirstAncestor("ExpChat")

local ExpChatParent = ExpChat.Parent
local React = require(ExpChatParent.React)
local isTenFootInterface = require(ExpChatParent.AppCommonLib).isTenFootInterface
local SharedFlags = require(ExpChatParent.SharedFlags)

local withSignalsData = require(script.Parent.withSignalsData)
local UIBlox = require(ExpChatParent.UIBlox)
local Images = UIBlox.App.ImageSet.Images
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local Image = require(ExpChatParent.Foundation).Image

local num1 = 0.6
local vector2 = Vector2.new(-1, 0)
local bool1 = game:DefineFastFlag("EnableChatMicPerfBinding", false)
local FFlagExpChatMicBubbleSingleImage = require(ExpChat.Flags.FFlagExpChatMicBubbleSingleImage)

local bool2 = game:DefineFastFlag("EnableDarkerShimmerTransparency", false)
local num2 = game:DefineFastInt("ExpChatMicActivityHeartbeatIncrement", 3)
if bool2 then
    num1 = 0.4
end
local GetFFlagExpChatEnableVoiceReverseNudge = require(ExpChat.Flags.GetFFlagExpChatEnableVoiceReverseNudge)
local GetFFlagExpChatUseVoiceParticipantsStore = SharedFlags.GetFFlagExpChatUseVoiceParticipantsStore

local Helpers = ExpChat.BubbleChat.Helpers
local getVoiceIndicatorAssetName = require(Helpers.getVoiceIndicatorAssetName)

local function createTweenShimmeringEffect(arg1): Tween
    local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Circular, Enum.EasingDirection.Out, -1)
    local propertyTable = {
        Offset = Vector2.new(1, 0)
    }
    return (TweenService:Create(arg1:getValue(), tweenInfo, propertyTable))
end

local function ControlBubble(tbl1)
    local var1 = nil
    local var2, var3, var4

    if FFlagExpChatMicBubbleSingleImage then
        local var5
        var2, var5 = React.useBinding(0)
        var3 = var5
        var1 = tbl1.iconAssetName or getVoiceIndicatorAssetName(tbl1.voiceState, 1, tbl1.iconStyle, false)
        var4 = Image
    elseif bool1 then
        local var5
        var2, var5 = React.useBinding(0)
        var3 = var5
        var1 = var2:map(function(arg1)
            return tbl1.iconAssetName or getVoiceIndicatorAssetName(tbl1.voiceState, arg1, tbl1.iconStyle, false)
        end)
        var4 = Image
    else
        local var5
        var2, var5 = React.useState(0)
        var3 = var5
        var4 = ImageSetLabel
    end

    local var5 = React.useRef(0)
    React.useRef(nil)
    React.useRef(nil)

    local ref = React.useRef(nil)
    local var7 = React.useRef(nil)
    React.useEffect(function()
        if not ref.current then
            return
        end

        local current = ref.current:FindFirstChildWhichIsA("UIGradient", true)
        if current then
            var7.current = current
        end
    end, { ref })

    React.useEffect(function()
        local var8 = nil
        if tbl1.voiceState and tbl1.voiceState == "Talking" then
            local connection = RunService.PostSimulation:Connect(function()
                local current = var5.current or 0
                var5.current = (current + 1) % num2

                if var5.current == 0 then
                    var3(math.random())
                end
            end)

            return function()
                if connection then
                    connection:Disconnect()
                    connection = nil
                end
            end
        end

        if not tbl1.voiceState or tbl1.voiceState ~= "Connecting" or not var7 then
            return function()
                if var8 then
                    var8:Disconnect()
                    var8 = nil
                end
            end
        end

        local tween = createTweenShimmeringEffect(var7)
        tween:Play()

        return function()
            tween:Cancel()

            if var7 and var7.current then
                var7.current.Offset = vector2
            end
        end
    end, { tbl1.voiceState })

    local onActivated = nil
    local var8 = nil
    if GetFFlagExpChatUseVoiceParticipantsStore() then
        var8 = React.useRef(tbl1.voiceState)
        React.useEffect(function()
            var8.current = tbl1.voiceState
        end, { tbl1.voiceState })

        onActivated = React.useCallback(function(arg1)
            if tbl1.onActivated then
                tbl1.onActivated(arg1, var8.current)
            end
        end, { tbl1.onActivated })
    end

    if not (bool1 or FFlagExpChatMicBubbleSingleImage) then
        local var9 = tbl1.iconAssetName or getVoiceIndicatorAssetName(tbl1.voiceState, var2, tbl1.iconStyle, false)

        if GetFFlagExpChatEnableVoiceReverseNudge() then
            var9 = tbl1.iconAssetName or getVoiceIndicatorAssetName(tbl1.voiceState, var2, tbl1.iconStyle, tbl1.isUserToxic)
        end
        var1 = Images[var9]
    end

    local createElement = React.createElement
    local str1 = "ImageButton"
    local tbl2 = {
        AnchorPoint = Vector2.new(0.5, 1),
        Interactable = not isTenFootInterface() and nil,
        Selectable = not isTenFootInterface() and nil,
        Size = tbl1.controlBubbleSize,
        LayoutOrder = tbl1.LayoutOrder,
        BorderSizePixel = 0,
        Transparency = 1,
        ZIndex = 2
    }
    local activated = React.Event.Activated

    if not GetFFlagExpChatUseVoiceParticipantsStore() then
        onActivated = tbl1.onActivated
    end

    tbl2[activated] = onActivated
    tbl2.BackgroundTransparency = 1
    tbl2.ref = ref

    return createElement(str1, tbl2, {
        UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(0, tbl1.cornerRadiusOffset) }),
        Contents = React.createElement(
            "Frame",
            {
                Size = UDim2.fromScale(1, 1),
                BorderSizePixel = 0,
                BackgroundTransparency = 1
            },
            {
                UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(0, tbl1.cornerRadiusOffset) }),
                Icon = React.createElement(var4, {
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Position = UDim2.fromScale(0.5, 0.5),
                    Size = tbl1.iconSize,
                    BackgroundTransparency = 1,
                    ImageTransparency = tbl1.iconTransparency,
                    BorderSizePixel = 0,
                    Image = var1
                }, {
                    ShimmerGradient = React.createElement("UIGradient", {
                        Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(num1, num1, num1)), ColorSequenceKeypoint.new(0.5, Color3.new(0.8, 0.8, 0.8)), ColorSequenceKeypoint.new(1, Color3.new(num1, num1, num1)) }),
                        Enabled = tbl1.voiceState == "Connecting",
                        Rotation = -45,
                        Offset = vector2
                    }),
                    ActivityGradient = FFlagExpChatMicBubbleSingleImage
                        and React.createElement("UIGradient", {
                            Color = var2:map(function(arg1): ColorSequence
                                return ColorSequence.new({
                                    ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
                                    ColorSequenceKeypoint.new(arg1 * 0.5, Color3.new(1, 1, 1)),
                                    ColorSequenceKeypoint.new(arg1 * 0.5 + 1e-6, Color3.new(0, 0, 0)),
                                    ColorSequenceKeypoint.new(1, Color3.new(0, 0, 0))
                                })
                            end),
                            Transparency = NumberSequence.new(0),
                            Enabled = tbl1.voiceState ~= "Connecting",
                            Rotation = 0
                        })
                })
            }
        )
    })
end

if GetFFlagExpChatUseVoiceParticipantsStore() then
    return React.memo(withSignalsData(ControlBubble))
end
return React.memo(ControlBubble)
