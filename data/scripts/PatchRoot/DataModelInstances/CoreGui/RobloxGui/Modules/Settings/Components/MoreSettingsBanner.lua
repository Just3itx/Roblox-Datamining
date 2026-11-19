-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:50:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local React = require(CorePackages.Packages.React)
local Foundation = require(CorePackages.Packages.Foundation)
local Localization = require(CorePackages.Workspace.Packages.Localization)

local scriptParentParent = script.Parent.Parent
local shouldShowMoreSettingsBanner = require(scriptParentParent.shouldShowMoreSettingsBanner)

local useLocalization = Localization.Hooks.useLocalization
local useTokens = Foundation.Hooks.useTokens
local Icon = Foundation.Icon
local IconName = Foundation.Enums.IconName
local IconSize = Foundation.Enums.IconSize
local FoundationText = Foundation.Text
local View = Foundation.View

local function MoreSettingsBanner(tbl1)
    local isPioneerLaunch = tbl1.isPioneerLaunch
    local getAvailability = tbl1.getAvailability
    local var1, var2 = React.useState(false)
    local var3 = useLocalization({ text = "CoreScripts.InGameMenu.GameSettings.MoreSettingsAvailable" })

    local var4 = useTokens()

    React.useEffect(function()
        local bool1 = false

        task.spawn(function()
            local var5 = shouldShowMoreSettingsBanner(isPioneerLaunch, getAvailability)
            if not bool1 and var5 then
                var2(true)
            end
        end)

        return function()
            bool1 = true
        end
    end, { isPioneerLaunch, getAvailability })

    if not var1 or var3.text == "" then
        return nil
    end

    return React.createElement(View, {
        tag = "size-full-0 auto-y",
        padding = {
            left = UDim.new(0, 10),
            right = UDim.new(0, 10),
            bottom = UDim.new(0, var4.Padding.Large)
        }
    }, {
        Banner = React.createElement(View, {
            tag = "row align-y-center gap-small size-full-0 auto-y padding-medium stroke-standard stroke-default radius-medium",
            testId = "MoreSettingsBanner"
        }, {
            Icon = React.createElement(Icon, { LayoutOrder = 1, name = IconName.CircleI, size = IconSize.Small }),
            Label = React.createElement(FoundationText, {
                LayoutOrder = 2,
                Text = var3.text,
                tag = "fill auto-y text-body-medium text-wrap text-align-x-left content-default",
                testId = "MoreSettingsAvailableText"
            })
        })
    })
end

return MoreSettingsBanner
