-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T01:11:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreScriptsPlayerFeedback = script:FindFirstAncestor("CoreScriptsPlayerFeedback")
local CoreScriptsPlayerFeedbackParent = CoreScriptsPlayerFeedback.Parent
local React = require(CoreScriptsPlayerFeedbackParent.React)
local ReactRoblox = require(CoreScriptsPlayerFeedbackParent.ReactRoblox)
local LocalizationProvider = require(CoreScriptsPlayerFeedbackParent.Localization).LocalizationProvider
local Localization = require(CoreScriptsPlayerFeedbackParent.InExperienceLocales).Localization

local PlayerFeedbackPrompts = require(CoreScriptsPlayerFeedback.Components.PlayerFeedbackPrompts)
local GetFFlagEnablePlayerSupportPrompt = require(CoreScriptsPlayerFeedback.Flags.GetFFlagEnablePlayerSupportPrompt)

local CoreGui = game:GetService("CoreGui")
local RobloxGui = CoreGui:FindFirstChild("RobloxGui") or CoreGui:WaitForChild("RobloxGui")
local fFlagEnablePlayerSupportPrompt = GetFFlagEnablePlayerSupportPrompt()

local success, result = pcall(function()
    if RobloxGui then
        return require(RobloxGui.Modules.Common.renderWithCoreScriptsStyleProvider)
    end
    return nil
end)
local var1 = success and result or function(arg1)
    return arg1.App
end

local function createApp(arg1)
    local var2 = arg1 or var1

    local screenGui = Instance.new("ScreenGui")
    screenGui.IgnoreGuiInset = not fFlagEnablePlayerSupportPrompt
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.AutoLocalize = false
    screenGui.DisplayOrder = -1

    local root = ReactRoblox.createRoot(screenGui)

    local LocalizationService = game:GetService("LocalizationService")

    root:render(
        (var2({
            App = React.createElement(
                LocalizationProvider,
                {
                    localization = Localization.new(LocalizationService.RobloxLocaleId)
                },
                {
                    PlayerFeedbackPrompts = React.createElement(PlayerFeedbackPrompts, { enableInputDelayed = true })
                }
            )
        }))
    )

    return {
        instance = screenGui,
        unmount = function()
            root:unmount()
        end
    }
end

return createApp
