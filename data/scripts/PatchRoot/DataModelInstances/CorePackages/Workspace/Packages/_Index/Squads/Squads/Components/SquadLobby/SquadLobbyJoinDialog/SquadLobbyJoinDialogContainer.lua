-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T22:41:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SquadsParent = script:FindFirstAncestor("Squads").Parent
local React = require(SquadsParent.React)

local SquadLobbyJoinDialogView = require(script.Parent.SquadLobbyJoinDialogView)
local useSquadLobbyJoinDialogViewModel = require(script.Parent.useSquadLobbyJoinDialogViewModel)

local function SquadLobbyJoinDialogContainer(arg1)
    local var1 = useSquadLobbyJoinDialogViewModel(arg1)
    return React.createElement(SquadLobbyJoinDialogView, var1)
end

return SquadLobbyJoinDialogContainer
