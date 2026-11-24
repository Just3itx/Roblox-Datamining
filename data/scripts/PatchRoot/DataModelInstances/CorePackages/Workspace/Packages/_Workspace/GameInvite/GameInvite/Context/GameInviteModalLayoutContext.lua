-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T14:41:03Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local React = require(scriptParentParentParent.React)
local _gameInviteModalType = require(scriptParentParent.gameInviteModalType)

return (React.createContext(
    {
        isFullHeight = false,
        isFullWidth = false,
        modalSize = UDim2.new(0, 0, 0, 0),
        modalMode = "default"
    }
))
