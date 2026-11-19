-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:21:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Roact = require(CorePackages.Packages.Roact)
local CoreGui = game:GetService("CoreGui")
local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local Constants = require(RobloxGui.Modules.TopBar.Constants)
local UIBlox = require(CorePackages.Packages.UIBlox)
local ColorMode = require(CorePackages.Packages.Foundation).Enums.ColorMode
local AppStyleProvider = UIBlox.App.Style.AppStyleProvider
local Dark = ColorMode.Dark

local Promise = require(CorePackages.Packages.Promise)

local SelfViewTooltipFTUX = require(script.Parent.SelfViewTooltipFTUX)

return function(arg1)
    local selfViewTooltipOnCloseGui = Instance.new("ScreenGui")
    selfViewTooltipOnCloseGui.Name = "SelfViewTooltipOnCloseGui"
    selfViewTooltipOnCloseGui.DisplayOrder = -1
    selfViewTooltipOnCloseGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    selfViewTooltipOnCloseGui.Parent = CoreGui

    local var1 = Constants.useDisplayScaleState(Constants.TopBarButtonHeight)
    local xOffset = Constants.useDisplayScaleState(Constants.ScreenSideOffset)

    local element = Roact.createElement(AppStyleProvider, {
        style = { themeName = Dark }
    }, {
        frame = Roact.createElement("Frame", {
            Position = UDim2.fromOffset(xOffset, -var1),
            Size = UDim2.fromOffset(var1, var1),
            BackgroundTransparency = 0,
            Visible = false
        }, {
            tooltip = Roact.createElement(
                SelfViewTooltipFTUX,
                {
                    fallbackText = arg1.fallbackText,
                    translationKey = arg1.translationKey,
                    tooltipLifetime = arg1.tooltipLifetime
                }
            )
        })
    })
    local var2 = Roact.mount(element, selfViewTooltipOnCloseGui, "SelfViewTooltipOnClose")

    Promise.delay(arg1.tooltipLifetime + 5):andThen(function()
        pcall(function()
            Roact.unmount(var2)
        end)
    end)
end
