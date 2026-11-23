-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T01:01:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TrustedContacts = script:FindFirstAncestor("TrustedContacts")
local TrustedContactsParent = TrustedContacts.Parent
local React = require(TrustedContactsParent.React)
local ReactRoblox = require(TrustedContactsParent.ReactRoblox)
local useOverlay = require(TrustedContactsParent.Foundation).Hooks.useOverlay

local TrustedFriendsCardWithActionsCheck = require(script.Parent.TrustedFriendsCardWithActionsCheck)

local _Types = require(TrustedContacts.Common.Types)

return function(tbl1)
    local modalProps = tbl1.screenProps.modalProps
    local externalNavigation = tbl1.screenProps.externalNavigation

    local var1 = useOverlay()
    if not var1 then
        return nil
    end
    return ReactRoblox.createPortal(
        React.createElement(TrustedFriendsCardWithActionsCheck, {
            userId = modalProps.userId,
            onRequestAccepted = modalProps.onRequestAccepted,
            onRequestSent = modalProps.onRequestSent,
            source = modalProps.source,
            modalVariantOverride = modalProps.modalVariantOverride,
            sentFromQrCode = modalProps.sentFromQrCode,
            tokens = modalProps.tokens,
            isVerticallyConstrained = modalProps.isVerticallyConstrained,
            onAcknowledged = modalProps.onAcknowledged,
            externalNavigation = externalNavigation
        }),
        var1
    )
end
