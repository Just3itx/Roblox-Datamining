-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T02:10:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local installReducer = require(script.Rodux.installReducer)
local Deprecated = require(script.Deprecated)
local Enums = require(script.Common.Enums)

local _Types = require(script.Common.Types)

return {
    ["jest.config"] = script["jest.config"],
    RoduxKey = require(script.Common.Constants).RODUX_KEY,
    installReducer = installReducer,
    Components = Deprecated.Components,
    Enums = Enums,
    UserListHeader = require(script.Components).UserListHeader,
    UserListFooter = require(script.Components).UserListFooter,
    UserListLayoutAdaptor = require(script.Components).UserListLayoutAdaptor,
    UserRow = require(script.Components).UserRow,
    EntityRow = require(script.Components).EntityRow,
    VerticalUserList = require(script.Components).VerticalUserList,
    HorizontalUserList = require(script.Components).HorizontalUserList,
    ContactsContext = require(script.Context).ContactsContext
}
