-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:21:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local React = require(BuildExperienceParent.React)
local IXPServiceWrapper = require(BuildExperienceParent.IxpServiceWrapper).IXPServiceWrapper

local BuildChatPageView = require(script.Parent.BuildChatPageView)
local useBuildChatPageViewModel = require(script.Parent.useBuildChatPageViewModel)
local ChatCardEmphasisProvider = require(BuildExperience.Components.Chat.ChatCardEmphasis.ChatCardEmphasisProvider)
local FFlagBuildExperienceChatCardEmphasis = require(BuildExperience.Flags.FFlagBuildExperienceChatCardEmphasis)
local FFlagBuildChatIXPExposure = require(BuildExperience.Flags.FFlagBuildChatIXPExposure)
local FStringBuildChatIXPLayer = require(BuildExperience.Flags.FStringBuildChatIXPLayer)

local function BuildChatPage(arg1)
    local var1 = useBuildChatPageViewModel(arg1)
    if FFlagBuildChatIXPExposure then
        React.useEffect(function()
            IXPServiceWrapper:LogFlagLinkedUserLayerExposure(FStringBuildChatIXPLayer)
        end, {})
    end
    if FFlagBuildExperienceChatCardEmphasis then
        return React.createElement(ChatCardEmphasisProvider, nil, React.createElement(BuildChatPageView, var1))
    end
    return React.createElement(BuildChatPageView, var1)
end

return BuildChatPage
