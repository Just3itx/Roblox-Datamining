-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:51:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local React = require(ProfilePlatformParent.React)

local ServerTriggeredModals = require(ProfilePlatformParent.ServerTriggeredModals)
local reportPromptImpression = ServerTriggeredModals.reportPromptImpression
local fetchPrompts = ServerTriggeredModals.fetchPrompts
local createProfileCompletionPromptsConfig = require(ProfilePlatformParent.ProfilePlatformCommon).Utils.createProfileCompletionPromptsConfig
local fetchFramesPromptId = require(ProfilePlatform.Hooks.fetchFramesPromptId)

local str1 = game:DefineFastString("ProfileFramesUpsellPromptType", "ProfileFramesUpsell")

local function useReportFramesImpression()
    React.useEffect(function()
        if not reportPromptImpression then
            return
        end

        fetchFramesPromptId():andThen(function(arg1)
            return reportPromptImpression(str1, arg1)
        end):andThen(function()
            fetchPrompts(createProfileCompletionPromptsConfig(), true)
        end):catch(function() end)
    end, {})
end

return useReportFramesImpression
