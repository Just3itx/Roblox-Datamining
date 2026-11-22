-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T09:01:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PinShortcutParent = script:FindFirstAncestor("PinShortcut").Parent

local CentralOverlay = require(PinShortcutParent.CentralOverlay)
local RobloxAppEnums = require(PinShortcutParent.RobloxAppEnums)

local SetCentralOverlay = CentralOverlay.Actions.SetCentralOverlay
local CentralOverlayType = RobloxAppEnums.CentralOverlayType

local function showPinExperienceResult(callback: (...any) -> (...any), status, experienceName: string, tbl1)
    callback(
        SetCentralOverlay(CentralOverlayType.PinExperienceResultSnackbar, {
            status = status,
            experienceName = experienceName,
            onViewShortcut = if tbl1 then tbl1.onViewShortcut else nil,
            onRetry = if tbl1 then tbl1.onRetry else nil
        })
    )
end
return showPinExperienceResult
