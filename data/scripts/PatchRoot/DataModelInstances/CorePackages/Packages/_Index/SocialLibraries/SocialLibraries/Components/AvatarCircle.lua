-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:41:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialLibraries = script:FindFirstAncestor("SocialLibraries")
local dependencies = require(SocialLibraries.dependencies)

local Roact = dependencies.Roact
local ImageSetLabel = dependencies.UIBlox.Core.ImageSet.ImageSetLabel

local var1 = Roact.PureComponent:extend("AvatarCircle")

var1.PresetSize = { Size36x36 = "Size36x36", Size48x48 = "Size48x48" }

local tbl1 = {
    [var1.PresetSize.Size36x36] = "rbxasset://textures/ui/LuaChat/graphic/gr-profile-border-36x36.png",
    [var1.PresetSize.Size48x48] = "rbxasset://textures/ui/LuaChat/graphic/gr-profile-border-48x48.png"
}

var1.defaultProps = {
    thumbnails = {},
    onActivated = nil,
    circleColor3 = Color3.new(0.9, 0.9, 0.9),
    circleTransparency = 0,
    circleInteriorBackgroundColor3 = Color3.new(0.8, 0.8, 0.8),
    circleInteriorBackgroundTransparency = 0,
    circleDividerColor3 = Color3.new(0.7, 0.7, 0.7),
    circleDividerTransparency = 0,
    overlaySize = var1.PresetSize.Size48x48,
    presenceImage = nil,
    presenceIndicatorSize = 14
}

local function createAlignedContainerElement(horizontalAlignment: Enum.HorizontalAlignment)
    return {
        layout = Roact.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            HorizontalAlignment = horizontalAlignment,
            SortOrder = Enum.SortOrder.LayoutOrder
        })
    }
end

function var1.generateThumbnails(arg1, arg2)
    local num1 = #arg2
    local num2 = num1 / 2
    local num3 = num1 % 2 == 0 and num2 or math.floor(num2)
    local num4 = num1 - num3
    local element

    if num1 ~= 1 then
        element = nil
    elseif arg1.props.showNewPresenceImage then
        element = Roact.createElement(ImageSetLabel, {
            Size = UDim2.new(0, arg1.props.presenceIndicatorSize, 0, arg1.props.presenceIndicatorSize),
            BackgroundTransparency = 1,
            Image = arg1.props.presenceImage,
            ImageColor3 = arg1.props.presenceImageColor3,
            ImageTransparency = arg1.props.presenceImageTransparency
        })
    else
        element = Roact.createElement("ImageLabel", {
            Size = UDim2.new(0, arg1.props.presenceIndicatorSize, 0, arg1.props.presenceIndicatorSize),
            BackgroundTransparency = 1,
            Image = arg1.props.presenceImage
        })
    end

    local leftElements = createAlignedContainerElement(Enum.HorizontalAlignment.Right)
    local rightElements = createAlignedContainerElement(Enum.HorizontalAlignment.Left)
    local centerElements = createAlignedContainerElement(Enum.HorizontalAlignment.Center)

    for i, image in ipairs(arg2) do
        local xScale = 0

        local var2 = nil
        local var3, var4

        if num1 == 1 then
            var3 = UDim2.new(1, 0, 1, 0)
            var4 = centerElements
        elseif i <= num3 then
            var3 = UDim2.new(1 / num3, 0, 1 / num3, 0)

            if num1 == 3 or num1 == 2 then
                xScale = 0.125
            end

            local createElement = Roact.createElement
            local tbl2 = {
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                ZIndex = 2
            }

            local tbl3 = {
                border = Roact.createElement("Frame", {
                    Size = UDim2.new(1, 0, 0, 2),
                    Position = UDim2.new(0, 0, 1, -1),
                    BorderSizePixel = 0,
                    BackgroundColor3 = arg1.props.circleDividerColor3,
                    BackgroundTransparency = arg1.props.circleDividerTransparency
                }),
                borderVertical = Roact.createElement("Frame", {
                    Size = UDim2.new(0, 2, 1, 0),
                    Position = UDim2.new(0, -1, 0, 0),
                    BorderSizePixel = 0,
                    BackgroundColor3 = arg1.props.circleDividerColor3,
                    BackgroundTransparency = arg1.props.circleDividerTransparency
                })
            }
            var2 = createElement("Frame", tbl2, tbl3)
            var4 = leftElements
        else
            var3 = UDim2.new(1 / num4, 0, 1 / num4, 0)

            if num1 == 2 then
                xScale = -0.125
            end

            local createElement = Roact.createElement
            local tbl2 = {
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                ZIndex = 2
            }

            local tbl3 = {
                border = Roact.createElement("Frame", {
                    Size = UDim2.new(1, 0, 0, 2),
                    Position = UDim2.new(0, 0, 0, -1),
                    BorderSizePixel = 0,
                    BackgroundColor3 = arg1.props.circleDividerColor3,
                    BackgroundTransparency = arg1.props.circleDividerTransparency
                }),
                borderVertical = Roact.createElement("Frame", {
                    Size = UDim2.new(0, 2, 1, 0),
                    Position = UDim2.new(0, -1, 0, 0),
                    BorderSizePixel = 0,
                    BackgroundColor3 = arg1.props.circleDividerColor3,
                    BackgroundTransparency = arg1.props.circleDividerTransparency
                })
            }
            var2 = createElement("Frame", tbl2, tbl3)
            var4 = rightElements
        end

        local str1 = "thumbnail-" .. tostring(i + 1)
        local createElement = Roact.createElement
        local tbl2 = {
            BackgroundTransparency = 1,
            Size = var3,
            ClipsDescendants = true,
            LayoutOrder = #var4 + 1
        }
        local tbl3 = { headshotContainer = 0, borderObject = 0 }
        local createElement2 = Roact.createElement
        local tbl4 = {
            Size = UDim2.new(1, 0, 1, 0),
            Position = UDim2.new(xScale, 0, 0, 0),
            BackgroundTransparency = 1
        }
        local tbl5 = {
            headshot = Roact.createElement("ImageLabel", { Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, Image = image })
        }
        tbl3.headshotContainer = createElement2("Frame", tbl4, tbl5)

        tbl3.borderObject = var2
        var4[str1] = createElement("Frame", tbl2, tbl3)
    end

    return {
        rightElements = rightElements,
        leftElements = leftElements,
        centerElements = centerElements,
        presenceIndicator = element
    }
end

function var1.render(arg1)
    local thumbnails = arg1.props.thumbnails
    local image = tbl1[arg1.props.overlaySize]

    local var3 = arg1:generateThumbnails(thumbnails)

    return Roact.createElement("ImageButton", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = arg1.props.circleInteriorBackgroundColor3,
        BackgroundTransparency = arg1.props.circleInteriorBackgroundTransparency,
        BorderSizePixel = 0,
        Image = "",
        AutoButtonColor = false,
        ClipsDescendants = true,
        [Roact.Event.Activated] = arg1.props.onActivated
    }, {
        imageMask = Roact.createElement("ImageLabel", {
            Image = image,
            ImageColor3 = arg1.props.circleColor3,
            ImageTransparency = arg1.props.circleTransparency,
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0
        }, {
            presenceFrame = Roact.createElement("Frame", {
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 1, 0)
            }, {
                layout = Roact.createElement(
                    "UIListLayout",
                    {
                        HorizontalAlignment = Enum.HorizontalAlignment.Right,
                        VerticalAlignment = Enum.VerticalAlignment.Bottom
                    }
                ),
                presenceIndicator = var3.presenceIndicator
            })
        }),
        center = Roact.createElement("Frame", {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1
        }, {
            elementContainer = Roact.createElement("Frame", { Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1 }, var3.centerElements)
        }),
        left = Roact.createElement(
            "Frame",
            {
                Size = UDim2.new(1, -1, 1, 0),
                Position = UDim2.new(-0.5, 0, 0, 0),
                BackgroundTransparency = 1
            },
            {
                elementContainer = Roact.createElement("Frame", { Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1 }, var3.leftElements)
            }
        ),
        right = Roact.createElement(
            "Frame",
            {
                Size = UDim2.new(1, -1, 1, 0),
                Position = UDim2.new(0.5, -2, 0, 0),
                BackgroundTransparency = 1
            },
            {
                elementContainer = Roact.createElement("Frame", { Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1 }, var3.rightElements)
            }
        )
    })
end

return var1
