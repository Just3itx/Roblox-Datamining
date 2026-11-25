-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:10:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent

local CloseCentralOverlay = require(ServerDrivenUiParent.CentralOverlay).Thunks.CloseCentralOverlay
local Responsive = require(ServerDrivenUiParent.Responsive)
local GetInputModeStore = Responsive.GetInputModeStore
local OpenInfoPeekView = require(ServerDrivenUiParent.DiscoveryRouting).OpenInfoPeekView
local OpenCloseOnlyInteractiveAlert = require(ServerDrivenUiParent.DiscoveryRouting).OpenCloseOnlyInteractiveAlert

local SduiResponsiveHelpers = require(ServerDrivenUiParent.SduiCoreSystem).SduiResponsiveHelpers

return function(arg1, _, arg2)
    local dispatch = arg2.dependencies.dispatch

    local var1 = SduiResponsiveHelpers.isPortraitOrientation()
    local var2 = GetInputModeStore(false).getLastInputType(false)

    local tooltipInfoText = arg1 and arg1.actionParams and arg1.actionParams.tooltipInfoText or ""

    local tooltipTitle = arg1 and arg1.actionParams and arg1.actionParams.tooltipTitle or ""
    if var2 == Responsive.Input.Touch and var1 then
        dispatch(OpenInfoPeekView(tooltipTitle, tooltipInfoText))
        return
    end
    dispatch(OpenCloseOnlyInteractiveAlert(tooltipTitle, tooltipInfoText, function()
        return dispatch(CloseCentralOverlay())
    end))
end
