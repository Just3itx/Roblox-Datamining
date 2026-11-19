-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:11:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local React = require(CorePackages.Packages.React)

local scriptParentParent = script.Parent.Parent
local FTUXSlideshowData = require(scriptParentParent.Resources.FTUXSlideshowData)
local FTUXConstants = require(scriptParentParent.Resources.FTUXConstants)

local _PlatformEnum = require(scriptParentParent.Enums.PlatformEnum)

local Header = require(scriptParentParent.Components.Slideshow.Header)
local Stepper = require(scriptParentParent.Components.Slideshow.Stepper)
local Title = require(scriptParentParent.Components.Slideshow.Title)
local Description = require(scriptParentParent.Components.Slideshow.Description)
local EndItem = require(scriptParentParent.Components.Slideshow.EndItem)

local EventHandler = require(scriptParentParent.Events.EventHandler)

local function FTUXSlideshow(tbl1)
    local var1, var2 = React.useState(1)

    local platform = tbl1.platform
    local var3 = FTUXSlideshowData[platform]
    local panelConstants = FTUXConstants[platform].PanelConstants
    local var4 = var3[var1]

    local contentHeightRatio = panelConstants.CONTENT_HEIGHT_RATIO
    local footerHeightRatio = panelConstants.FOOTER_HEIGHT_RATIO
    local xScale = panelConstants.CONTENT_PADDING / panelConstants.SLIDESHOW_FRAME_WIDTH
    local xScale2 = 1 - 2 * xScale

    local increaseCurrentIndex = React.useCallback(function()
        var2(var1 + 1)
    end, { var1 })

    React.useEffect(function()
        EventHandler.StartEvents(platform, var1, increaseCurrentIndex)

        return function()
            EventHandler.StopEvents(platform, var1)
        end
    end, { var1 })

    return React.createElement(
        "Frame",
        {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 1, 0),
            Position = UDim2.new(0, 0, 0, 0)
        },
        {
            UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(0.05, 0) }),
            SlideshowLayout = React.createElement("UIListLayout", {
                Padding = UDim.new(0.05, 0),
                FillDirection = Enum.FillDirection.Vertical,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                SortOrder = Enum.SortOrder.LayoutOrder
            }),
            Header = React.createElement(Header, { platform = platform }),
            ContentFrame = React.createElement("Frame", {
                LayoutOrder = 2,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, contentHeightRatio, 0),
                Position = UDim2.new(0, 0, 0, 0)
            }, {
                Content = React.createElement(
                    "Frame",
                    {
                        BackgroundTransparency = 1,
                        Size = UDim2.new(xScale2, 0, 1, 0),
                        Position = UDim2.new(xScale, 0, 0, 0)
                    },
                    {
                        ContentLayout = React.createElement("UIListLayout", {
                            Padding = UDim.new(0.05, 0),
                            FillDirection = Enum.FillDirection.Vertical,
                            HorizontalAlignment = Enum.HorizontalAlignment.Center,
                            SortOrder = Enum.SortOrder.LayoutOrder
                        }),
                        Title = React.createElement(Title, { platform = platform, currentIndex = var1 }),
                        Description = React.createElement(Description, { platform = platform, currentIndex = var1 }),
                        ImageFrame = React.createElement(
                            "Frame",
                            {
                                LayoutOrder = 3,
                                BackgroundTransparency = 1,
                                Size = UDim2.new(1.2, 0, 0.4, 0),
                                Position = UDim2.new(0, 0, 0, 0)
                            },
                            {
                                Image = React.createElement("ImageLabel", {
                                    Image = var4.image,
                                    BackgroundTransparency = 1,
                                    Size = UDim2.new(1, 0, 1, 0),
                                    LayoutOrder = 3,
                                    ScaleType = Enum.ScaleType.Fit
                                })
                            }
                        )
                    }
                )
            }),
            FooterFrame = React.createElement("Frame", {
                LayoutOrder = 3,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, footerHeightRatio, 0),
                Position = UDim2.new(0, 0, 0, 0)
            }, {
                Footer = React.createElement(
                    "Frame",
                    {
                        BackgroundTransparency = 1,
                        Size = UDim2.new(xScale2, 0, 1, 0),
                        Position = UDim2.new(xScale, 0, 0, 0)
                    },
                    {
                        ContentLayout = React.createElement("UIListLayout", {
                            Padding = var1 ~= #var3 and UDim.new(0.2, 0) or UDim.new(0, 0),
                            FillDirection = Enum.FillDirection.Vertical,
                            HorizontalAlignment = Enum.HorizontalAlignment.Center,
                            SortOrder = Enum.SortOrder.LayoutOrder
                        }),
                        Stepper = React.createElement(Stepper, { layoutOrder = 1, numberActivated = var1, numberOfSteps = #var3 }, {}),
                        EndItem = React.createElement(EndItem, { platform = platform, currentIndex = var1, increaseCurrentIndex = increaseCurrentIndex })
                    }
                )
            })
        }
    )
end
return FTUXSlideshow
