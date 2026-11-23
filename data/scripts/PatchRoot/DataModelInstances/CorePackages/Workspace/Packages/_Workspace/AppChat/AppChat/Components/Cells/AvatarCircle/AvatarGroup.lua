-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:10:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent
local React = require(AppChatParent.React)

local Frame = require(AppChat.Components.Common.Frame)
local UIListLayout = require(AppChat.Components.Common.UIListLayout)
local AvatarThumbnail = require(script.Parent.AvatarThumbnail)
local CircleMask = require(script.Parent.CircleMask)

local function AvatarGroup(tbl1)
    local thumbnailsLen = #tbl1.thumbnails
    local num1 = thumbnailsLen / 2
    local num2 = thumbnailsLen % 2 == 0 and num1 or math.floor(num1)
    local num3 = thumbnailsLen - num2

    local tbl2 = {}
    local tbl3 = {}

    for layoutOrder, thumbnail in tbl1.thumbnails do
        local xScale = 0
        local var1, var2, var3

        if layoutOrder <= num2 then
            var1 = UDim2.new(1 / num2, 0, 1 / num2, 0)

            if thumbnailsLen == 3 or thumbnailsLen == 2 then
                xScale = 0.125
            end

            local createElement = React.createElement
            local var4 = Frame
            local tbl4 = {
                Size = UDim2.fromScale(1, 1),
                ZIndex = 2
            }
            local tbl5 = {
                border = React.createElement(Frame, {
                    Size = UDim2.new(1, 0, 0, 2),
                    Position = UDim2.new(0, 0, 1, -1),
                    BackgroundColor3 = tbl1.circleDividerColor3,
                    BackgroundTransparency = tbl1.circleDividerTransparency
                }),
                borderVertical = React.createElement(Frame, {
                    Size = UDim2.new(0, 2, 1, 0),
                    Position = UDim2.new(0, -1, 0, 0),
                    BackgroundColor3 = tbl1.circleDividerColor3,
                    BackgroundTransparency = tbl1.circleDividerTransparency
                })
            }
            var2 = createElement(var4, tbl4, tbl5)
            var3 = tbl2
        else
            var1 = UDim2.new(1 / num3, 0, 1 / num3, 0)

            if thumbnailsLen == 2 then
                xScale = -0.125
            end

            local createElement = React.createElement
            local var4 = Frame

            local tbl4 = {
                border = React.createElement(Frame, {
                    Size = UDim2.new(1, 0, 0, 2),
                    Position = UDim2.new(0, 0, 0, -1),
                    BackgroundColor3 = tbl1.circleDividerColor3,
                    BackgroundTransparency = tbl1.circleDividerTransparency
                }),
                borderVertical = React.createElement(Frame, {
                    Size = UDim2.new(0, 2, 1, 0),
                    Position = UDim2.new(0, -1, 0, 0),
                    BackgroundColor3 = tbl1.circleDividerColor3,
                    BackgroundTransparency = tbl1.circleDividerTransparency
                })
            }
            var2 = createElement(var4, { ZIndex = 2 }, tbl4)
            var3 = tbl3
        end

        local str1 = "thumbnail-" .. tostring(layoutOrder)
        local createElement = React.createElement
        local var4 = Frame

        local tbl4 = {
            headshotContainer = React.createElement(
                Frame,
                {
                    Size = UDim2.fromScale(1, 1),
                    Position = UDim2.new(xScale, 0, 0, 0)
                },
                {
                    headshot = React.createElement(AvatarThumbnail, { thumbnail = thumbnail })
                }
            ),
            borderObject = var2
        }
        var3[str1] = createElement(var4, { Size = var1, ClipsDescendants = true, LayoutOrder = layoutOrder }, tbl4)
    end

    local fragment = React.createElement(React.Fragment, {}, {
        uiCorner = React.createElement("UICorner", { CornerRadius = UDim.new(1, 0) }),
        left = React.createElement(Frame, {
            Size = UDim2.new(1, -1, 1, 0),
            Position = UDim2.fromScale(-0.5, 0)
        }, {
            elementContainer = React.createElement(
                Frame,
                {
                    Size = UDim2.fromScale(1, 1)
                },
                {
                    layout = React.createElement(UIListLayout, { HorizontalAlignment = Enum.HorizontalAlignment.Right })
                },
                tbl2
            )
        }),
        right = React.createElement(Frame, {
            Size = UDim2.new(1, -1, 1, 0),
            Position = UDim2.new(0.5, -2, 0, 0)
        }, {
            elementContainer = React.createElement(
                Frame,
                {
                    Size = UDim2.fromScale(1, 1)
                },
                {
                    layout = React.createElement(UIListLayout, { HorizontalAlignment = Enum.HorizontalAlignment.Left })
                },
                tbl3
            )
        })
    })

    return React.createElement(CircleMask, {
        circleColor3 = tbl1.circleColor3,
        circleTransparency = tbl1.circleTransparency,
        circleInteriorBackgroundColor3 = tbl1.circleInteriorBackgroundColor3,
        circleInteriorBackgroundTransparency = tbl1.circleInteriorBackgroundTransparency,
        circleDividerColor3 = tbl1.circleDividerColor3,
        circleDividerTransparency = tbl1.circleDividerTransparency,
        LayoutOrder = tbl1.LayoutOrder,
        overlaySize = tbl1.overlaySize,
        onActivated = tbl1.onActivated,
        selectable = tbl1.selectable
    }, { fragment = fragment })
end

return AvatarGroup
