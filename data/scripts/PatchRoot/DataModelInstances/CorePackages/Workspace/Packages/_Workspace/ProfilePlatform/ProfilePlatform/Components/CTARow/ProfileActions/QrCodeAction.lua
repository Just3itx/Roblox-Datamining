-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T04:51:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local IconName = require(ProfilePlatformParent.Foundation).Enums.IconName

local Enums = require(ProfilePlatform.Common.Enums)
local _Types = require(ProfilePlatform.Components.CTARow.Types)
local EventNames = require(ProfilePlatform.Analytics.EventNames)
local ProfileTypes = Enums.ProfileTypes

local module = {}
module[Enums.ProfileActions.QrCode] = function(arg1)
    local tbl1 = {
        icon = IconName.SquaresGridQr,
        onActivated = 0
    }
    local onActivated = {}
    onActivated[ProfileTypes.User] = function()
        arg1.analytics.fireAnalyticsEvent(EventNames.CTAButtonShareProfileQRCode, { buttonSurface = arg1.buttonSurface })

        arg1.navigateTo.qRCodePage()
    end

    tbl1.onActivated = onActivated
    return tbl1
end

return module
