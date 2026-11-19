-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:51:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")

local scriptParentParent = script.Parent.Parent
local SetMenuOpen = require(scriptParentParent.Actions.SetMenuOpen)
local SendAnalytics = require(scriptParentParent.Utility.SendAnalytics)
local Constants = require(scriptParentParent.Resources.Constants)
local SetCurrentPage = require(scriptParentParent.Actions.SetCurrentPage)
local SetMenuIconTooltipOpen = require(scriptParentParent.Actions.SetMenuIconTooltipOpen)

return function(source)
    return function(arg1)
        GuiService:SetMenuIsOpen(true, "InGameMenu")
        arg1:dispatch(SetMenuOpen(true))
        arg1:dispatch(SetCurrentPage(Constants.MainPagePageKey))

        if arg1:getState().nativeClosePrompt.menuIconTooltipOpen then
            arg1:dispatch(SetMenuIconTooltipOpen(false))
        end

        SendAnalytics(Constants.AnalyticsMenuOpenName, Constants.AnalyticsMenuActionName, { source = source })
    end
end
