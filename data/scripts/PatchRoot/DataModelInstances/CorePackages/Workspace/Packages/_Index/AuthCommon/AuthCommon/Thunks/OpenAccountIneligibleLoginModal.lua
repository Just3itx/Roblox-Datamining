-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:50:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommonParent = script:FindFirstAncestor("AuthCommon").Parent

local CentralOverlayType = require(AuthCommonParent.RobloxAppEnums).CentralOverlayType
local SetCentralOverlay = require(AuthCommonParent.CentralOverlay).Actions.SetCentralOverlay

return function(onDismiss: (...any) -> (...any), portalToFoundationOverlay: boolean?, tbl1)
    return function(arg1)
        local tbl2 = tbl1 or {}
        arg1:dispatch(
            SetCentralOverlay(CentralOverlayType.AccountIneligibleLoginModal, {
                onDismiss = onDismiss,
                portalToFoundationOverlay = portalToFoundationOverlay,
                titleKey = tbl2.titleKey,
                descriptionKey = tbl2.descriptionKey,
                actionKey = tbl2.actionKey
            })
        )
    end
end
