-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T08:00:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local NavigationRodux = script:FindFirstAncestor("NavigationRodux")
local NavigationRoduxParent = NavigationRodux.Parent
local GetFFlagUseCommunitiesTranslation = require(NavigationRoduxParent.SharedFlags).GetFFlagUseCommunitiesTranslation

local NavigateDown = require(NavigationRodux.Thunks.NavigateDown)
local RobloxAppEnums = require(NavigationRoduxParent.RobloxAppEnums)
local UrlBuilder = require(NavigationRoduxParent.UrlBuilder)
local t = require(NavigationRoduxParent.t)

local AppPage = RobloxAppEnums.AppPage
local UrlBuilder2 = UrlBuilder.UrlBuilder

return function(onClose)
    assert(t.callback(onClose) or t.none(onClose), "")
    return NavigateDown({
        name = AppPage.GenericWebPage,
        detail = UrlBuilder2.static.groups(),
        extraProps = {
            titleKey = if GetFFlagUseCommunitiesTranslation() then "CommonUI.Features.Label.Groups" else "CommonUI.Features.Label.sGroups",
            onClose = onClose
        }
    })
end
