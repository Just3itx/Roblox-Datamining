-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:50:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommonParent = script:FindFirstAncestor("AuthCommon").Parent

local CentralOverlayType = require(AuthCommonParent.RobloxAppEnums).CentralOverlayType
local SetCentralOverlay = require(AuthCommonParent.CentralOverlay).Actions.SetCentralOverlay

return function()
    return function(arg1)
        arg1:dispatch(SetCentralOverlay(CentralOverlayType.LoginPasswordResetPrompt, {}))
    end
end
