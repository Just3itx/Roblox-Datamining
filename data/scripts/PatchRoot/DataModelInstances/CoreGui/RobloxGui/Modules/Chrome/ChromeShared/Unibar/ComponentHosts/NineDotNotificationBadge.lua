-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:31:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChromeShared = script:FindFirstAncestor("ChromeShared")

local CorePackages = game:GetService("CorePackages")
local React = require(CorePackages.Packages.React)

local Service = require(ChromeShared.Service)
local _Chrome = require(CorePackages.Workspace.Packages.Chrome)
local useObservableValue = require(ChromeShared.Hooks.useObservableValue)

local function NineDotNotificationBadge(tbl1)
    local var1 = table.clone(tbl1.iconHostProps)
    var1.showNineDotActivityIndicator = useObservableValue(Service:nineDotActivityIndicatorVisible()) == true

    return React.createElement(tbl1.NotificationBadge, var1)
end

return NineDotNotificationBadge
