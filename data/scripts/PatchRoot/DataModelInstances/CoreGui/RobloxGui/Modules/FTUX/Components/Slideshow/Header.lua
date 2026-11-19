-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:11:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local React = require(CorePackages.Packages.React)
local UIBlox = require(CorePackages.Packages.UIBlox)
local useStyle = UIBlox.Core.Style.useStyle

local withLocalization = require(CorePackages.Workspace.Packages.Localization).withLocalization
local scriptParentParentParent = script.Parent.Parent.Parent
local FTUXConstants = require(scriptParentParentParent.Resources.FTUXConstants)

local _PlatformEnum = require(scriptParentParentParent.Enums.PlatformEnum)

local function Header(tbl1)
    local var1 = useStyle()

    local theme = var1.Theme
    local font = var1.Font
    local panelConstants = FTUXConstants[tbl1.platform].PanelConstants

    local backgroundContrastColor = theme.BackgroundContrast.Color

    local headerHeightRatio = panelConstants.HEADER_HEIGHT_RATIO
    local xScale = panelConstants.CONTENT_PADDING / panelConstants.SLIDESHOW_FRAME_WIDTH
    local xScale2 = 1 - 2 * xScale

    return withLocalization({ headerText = "CoreScripts.VRFTUX.Heading.Header" })(function(arg1)
        return React.createElement("Frame", {
            BackgroundColor3 = backgroundContrastColor,
            BackgroundTransparency = 0,
            Size = UDim2.new(1, 0, headerHeightRatio, 0),
            LayoutOrder = 1
        }, {
            UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(0.26, 0) }),
            HeaderFrame = React.createElement(
                "Frame",
                {
                    Size = UDim2.new(1, 0, 1, 0),
                    Position = UDim2.new(0, 0, 0, 0),
                    BackgroundTransparency = 1
                },
                {
                    Box = React.createElement(
                        "Frame",
                        {
                            Size = UDim2.new(xScale2, 0, 1, 0),
                            Position = UDim2.new(xScale, 0, 0, 0),
                            BackgroundTransparency = 1
                        },
                        {
                            HeaderText = React.createElement(UIBlox.App.Text.StyledTextLabel, {
                                text = arg1.headerText,
                                fontStyle = font.Header1,
                                colorStyle = theme.TextEmphasis,
                                textXAlignment = Enum.TextXAlignment.Left,
                                size = UDim2.new(1, 0, 1, 0),
                                fluidSizing = true,
                                automaticSize = Enum.AutomaticSize.XY
                            })
                        }
                    )
                }
            )
        })
    end)
end

return Header
