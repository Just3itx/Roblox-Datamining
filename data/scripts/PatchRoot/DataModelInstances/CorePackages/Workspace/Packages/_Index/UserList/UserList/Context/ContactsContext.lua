-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T02:11:18Z
-- Luau bytecode version: 14 | Luau type version: 3
local UserList = script:FindFirstAncestor("UserList")
local UserListParent = UserList.Parent

local React = require(UserListParent.React)
local _Types = require(UserList.Common.Types)

return (React.createContext({ contacts = {} }))
