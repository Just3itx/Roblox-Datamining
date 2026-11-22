-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T11:30:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local EventNames = require(script.Parent.EventNames)

return {
    [EventNames.QRPageLoad] = {
        name = game:DefineFastString("ProfileQRPageLoad", "ProfileQRPageLoad")
    },
    [EventNames.QRCodeScannerOpened] = {
        name = game:DefineFastString("ProfileQRCodeScannerOpened", "ProfileQRCodeScannerOpened")
    },
    [EventNames.QRCodeScannerTooltipShown] = {
        name = game:DefineFastString("ProfileQRCodeScannerTooltipShown", "ProfileQRCodeScannerTooltipShown")
    },
    [EventNames.QRPageLoadFailed] = {
        name = game:DefineFastString("ProfileQRPageLoadFailed", "ProfileQRPageLoadFailed")
    },
    [EventNames.QRPageFriendRequestBannerShown] = {
        name = game:DefineFastString("ProfileQRPageFriendRequestBannerShown", "ProfileQRPageFriendRequestBannerShown")
    },
    [EventNames.QRPageFriendRequestBannerAccepted] = {
        name = game:DefineFastString("ProfileQRPageFriendRequestBannerAccepted", "ProfileQRPageFriendRequestBannerAccepted")
    },
    [EventNames.QRPageFriendRequestBannerDismissed] = {
        name = game:DefineFastString("ProfileQRPageFriendRequestBannerDismissed", "ProfileQRPageFriendRequestBannerDismissed")
    }
}
