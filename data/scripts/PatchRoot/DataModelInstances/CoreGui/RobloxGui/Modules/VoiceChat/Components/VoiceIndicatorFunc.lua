-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:31:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local RobloxGui = CoreGui:WaitForChild("RobloxGui")

local Roact = require(CorePackages.Packages.Roact)
local React = require(CorePackages.Packages.React)
local ReactIs = require(CorePackages.Packages.ReactIs)

local UIBlox = require(CorePackages.Packages.UIBlox)
local useSelectionCursor = UIBlox.App.SelectionImage.useSelectionCursor
local CursorKind = UIBlox.App.SelectionImage.CursorKind

local useVoiceState = require(RobloxGui.Modules.VoiceChat.Hooks.useVoiceState)
local Constants = require(RobloxGui.Modules.VoiceChat.Constants)
local default = require(RobloxGui.Modules.VoiceChat.VoiceChatServiceManager).default
local num1 = game:DefineFastInt("MicTalkingUpdateFrequency", 3)

local uDim2 = UDim2.fromOffset(28, 28)

local function useJoinBinding<T>(arg1: T, arg2: T) -- Luacid: Inlined by compiler; 1 call site recovered
    return React.useMemo(function()
        return Roact.joinBindings({ arg1, arg2 })
    end, { arg1, arg2 })
end

local function mapLevelToIcon(iconStyle, bool1: boolean) -- Luacid: Inlined by compiler; 1 call site recovered
    return function(arg1)
        local var1 = arg1[1]
        local var2 = arg1[2]
        if var1 == Constants.VOICE_STATE.MUTED or var1 == Constants.VOICE_STATE.LOCAL_MUTED then
            return default:GetIcon("Muted", iconStyle)
        elseif var1 == Constants.VOICE_STATE.CONNECTING or var1 == Constants.VOICE_STATE.HIDDEN then
            if bool1 and iconStyle == "MicLight" then
                return default:GetIcon("Connecting", "MicDark")
            end
            return default:GetIcon("Connecting", iconStyle)
        else
            if var1 == Constants.VOICE_STATE.INACTIVE then
                return default:GetIcon("Unmuted0", iconStyle)
            end

            if var1 ~= Constants.VOICE_STATE.TALKING then
                return default:GetIcon("Error", iconStyle)
            end

            local num2 = math.floor(0.5 + 5 * var2) * 20
            return default:GetIcon("Unmuted" .. tostring(num2), iconStyle)
        end
    end
end

local tbl1 = {
    [Constants.VOICE_STATE.ERROR] = true,
    [Constants.VOICE_STATE.HIDDEN] = true
}

local function GenerateGUID(): string
    return HttpService:GenerateGUID()
end

local function createTweenShimmeringEffect(arg1): Tween
    local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Circular, Enum.EasingDirection.Out, -1)
    local propertyTable = {
        Offset = Vector2.new(1, 0)
    }
    return (TweenService:Create(arg1:getValue(), tweenInfo, propertyTable))
end

local function VoiceIndicator(tbl2)
    local var1 = useVoiceState(tbl2.userId, tbl2.disable or false)
    local var2, var3 = React.useBinding(0)
    local selectable = tbl2.selectable == nil or tbl2.selectable
    local var5, var6 = React.useBinding(var1)
    local var7 = useJoinBinding(var5, var2)

    local current = React.useRef(GenerateGUID()).current or ""
    var6(var1)

    local bool1 = var1 == Constants.VOICE_STATE.CONNECTING
    local bool2 = tbl2.showConnectingShimmer == true
    local var8 = React.useRef(nil)

    React.useEffect(function()
        if not (bool2 and bool1 and var8.current) then
            return function() end
        end

        local tween = createTweenShimmeringEffect(var8)
        tween:Play()

        return function()
            tween:Cancel()
        end
    end, { bool1, bool2 })

    local var9 = React.useRef(false)
    var9.current = var1 == Constants.VOICE_STATE.TALKING

    React.useEffect(function()
        local num2 = 0

        RunService:BindToRenderStep(current, 1, function()
            if not var9.current then
                return
            end

            num2 += 1
            if num1 <= num2 then
                num2 = 0
                var3(math.random())
            end
        end)

        return function()
            RunService:UnbindFromRenderStep(current)
        end
    end, { current })

    local bool3 = not not (not tbl2.hideOnError or var1 and not tbl1[var1])
    local num2 = if var1 == Constants.VOICE_STATE.LOCAL_MUTED then 0.5 else 0

    local imageTransparency = if tbl2.iconTransparency then if ReactIs.isBinding(tbl2.iconTransparency) then tbl2.iconTransparency:map(function(arg1): number
        return 1 - (1 - arg1) * (1 - num2)
    end) else 1 - (1 - tbl2.iconTransparency) * (1 - num2) else num2

    local image = React.useMemo(function()
        return var7:map((mapLevelToIcon(tbl2.iconStyle, bool2)))
    end, { tbl2.iconStyle, bool2 })

    local selectionImageObject = useSelectionCursor(CursorKind.RoundedRectNoInset)

    local createElement = Roact.createElement
    local str1 = "ImageButton"
    local tbl3 = {
        Size = tbl2.size or uDim2,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Image = image,
        ImageTransparency = imageTransparency,
        Selectable = selectable,
        SelectionImageObject = selectionImageObject,
        Visible = bool3,
        [Roact.Event.Activated] = tbl2.onClicked
    }
    local tbl4 = { ShimmerGradient = 0 }
    local element

    if bool2 then
        element = Roact.createElement("UIGradient", {
            Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0.6, 0.6, 0.6)), ColorSequenceKeypoint.new(0.5, Color3.new(0.8, 0.8, 0.8)), ColorSequenceKeypoint.new(1, Color3.new(0.6, 0.6, 0.6)) }),
            Enabled = bool1,
            Rotation = -45,
            Offset = Vector2.new(-1, 0),
            [Roact.Ref] = var8
        })
    else
        element = nil
    end

    tbl4.ShimmerGradient = element
    return createElement(str1, tbl3, tbl4)
end

return VoiceIndicator
