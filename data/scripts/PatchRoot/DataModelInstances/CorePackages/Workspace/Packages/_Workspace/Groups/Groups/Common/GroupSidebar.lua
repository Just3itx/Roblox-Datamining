-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T17:40:41Z
-- Luau bytecode version: 14 | Luau type version: 3
local Groups = script:FindFirstAncestor("Groups")
local constants = require(Groups.Common.constants)
local _createGroupSidebarState = require(Groups.Stores.createGroupSidebarState)
local useGroupSidebarSection = require(Groups.Hooks.useGroupSidebarSection)

return table.freeze({
    Context = require(Groups.Contexts.GroupSidebarContext),
    useSection = useGroupSidebarSection,
    listSize = constants.SIDEBAR_LIST_SIZE
})
