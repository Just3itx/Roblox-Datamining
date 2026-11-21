-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:30:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParentParent = script.Parent.Parent.Parent.Parent.Parent
local React = require(scriptParentParentParentParentParent.React)
local Dash = require(scriptParentParentParentParentParent.Dash)
local useNavigation = require(scriptParentParentParentParentParent.Navigation).useNavigation

local ContactsRevokedAccessDialog = require(script.Parent.ContactsRevokedAccessDialog)

local function ContactsRevokedAccessDialogEntryPoint(tbl1)
    local navigation = useNavigation()
    return React.createElement(ContactsRevokedAccessDialog, Dash.join(tbl1, { navigation = navigation }))
end

return ContactsRevokedAccessDialogEntryPoint
