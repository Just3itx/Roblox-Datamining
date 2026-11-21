-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T20:50:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GamePlayButtonParent = script:FindFirstAncestor("GamePlayButton").Parent
local CentralOverlayType = require(GamePlayButtonParent.RobloxAppEnums).CentralOverlayType
local SetCentralOverlay = require(GamePlayButtonParent.CentralOverlay).Actions.SetCentralOverlay

return function(universeId, gameName, price, productId, sellerId, pageFilter)
    return function(arg1)
        arg1:dispatch(
            SetCentralOverlay(CentralOverlayType.PurchaseGame, {
                universeId = universeId,
                gameName = gameName,
                price = price,
                productId = productId,
                sellerId = sellerId,
                pageFilter = pageFilter
            })
        )
    end
end
