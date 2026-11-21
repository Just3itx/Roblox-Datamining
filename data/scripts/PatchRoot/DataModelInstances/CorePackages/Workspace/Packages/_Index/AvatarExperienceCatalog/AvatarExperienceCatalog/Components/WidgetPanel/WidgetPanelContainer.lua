-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:00:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalog = script:FindFirstAncestor("AvatarExperienceCatalog")
local AvatarExperienceCatalogParent = AvatarExperienceCatalog.Parent

local React = require(AvatarExperienceCatalogParent.React)

local _WidgetListBreakPointEnum = require(AvatarExperienceCatalog.Components.ResultsList.WidgetListBreakPointEnum)
local WidgetPanelView = require(script.Parent.WidgetPanelView)
local useWidgetPanelViewModel = require(script.Parent.useWidgetPanelViewModel)

return React.memo(function(tbl1) -- name: WidgetPanelContainer
    local var1 = useWidgetPanelViewModel(tbl1)
    if var1.status ~= "visible" then
        return nil
    end
    return React.createElement(WidgetPanelView, var1.viewProps)
end)
