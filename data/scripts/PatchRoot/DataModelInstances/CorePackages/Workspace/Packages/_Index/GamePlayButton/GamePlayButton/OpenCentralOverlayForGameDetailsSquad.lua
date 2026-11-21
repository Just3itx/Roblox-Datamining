-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T20:50:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GamePlayButtonParent = script:FindFirstAncestor("GamePlayButton").Parent
local CentralOverlayType = require(GamePlayButtonParent.RobloxAppEnums).CentralOverlayType
local SetCentralOverlay = require(GamePlayButtonParent.CentralOverlay).Actions.SetCentralOverlay

return function(landscapeMenuDirection, menuAnchorPosition, menuAnchorSize, referralSource, universeId)
    return function(arg1)
        arg1:dispatch(
            SetCentralOverlay(CentralOverlayType.GameDetailsSquad, {
                landscapeMenuDirection = landscapeMenuDirection,
                menuAnchorPosition = menuAnchorPosition,
                menuAnchorSize = menuAnchorSize,
                referralSource = referralSource,
                universeId = universeId
            })
        )
    end
end
