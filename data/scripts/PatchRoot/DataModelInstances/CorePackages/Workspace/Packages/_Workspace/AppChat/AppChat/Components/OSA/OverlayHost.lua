-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:31:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Cryo = require(AppChatParent.Cryo)
local React = require(AppChatParent.React)
local SignalsReact = require(AppChatParent.SignalsReact)
local ProviderContainer = require(AppChatParent.RoactUtils).Components.ProviderContainer

local GroupOSADialog = require(AppChat.Components.OSA.GroupOSADialog)
local GetOverlayStore = require(AppChat.Stores.GetOverlayStore)

local FFlagAppChatShowOSAOnPageEntry = require(AppChatParent.SharedFlags).FFlagAppChatShowOSAOnPageEntry

local tbl1 = { GroupOSADialog = GroupOSADialog }

local function OverlayHost(tbl2)
    local overlayStore = GetOverlayStore(false)
    local var1 = SignalsReact.useSignalState(overlayStore.getCurrentOverlay)

    local var2 = SignalsReact.useSignalState(overlayStore.getOverlayDefaultProps)

    local onClose = React.useCallback(function()
        overlayStore.dismissOverlay()
    end, {})

    local overlayType = var1 and var1.overlayType
    local var4 = overlayType and tbl1[overlayType]
    if not var4 then
        return nil
    end

    local var5 = Cryo.Dictionary.union(var2 or {}, var1.overlayProps or {})
    if FFlagAppChatShowOSAOnPageEntry then
        local onClose2 = var5.onClose
        function var5.onClose()
            if onClose2 then
                onClose2()
            end
            onClose()
        end
    else
        var5.onClose = onClose
    end
    var5.hasBackdrop = true
    var5.disablePortal = false

    local overlay = React.createElement(var4, var5)

    if not (tbl2.providers and #tbl2.providers > 0) then
        return overlay
    end

    return React.createElement(ProviderContainer, { providers = tbl2.providers }, { Overlay = overlay })
end

return OverlayHost
