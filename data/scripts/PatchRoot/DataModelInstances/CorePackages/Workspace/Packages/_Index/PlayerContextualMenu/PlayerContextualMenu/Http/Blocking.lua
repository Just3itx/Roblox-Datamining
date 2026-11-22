-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T09:41:00Z
-- Luau bytecode version: 14 | Luau type version: 3
local PlayerContextualMenu = script:FindFirstAncestor("PlayerContextualMenu")
local PlayerContextualMenuParent = PlayerContextualMenu.Parent
local NetworkingBlocking = require(PlayerContextualMenuParent.LuaSocialLibrariesDeps).NetworkingBlocking
local UserBlockingNetworking = require(PlayerContextualMenuParent.UserBlockingNetworking)

local RoduxNetworking = require(script.Parent.RoduxNetworking)

if require(PlayerContextualMenu.Flags.FFlagUserBlockingApiPlayerContextMenuEnabled) then
    return (UserBlockingNetworking.config({ roduxNetworking = RoduxNetworking }))
end
return (NetworkingBlocking.config({ roduxNetworking = RoduxNetworking }))
