-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T19:50:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialServerDrivenUi = script:FindFirstAncestor("SocialServerDrivenUi")
local SocialServerDrivenUiParent = SocialServerDrivenUi.Parent

local getBooleanParam = require(SocialServerDrivenUiParent.SduiCoreSystem).SduiActionParams.getBooleanParam
local ServerTriggeredModals = require(SocialServerDrivenUiParent.ServerTriggeredModals)
local reportPromptImpression = ServerTriggeredModals.reportPromptImpression
local fetchPrompts = ServerTriggeredModals.fetchPrompts

local createProfileCompletionPromptsConfig = require(SocialServerDrivenUiParent.ProfilePlatformCommon).Utils.createProfileCompletionPromptsConfig

local FFlagSduiOpenProfileFramesEditorSkipImpression = require(SocialServerDrivenUi.Flags.FFlagSduiOpenProfileFramesEditorSkipImpression)

local str1 = game:DefineFastString("ProfileFramesEditorScreen", "EditProfileImageProfilePlatform")
local str2 = game:DefineFastString("ProfileFramesUpsellPromptType", "ProfileFramesUpsell")

return function(arg1, _, arg2, _)
    local actionParams = if arg1 then arg1.actionParams or nil else nil
    local promptId = if actionParams then actionParams.promptId else nil
    local var1 = FFlagSduiOpenProfileFramesEditorSkipImpression

    if var1 then
        if actionParams == nil then
            var1 = false
        else
            var1 = getBooleanParam(actionParams, "skipPromptImpression", false)
        end
    end

    if reportPromptImpression and not var1 then
        reportPromptImpression(str2, promptId):andThen(function()
            fetchPrompts(createProfileCompletionPromptsConfig(), true)
        end):catch(function() end)
    end

    arg2.dependencies.getNavigation().navigate(str1, { mode = "framesOnly" })
end
