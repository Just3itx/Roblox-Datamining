-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T04:50:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local React = require(ProfilePlatformParent.React)

local Enums = require(ProfilePlatform.Common.Enums)
local useProfileJsonComponent = require(ProfilePlatform.Hooks.useProfileJsonComponent)
local ContactProfileHeader = require(ProfilePlatform.Components.ContactProfileHeader.ContactProfileHeader)

local function ContactProfileHeaderContainer(tbl1)
    local var1 = useProfileJsonComponent(Enums.Components.ContactProfileHeader)
    local contactName = var1.contactName
    local avatarThumbnailUrl = var1.avatarThumbnailUrl

    return React.createElement(
        ContactProfileHeader,
        {
            layoutOrder = tbl1.layoutOrder,
            contactName = contactName,
            avatarThumbnailUrl = avatarThumbnailUrl
        }
    )
end
return ContactProfileHeaderContainer
