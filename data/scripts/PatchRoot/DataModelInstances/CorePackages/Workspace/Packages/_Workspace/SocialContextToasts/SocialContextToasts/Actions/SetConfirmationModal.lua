-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T15:31:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialContextToastsParent = script:FindFirstAncestor("SocialContextToasts").Parent
return require(SocialContextToastsParent.Rodux).makeActionCreator(script.Name, function(isConfirmationModalOpen, closeCallback)
    return { isConfirmationModalOpen = isConfirmationModalOpen, closeCallback = closeCallback }
end)
