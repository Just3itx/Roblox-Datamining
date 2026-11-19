-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:11:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local React = require(CorePackages.Packages.React)
local useStyle = require(CorePackages.Packages.UIBlox).Core.Style.useStyle

local scriptParentParent = script.Parent.Parent
local FTUXSlideshow = require(scriptParentParent.Components.FTUXSlideshow)
local FTUXConstants = require(scriptParentParent.Resources.FTUXConstants)

local _PlatformEnum = require(scriptParentParent.Enums.PlatformEnum)

local xOffset = game:DefineFastInt("FTUXPanelXOffset", 50)

local function FTUXPanel(tbl1)
    local var1 = useStyle()
    local panelConstants = FTUXConstants[tbl1.platform].PanelConstants

    local mainScreenSizeWidth = panelConstants.MAIN_SCREEN_SIZE_WIDTH
    local mainScreenSizeHeight = panelConstants.MAIN_SCREEN_SIZE_HEIGHT
    local slideshowFrameWidth = panelConstants.SLIDESHOW_FRAME_WIDTH
    local slideshowFrameHeight = panelConstants.SLIDESHOW_FRAME_HEIGHT
    local slideshowFrameX = panelConstants.SLIDESHOW_FRAME_X
    local slideshowFrameY = panelConstants.SLIDESHOW_FRAME_Y

    local backgroundDefaultColor = var1.Theme.BackgroundDefault.Color

    return React.createElement(
        "Frame",
        {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 1, 0),
            Position = UDim2.new(0, xOffset, 0, 0)
        },
        {
            Slideshow = React.createElement("Frame", {
                BackgroundColor3 = backgroundDefaultColor,
                BackgroundTransparency = 0,
                Size = UDim2.new(slideshowFrameWidth / mainScreenSizeWidth, 0, slideshowFrameHeight / mainScreenSizeHeight, 0),
                Position = UDim2.new(slideshowFrameX / mainScreenSizeWidth, 0, slideshowFrameY / mainScreenSizeHeight, 0),
                BorderSizePixel = 0,
                ClipsDescendants = true
            }, {
                UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(0.02, 0) }),
                Slideshow = React.createElement(FTUXSlideshow, { platform = tbl1.platform }, {})
            })
        }
    )
end
return FTUXPanel
