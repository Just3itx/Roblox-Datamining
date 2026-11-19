-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:51:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")

local scriptParentParent = script.Parent.Parent
local SetMenuOpen = require(scriptParentParent.Actions.SetMenuOpen)
local SendAnalytics = require(scriptParentParent.Utility.SendAnalytics)
local Constants = require(scriptParentParent.Resources.Constants)
local SetCurrentPage = require(scriptParentParent.Actions.SetCurrentPage)

return function(arg1)
    GuiService:SetMenuIsOpen(false, "InGameMenu")
    GuiService.SelectedCoreObject = nil
    arg1:dispatch(SetMenuOpen(false))
    arg1:dispatch(SetCurrentPage(Constants.InitalPageKey))
    SendAnalytics(Constants.AnalyticsMenuCloseName, Constants.AnalyticsMenuActionName, {})
end
