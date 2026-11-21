-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T11:01:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DiscoveryRoutingParent = script:FindFirstAncestor("DiscoveryRouting").Parent
local CentralOverlayType = require(DiscoveryRoutingParent.RobloxAppEnums).CentralOverlayType
local SetCentralOverlay = require(DiscoveryRoutingParent.CentralOverlay).Actions.SetCentralOverlay

return function(title: string, body: string, closeAlert: (...any) -> (...any), buttonText: string?, showCloseButton: boolean?)
    return function(arg1)
        arg1:dispatch(
            SetCentralOverlay(
                CentralOverlayType.CloseOnlyInteractiveAlert,
                {
                    title = title,
                    body = body,
                    closeAlert = closeAlert,
                    buttonText = buttonText,
                    showCloseButton = showCloseButton
                }
            )
        )
    end
end
