-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:41:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local React = require(BuildExperienceParent.React)

local PrivateInvitesManagementView = require(script.Parent.PrivateInvitesManagementView)
local usePrivateInvitesManagementViewModel = require(script.Parent.usePrivateInvitesManagementViewModel)

local function PrivateInvitesManagementContainer(arg1)
    local var1 = usePrivateInvitesManagementViewModel(arg1)
    return React.createElement(PrivateInvitesManagementView, var1)
end

return PrivateInvitesManagementContainer
