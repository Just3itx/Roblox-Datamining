-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:20:59Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local React = require(scriptParentParentParent.React)
local _type = require(scriptParentParent.type)

return (React.createContext({
    notificationPayload = nil,
    state = nil,
    cardSize = nil,
    handleActions = nil,
    openMetaActions = nil,
    readOnly = nil,
    cardTransparency = nil
}))
