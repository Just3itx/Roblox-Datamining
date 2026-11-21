-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T20:50:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GamePlayButtonParent = script:FindFirstAncestor("GamePlayButton").Parent

local AppPage = require(GamePlayButtonParent.RobloxAppEnums).AppPage
local NavigateDown = require(GamePlayButtonParent.NavigationRodux).Thunks.NavigateDown
local FFlagSignalsNavP3Dispatch = require(GamePlayButtonParent.SharedFlags).FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(GamePlayButtonParent.RobloxAppNavigation).NavigationCommands else nil

local function openFiatPurchasePage(detail, onClose)
    return function(arg1)
        local tbl1 = {
            name = AppPage.GenericWebPage,
            detail = detail,
            extraProps = {
                titleKey = "Feature.PaidAccessPurchases.Webview.Title.Checkout",
                onClose = onClose
            }
        }

        if FFlagSignalsNavP3Dispatch then
            NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl1))
            return
        end
        arg1:dispatch(NavigateDown(tbl1))
    end
end

return openFiatPurchasePage
