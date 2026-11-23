-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:10:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local React = require(BuildExperienceParent.React)

local PrivateInvitesPickerView = require(script.Parent.PrivateInvitesPickerView)
local usePrivateInvitesPickerViewModel = require(script.Parent.usePrivateInvitesPickerViewModel)

local function PrivateInvitesPickerContainer(arg1)
    local var1 = usePrivateInvitesPickerViewModel(arg1)
    return React.createElement(PrivateInvitesPickerView, var1)
end

return PrivateInvitesPickerContainer
