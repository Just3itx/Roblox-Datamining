-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T12:00:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfileShareLinks = script:FindFirstAncestor("ProfileShareLinks")
local ProfileShareLinksParent = ProfileShareLinks.Parent
local useAppPolicy = require(ProfileShareLinksParent.UniversalAppPolicy).useAppPolicy

local ProfileSharePolicyEnum = require(ProfileShareLinks.Enums.ProfileSharePolicyEnum)

return function()
    return (useAppPolicy(function(arg1)
        local profileShareLinkEnabled = arg1.getProfileShareLinkEnabled()
        local profileCopyLinkEnabled = arg1.getProfileCopyLinkEnabled()

        return if profileShareLinkEnabled then ProfileSharePolicyEnum.Share elseif profileCopyLinkEnabled then ProfileSharePolicyEnum.Copy else ProfileSharePolicyEnum.Disabled
    end))
end
