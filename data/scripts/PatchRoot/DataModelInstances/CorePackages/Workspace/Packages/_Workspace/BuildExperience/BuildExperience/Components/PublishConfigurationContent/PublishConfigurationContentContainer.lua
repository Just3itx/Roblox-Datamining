-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:11:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local React = require(BuildExperienceParent.React)

local PublishConfigurationContentView = require(script.Parent.PublishConfigurationContentView)
local usePublishConfigurationContentViewModel = require(script.Parent.usePublishConfigurationContentViewModel)

local function PublishConfigurationContentContainer(arg1)
    local var1 = usePublishConfigurationContentViewModel(arg1)
    return React.createElement(PublishConfigurationContentView, var1)
end

return PublishConfigurationContentContainer
