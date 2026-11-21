-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T11:01:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DiscoveryRoutingParent = script:FindFirstAncestor("DiscoveryRouting").Parent
local CentralOverlayType = require(DiscoveryRoutingParent.RobloxAppEnums).CentralOverlayType
local SetCentralOverlay = require(DiscoveryRoutingParent.CentralOverlay).Actions.SetCentralOverlay

return function(titleText, bodyText, actionButtonText, cancelButtonText, onActionButtonClick, onCancelButtonClick, onCloseModal)
    return function(arg1)
        arg1:dispatch(
            SetCentralOverlay(CentralOverlayType.PlayButtonUpsellDialog, {
                titleText = titleText,
                bodyText = bodyText,
                actionButtonText = actionButtonText,
                cancelButtonText = cancelButtonText,
                onActionButtonClick = onActionButtonClick,
                onCancelButtonClick = onCancelButtonClick,
                onCloseModal = onCloseModal
            })
        )
    end
end
