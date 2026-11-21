-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T20:50:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GamePlayButtonParent = script:FindFirstAncestor("GamePlayButton").Parent
local CentralOverlayType = require(GamePlayButtonParent.RobloxAppEnums).CentralOverlayType
local SetCentralOverlay = require(GamePlayButtonParent.CentralOverlay).Actions.SetCentralOverlay

return function(arg1)
    return function(arg2)
        arg2:dispatch(SetCentralOverlay(CentralOverlayType.UnifiedProductPurchaseModal, arg1))
    end
end
