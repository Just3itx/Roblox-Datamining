-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T22:41:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SquadsParent = script:FindFirstAncestor("Squads").Parent
local React = require(SquadsParent.React)

local SquadLobbyUserOverflowMenuView = require(script.Parent.SquadLobbyUserOverflowMenuView)
local useSquadLobbyUserOverflowMenuViewModel = require(script.Parent.useSquadLobbyUserOverflowMenuViewModel)

local function SquadLobbyUserOverflowMenuContainer(arg1)
    local var1 = useSquadLobbyUserOverflowMenuViewModel(arg1)
    return React.createElement(SquadLobbyUserOverflowMenuView, var1)
end

return SquadLobbyUserOverflowMenuContainer
