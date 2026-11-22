-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T11:31:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfileQRCode = script:FindFirstAncestor("ProfileQRCode")
local ProfileQRCodeParent = ProfileQRCode.Parent

local AnalyticsService = require(ProfileQRCode.Analytics.AnalyticsService)
local Analytics = require(ProfileQRCode.Analytics)

local React = require(ProfileQRCodeParent.React)
local useLocalUserId = require(ProfileQRCodeParent.RobloxAppHooks).useLocalUserId
local ProfileQRCodePage = require(ProfileQRCode.Components.ProfileQRCodePage.ProfileQRCodePage)

return function(tbl1)
    local fireEvent = Analytics.setupFireEvent({
        analytics = if tbl1.analyticsService then tbl1.analyticsService else AnalyticsService,
        infoForAllEvents = {
            uid = useLocalUserId(),
            source = tbl1.source
        }
    })

    return React.createElement(Analytics.Context.Provider, {
        value = { fireEvent = fireEvent }
    }, {
        Window = React.createElement(ProfileQRCodePage, {
            appStorageService = tbl1.appStorageService,
            robloxEventReceiver = tbl1.robloxEventReceiver,
            onClose = tbl1.onClose,
            openQrCodeScanner = tbl1.openQrCodeScanner
        })
    })
end
