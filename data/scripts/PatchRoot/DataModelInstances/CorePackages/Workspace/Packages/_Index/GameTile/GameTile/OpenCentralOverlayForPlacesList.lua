-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T22:31:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameTileParent = script:FindFirstAncestor("GameTile").Parent
local CentralOverlayType = require(GameTileParent.RobloxAppEnums).CentralOverlayType
local SetCentralOverlay = require(GameTileParent.CentralOverlay).Actions.SetCentralOverlay

return function(game, anchorSpaceSize, anchorSpacePosition)
    return function(arg1)
        arg1:dispatch(
            SetCentralOverlay(
                CentralOverlayType.PlacesList,
                {
                    game = game,
                    anchorSpaceSize = anchorSpaceSize,
                    anchorSpacePosition = anchorSpacePosition
                }
            )
        )
    end
end
