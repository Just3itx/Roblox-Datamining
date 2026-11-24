-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T14:31:29Z
-- Luau bytecode version: 14 | Luau type version: 3
return {
    ModalOpened = {
        Type = "pageLoad",
        Args = {}
    },
    SendInvite = {
        Type = "formInteraction",
        Args = { btn = "inviteFriend", aType = "click" }
    },
    CancelInvite = {
        Type = "formInteraction",
        Args = { btn = "cancelInvite", aType = "click" }
    },
    ErrorShown = {
        Type = "formInteraction",
        Args = { field = "inviteFailed", aType = "shown" }
    },
    CustomTextShown = {
        Type = "formInteraction",
        Args = { field = "customText", aType = "shown" }
    }
}
