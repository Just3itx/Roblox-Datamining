-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T08:00:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local NavigationRodux = script:FindFirstAncestor("NavigationRodux")
local NavigationRoduxParent = NavigationRodux.Parent

local ArgCheck = require(NavigationRoduxParent.ArgCheck)
local NavigateDown = require(NavigationRodux.Thunks.NavigateDown)
local RobloxAppEnums = require(NavigationRoduxParent.RobloxAppEnums)
local UrlBuilder = require(NavigationRoduxParent.UrlBuilder)

local AppPage = RobloxAppEnums.AppPage
local UrlBuilder2 = UrlBuilder.UrlBuilder

return function(onClose)
    ArgCheck.isTypeOrNil(onClose, "function", "onClose")

    return NavigateDown({
        name = AppPage.SettingsSubPage,
        detail = UrlBuilder2.static.settings.notifications(),
        extraProps = {
            titleKey = "Feature.AccountSettings.Heading.Tab.Notifications",
            onClose = onClose
        }
    })
end
