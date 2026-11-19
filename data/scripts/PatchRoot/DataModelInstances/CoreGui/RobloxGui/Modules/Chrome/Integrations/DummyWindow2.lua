-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:50:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Chrome = script:FindFirstAncestor("Chrome")

local CorePackages = game:GetService("CorePackages")
local React = require(CorePackages.Packages.React)

local Service = require(Chrome.Service)
local CommonIcon = require(Chrome.Integrations.CommonIcon)
local Constants = require(Chrome.ChromeShared.Unibar.Constants)

local tbl1 = {
    initialAvailability = if require(CorePackages.Workspace.Packages.SharedFlags).GetFFlagDebugEnableUnibarDummyIntegrations() then Service.AvailabilitySignal.Available else Service.AvailabilitySignal.Unavailable,
    id = "dummy_window_2",
    label = "CoreScripts.TopBar.Menu",
    startingWindowPosition = UDim2.new(1, -245, 0, 95),
    persistWindowState = true,
    components = {
        Icon = function(_)
            return CommonIcon("icons/menu/home_on")
        end,
        Window = function(_)
            return React.createElement(
                "Frame",
                {
                    BackgroundTransparency = 0,
                    Size = UDim2.new(1, 0, 1, 0)
                },
                {
                    Corner = React.createElement("UICorner", { CornerRadius = Constants.CORNER_RADIUS })
                }
            )
        end
    }
}

return Service:register(tbl1)
