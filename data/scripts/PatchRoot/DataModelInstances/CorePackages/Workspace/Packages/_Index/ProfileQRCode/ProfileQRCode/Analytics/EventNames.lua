-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T11:30:49Z
-- Luau bytecode version: 14 | Luau type version: 3
local ProfileQRCodeParent = script:FindFirstAncestor("ProfileQRCode").Parent
return require(ProfileQRCodeParent.Enumerate)(script.Name, {
    QRPageLoad = "QRPageLoad",
    QRPageLoadFailed = "QRPageLoadFailed",
    QRPageFriendRequestBannerShown = "QRPageFriendRequestBannerShown",
    QRPageFriendRequestBannerAccepted = "QRPageFriendRequestBannerAccepted",
    QRPageFriendRequestBannerDismissed = "QRPageFriendRequestBannerDismissed",
    QRCodeScannerOpened = "QRCodeScannerOpened",
    QRCodeScannerTooltipShown = "QRCodeScannerTooltipShown",
    RefreshQrSession = "RefreshQrSession"
})
