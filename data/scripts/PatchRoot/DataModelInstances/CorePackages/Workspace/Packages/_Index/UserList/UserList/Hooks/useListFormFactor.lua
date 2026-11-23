-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T02:20:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserList = script:FindFirstAncestor("UserList")
local UserListParent = UserList.Parent
local useSelector = require(UserListParent.RoactUtils).Hooks.RoactRodux.useSelector
local _Enums = require(UserList.Common.Enums)

return function()
    return {
        formFactor = useSelector(function(arg1)
            return arg1.FormFactor
        end)
    }
end
