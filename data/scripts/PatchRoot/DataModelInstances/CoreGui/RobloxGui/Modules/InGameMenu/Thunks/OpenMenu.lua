-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:51:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")

local scriptParentParent = script.Parent.Parent
local SetMenuOpen = require(scriptParentParent.Actions.SetMenuOpen)
local SendAnalytics = require(scriptParentParent.Utility.SendAnalytics)
local Constants = require(scriptParentParent.Resources.Constants)
local SetCurrentPage = require(scriptParentParent.Actions.SetCurrentPage)

local tbl1 = { Constants.ReportDialogKey }

return function(source, arg1)
    return function(arg2)
        arg1 = arg1 or Constants.defaultPageKey

        if not table.find(tbl1, arg1) then
            if arg1 ~= Constants.InitalPageKey then
                GuiService:SetMenuIsOpen(true, "InGameMenu")
            end

            arg2:dispatch(SetMenuOpen(true))
            arg2:dispatch(SetCurrentPage(arg1))
        end
        SendAnalytics(Constants.AnalyticsMenuOpenName, Constants.AnalyticsMenuActionName, { source = source })
    end
end
