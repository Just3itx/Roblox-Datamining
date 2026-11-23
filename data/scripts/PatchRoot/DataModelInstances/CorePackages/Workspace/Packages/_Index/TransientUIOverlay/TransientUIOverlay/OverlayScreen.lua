-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T00:19:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TransientUIOverlay = script:FindFirstAncestor("TransientUIOverlay")
local TransientUIOverlayParent = TransientUIOverlay.Parent

local _Foundation = require(TransientUIOverlayParent.Foundation)
local React = require(TransientUIOverlayParent.React)
local SignalsReact = require(TransientUIOverlayParent.SignalsReact)

local GetTransientUIOverlayStore = require(TransientUIOverlay.Stores.GetTransientUIOverlayStore)
local TransientDialog = require(TransientUIOverlay.Components.TransientDialog)
local TransientSnackbar = require(TransientUIOverlay.Components.TransientSnackbar)

local function OverlayScreen(tbl1)
    local transientUiOverlayStore = GetTransientUIOverlayStore(false)
    local var1 = SignalsReact.useSignalState(transientUiOverlayStore.currentSnackbar)
    local var2 = SignalsReact.useSignalState(transientUiOverlayStore.currentDialog)
    local str1 = `Dialog-{SignalsReact.useSignalState(transientUiOverlayStore.dialogPresentationId)}`
    local var3

    if var1 == nil then
        var3 = nil
    else
        var3 = table.clone(var1)
        var3.device = tbl1.device
    end

    local var4

    if var2 == nil then
        var4 = nil
    else
        var4 = table.clone(var2)
        var4.device = tbl1.device
    end

    React.useEffect(function()
        return function()
            transientUiOverlayStore.clearSnackbar()
            transientUiOverlayStore.clearDialog()
        end
    end, { transientUiOverlayStore })

    return React.createElement("ScreenGui", {
        [React.Tag] = "data-testid=transient-ui-overlay",
        DisplayOrder = tbl1.displayOrder or 202,
        IgnoreGuiInset = true,
        Name = "TransientUIOverlay",
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    }, {
        Snackbar = if var3 == nil then nil else React.createElement(TransientSnackbar, var3),
        [str1] = if var4 == nil then nil else React.createElement(TransientDialog, var4)
    })
end

return OverlayScreen
