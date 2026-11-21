-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:21:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local dependencies = require(scriptParentParentParent.dependencies)

local ContactsListContainer = require(script.ContactsListContainer)

local Dash = dependencies.Dash
local Roact = dependencies.Roact
local useNavigation = dependencies.useNavigation

function ContactsList(arg1)
    local navigation = useNavigation()
    return Roact.createElement(ContactsListContainer, Dash.join({ navigation = navigation }, arg1 or {}))
end

return ContactsList
