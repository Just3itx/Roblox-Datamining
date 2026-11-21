-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:30:38Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParentParentParent = script.Parent.Parent.Parent
local getFFlagPassNavigationToContactsRevoked = require(scriptParentParentParent.Flags.getFFlagPassNavigationToContactsRevoked)
local _ContactsRevokedAccessDialog = require(script.ContactsRevokedAccessDialog)
if getFFlagPassNavigationToContactsRevoked() then
    return (require(script.ContactsRevokedAccessDialogEntryPoint))
end

return (require(script.ContactsRevokedAccessDialog))
