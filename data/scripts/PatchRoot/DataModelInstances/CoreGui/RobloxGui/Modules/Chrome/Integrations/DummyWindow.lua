-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:50:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Chrome = script:FindFirstAncestor("Chrome")

local CorePackages = game:GetService("CorePackages")
local React = require(CorePackages.Packages.React)

local Service = require(Chrome.Service)
local CommonIcon = require(Chrome.Integrations.CommonIcon)
local Constants = require(Chrome.ChromeShared.Unibar.Constants)
local WindowSizeSignal = require(Chrome.ChromeShared.Service.WindowSizeSignal)

local UIBlox = require(CorePackages.Packages.UIBlox)
local Images = UIBlox.App.ImageSet.Images
local IconButton = UIBlox.App.Button.IconButton

local GetFFlagDebugEnableUnibarDummyIntegrations = require(CorePackages.Workspace.Packages.SharedFlags).GetFFlagDebugEnableUnibarDummyIntegrations

local iconsNavigationCycleUp = Images["icons/navigation/cycleUp"]
local bool1 = false
local windowSizeSignal = WindowSizeSignal.new(Constants.DEFAULT_WIDTH, Constants.DEFAULT_HEIGHT)
local uDim2 = UDim2.new(1, -95, 0, 165)

local tbl1 = {
    initialAvailability = if GetFFlagDebugEnableUnibarDummyIntegrations() then Service.AvailabilitySignal.Available else Service.AvailabilitySignal.Unavailable,
    id = "dummy_window",
    label = "CoreScripts.TopBar.Menu",
    draggable = true,
    cachePosition = true,
    startingWindowPosition = uDim2,
    windowSize = windowSizeSignal,
    persistWindowState = true,
    components = {
        Icon = function(_)
            return CommonIcon("icons/menu/avatar_on")
        end,
        Window = function(_)
            return React.createElement("Frame", {
                BackgroundTransparency = 0,
                Size = UDim2.new(1, 0, 1, 0)
            }, {
                Corner = React.createElement("UICorner", { CornerRadius = Constants.CORNER_RADIUS }),
                SizeIcon = React.createElement(IconButton, {
                    icon = iconsNavigationCycleUp,
                    iconSize = Constants.CLOSE_ICON_SIZE,
                    anchorPoint = Vector2.new(0.5, 1),
                    position = UDim2.new(0.5, 0, 1, 0),
                    backgroundTransparency = 0.5,
                    onActivated = function()
                        if bool1 then
                            windowSizeSignal:requestSize(Constants.DEFAULT_WIDTH, Constants.DEFAULT_HEIGHT)
                            bool1 = false
                            return
                        end
                        windowSizeSignal:requestSize(Constants.DEFAULT_WIDTH_LARGE, Constants.DEFAULT_HEIGHT_LARGE)
                        bool1 = true
                    end
                })
            })
        end
    }
}

return (Service:register(tbl1))
