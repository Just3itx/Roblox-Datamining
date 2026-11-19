-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:00:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local CoreGui = game:GetService("CoreGui")

local React = require(CorePackages.Packages.React)
local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local Players = game:GetService("Players")
local ChromeShared = script.Parent.Parent.ChromeShared
local GetStyleTokens = require(ChromeShared.Utility.GetStyleTokens)

local FFlagExpChatContinuousListeningChatIconDot = require(CorePackages.Workspace.Packages.SharedFlags).FFlagExpChatContinuousListeningChatIconDot
local RedDot = if FFlagExpChatContinuousListeningChatIconDot then require(script.Parent.RedDot) else nil
local useVoiceState = require(RobloxGui.Modules.VoiceChat.Hooks.useVoiceState)
local Constants = require(RobloxGui.Modules.VoiceChat.Constants)
local styleTokens = GetStyleTokens()

local brightRed = Color3.new(0.918, 0.2, 0.137)
local uDim2 = UDim2.new(0, styleTokens.Size.Size_100, 0, styleTokens.Size.Size_100)

return function(arg1)
    local var1 = useVoiceState(Players.LocalPlayer and Players.LocalPlayer.UserId or 0)
    local visible = var1 == Constants.VOICE_STATE.INACTIVE or var1 == Constants.VOICE_STATE.TALKING

    if FFlagExpChatContinuousListeningChatIconDot then
        return React.createElement(RedDot, { name = "RedVoiceDot", position = arg1.position, visible = visible })
    end

    return React.createElement(
        "Frame",
        {
            Name = "RedVoiceDot",
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = arg1.position,
            Size = uDim2,
            BackgroundColor3 = brightRed,
            Visible = visible
        },
        {
            UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(1, 0) })
        }
    )
end
