-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:11:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local React = require(CorePackages.Packages.React)
local UIBlox = require(CorePackages.Packages.UIBlox)
local useStyle = UIBlox.Core.Style.useStyle

local withLocalization = require(CorePackages.Workspace.Packages.Localization).withLocalization
local scriptParentParentParent = script.Parent.Parent.Parent
local FTUXSlideshowData = require(scriptParentParentParent.Resources.FTUXSlideshowData)
local Button = require(scriptParentParentParent.Components.Slideshow.Button)

local _PlatformEnum = require(scriptParentParentParent.Enums.PlatformEnum)

local function EndItem(tbl1)
    local var1 = useStyle()

    local theme = var1.Theme
    local font = var1.Font

    local var2 = FTUXSlideshowData[tbl1.platform]

    return withLocalization({ footerText = "CoreScripts.VRFTUX.Label.Footer" })(function(arg1)
        return tbl1.currentIndex ~= #var2
            and React.createElement(
                Button,
                {
                    platform = tbl1.platform,
                    currentIndex = tbl1.currentIndex,
                    increaseCurrentIndex = tbl1.increaseCurrentIndex
                }
            )
            or React.createElement(UIBlox.App.Text.StyledTextLabel, {
                text = arg1.footerText,
                fontStyle = font.CaptionHeader,
                colorStyle = theme.TextEmphasis,
                textXAlignment = Enum.TextXAlignment.Center,
                textYAlignment = Enum.TextYAlignment.Center,
                size = UDim2.new(1, 0, 1, 0),
                layoutOrder = 2
            })
    end)
end

return EndItem
