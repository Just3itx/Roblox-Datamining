-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T17:41:35Z
-- Luau bytecode version: 14 | Luau type version: 3
local Groups = script:FindFirstAncestor("Groups")
local GroupsParent = Groups.Parent
local React = require(GroupsParent.React)
local _createGroupSidebarState = require(Groups.Stores.createGroupSidebarState)

return React.createContext(nil)
