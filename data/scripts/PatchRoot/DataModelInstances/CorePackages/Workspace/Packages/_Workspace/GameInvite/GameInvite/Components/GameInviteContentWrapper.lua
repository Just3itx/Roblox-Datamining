-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T14:31:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameInvite = script:FindFirstAncestor("GameInvite")
local Components = GameInvite.Components
local Context = GameInvite.Context
local GameInviteParent = GameInvite.Parent

local React = require(GameInviteParent.React)

local GameInviteContextProvider = require(Context.GameInviteContextProvider)
local GameInviteContent = require(Components.GameInviteContent)
local _gameInviteModalType = require(GameInvite.gameInviteModalType)

return function(tbl1)
    return React.createElement(GameInviteContextProvider, {
        options = tbl1.options,
        serverType = tbl1.serverType,
        gameDetails = tbl1.gameDetails,
        isLoadingCustomParams = tbl1.isLoading,
        isCoreScript = tbl1.isCoreScript
    }, {
        GameInviteContent = React.createElement(GameInviteContent, {
            isLoadingCustomParams = tbl1.isLoading,
            disableSelectionParentManagement = tbl1.disableSelectionParentManagement,
            hideCloseButton = tbl1.hideCloseButton
        })
    })
end
