-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T14:41:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local GameDetailsContext = require(scriptParent.GameDetailsContext)
local React = require(scriptParentParentParent.React)
local _gameInviteModalType = require(scriptParentParent.gameInviteModalType)

return function(tbl1)
    return React.createElement(GameDetailsContext.Provider, {
        value = {
            gameDetails = tbl1.gameDetails or {},
            serverType = tbl1.serverType or "",
            promptMessage = tbl1.promptMessage or "",
            trigger = tbl1.trigger or "",
            isCoreScript = tbl1.isCoreScript or false
        }
    }, tbl1.children)
end
