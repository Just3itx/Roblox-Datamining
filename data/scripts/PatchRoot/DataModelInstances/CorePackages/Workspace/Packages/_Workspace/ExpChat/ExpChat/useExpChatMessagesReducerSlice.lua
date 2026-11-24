-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:40:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent

local RoactUtils = require(ExpChatParent.RoactUtils)
local tutils = require(ExpChatParent.tutils)

local useSelector = RoactUtils.Hooks.RoactRodux.useSelector

local _Messages = require(ExpChat.installReducer.Messages)

return function()
    return (useSelector(function(arg1)
        return arg1.Messages
    end, tutils.shallowEqual))
end
