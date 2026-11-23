-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:10:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local React = require(BuildExperienceParent.React)

local PrivateInvitesPickerContainer = require(BuildExperience.Components.PrivateInvitesPicker.PrivateInvitesPickerContainer)

local function PrivateInvitesPickerHost(tbl1)
    return React.createElement(
        PrivateInvitesPickerContainer,
        {
            universeId = tbl1.universeId,
            onClose = tbl1.onClose,
            onInvitesSent = tbl1.onInvitesSent,
            testId = tbl1.testId
        }
    )
end
return PrivateInvitesPickerHost
