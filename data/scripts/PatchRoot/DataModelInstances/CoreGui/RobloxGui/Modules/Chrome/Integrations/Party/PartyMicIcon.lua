-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:00:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local React = require(CorePackages.Packages.React)
local UIBlox = require(CorePackages.Packages.UIBlox)

local CrossExperienceVoice = require(CorePackages.Workspace.Packages.CrossExperienceVoice)
local VoiceChat = require(CorePackages.Workspace.Packages.VoiceChat)

local useParticipant = CrossExperienceVoice.Hooks.useParticipant
local useIsVoiceConnected = CrossExperienceVoice.Hooks.useIsVoiceConnected
local useIsActiveParticipant = CrossExperienceVoice.Hooks.useIsActiveParticipant
local useIsParticipantMuted = CrossExperienceVoice.Hooks.useIsParticipantMuted

local scriptParentParentParent = script.Parent.Parent.Parent
local UnibarStyle = require(CorePackages.Workspace.Packages.Chrome).UnibarStyle

local FFlagTokenizeUnibarConstantsWithStyleProvider = require(scriptParentParentParent.ChromeShared.Flags).FFlagTokenizeUnibarConstantsWithStyleProvider

local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel

local num1 = game:DefineFastInt("PartyMicVoiceIndicatorFrameBuffer", 3)

local function getLoadingIndicatorIcon(arg1, bool1: boolean, bool2: boolean, bool3: boolean?, num2: number?)
    if not bool2 or not arg1 or bool1 then
        return VoiceChat.Utils.GetIcon("Muted", "MicLight")
    elseif bool3 then
        return VoiceChat.Utils.GetIcon("Unmuted", "MicLight", num2)
    end
    return VoiceChat.Utils.GetIcon("Unmuted0", "MicLight")
end

function PartyMicIcon(arg1)
    local userId = Players and Players.LocalPlayer and Players.LocalPlayer.UserId or -1
    local var1 = useIsVoiceConnected()
    local var2 = useParticipant(userId)
    local current = useIsActiveParticipant(userId)
    local var4 = React.useRef(current)
    local bool1 = useIsParticipantMuted(userId) == true
    local var5 = React.useRef(0)
    local var6, var7 = React.useState(0)
    local name = React.useMemo(function(): string
        return HttpService:GenerateGUID()
    end, {})

    local var8 = if FFlagTokenizeUnibarConstantsWithStyleProvider then UnibarStyle.use().ICON_SIZE else 36

    React.useEffect(function()
        if var2 then
            arg1.isLocalPlayerMutedSignal:fire(var2.isMuted)
        end
    end, { var2 })

    React.useEffect(function()
        arg1.isVoiceConnectedSignal:fire(var1)
    end, { var1 })

    local var9 = React.useCallback(function()
        if not var4.current then
            return
        end

        if var5.current > num1 then
            var7(math.random())
            var5.current = 0
            return
        end
        var5.current += 1
    end, {})

    React.useEffect(function()
        var4.current = current
    end, { current })

    React.useEffect(function()
        RunService:BindToRenderStep(name, 1, var9)

        return function()
            RunService:UnbindFromRenderStep(name)
        end
    end, {})

    local image = React.useMemo(function()
        return getLoadingIndicatorIcon(var2, bool1, var1, current, var6)
    end, {
        var2,
        bool1,
        var1,
        current,
        var6
    })
    return React.createElement(
        "Frame",
        {
            Size = UDim2.new(0, var8, 0, var8),
            BorderSizePixel = 0,
            BackgroundTransparency = 1
        },
        {
            UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(1, 0) }),
            Icon = React.createElement(
                ImageSetLabel,
                {
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Position = UDim2.fromScale(0.5, 0.5),
                    Size = UDim2.fromOffset(var8, var8),
                    BackgroundTransparency = 1,
                    Image = image
                },
                { React.createElement("UICorner", { Name = "Corner", CornerRadius = UDim.new(1, 0) }) }
            )
        }
    )
end

return PartyMicIcon
