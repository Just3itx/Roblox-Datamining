-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:38:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParentParent = scriptParent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent

local Roact = require(scriptParentParentParentParentParent.Roact)
local t = require(scriptParentParentParentParentParent.t)
local FitFrameVertical = require(scriptParentParentParentParentParent.FitFrame).FitFrameVertical

local Images = require(scriptParentParentParent.ImageSet.Images)
local withStyle = require(scriptParentParentParentParent.Core.Style.withStyle)
local ImageSetComponent = require(scriptParentParentParentParent.Core.ImageSet.ImageSetComponent)

local getModalWindowWidth = require(scriptParent.getModalWindowWidth)

local rect = Rect.new(8, 8, 9, 9)

local var1 = Roact.PureComponent:extend("ModalWindow")

var1.validateProps = t.strictInterface({
    isFullHeight = t.boolean,
    screenSize = t.Vector2,
    [Roact.Children] = t.table,
    position = t.optional(t.UDim2),
    anchorPoint = t.optional(t.Vector2),
    distanceFromTop = t.optional(t.number)
})

var1.defaultProps = { distanceFromTop = 0 }

function var1.init(arg1)
    local contentSize, changeContentSize = Roact.createBinding(Vector2.new(0, 0))
    arg1.contentSize = contentSize
    arg1.changeContentSize = changeContentSize
end

function var1.isFullWidth(_, arg1): boolean
    return arg1 < 540
end

function var1.render(arg1)
    return withStyle(function(arg2)
        local theme = arg2.Theme
        local screenSize = arg1.props.screenSize

        local uDim = UDim.new(0, getModalWindowWidth(screenSize.X))
        local var2, var3, str1

        if arg1:isFullWidth(screenSize.X) then
            var2 = Vector2.new(0.5, 1)

            var3 = arg1.props.position or UDim2.new(0.5, 0, 1, 0)
            str1 = "component_assets/bullet_17"
        else
            var2 = Vector2.new(0.5, 0.5)

            var3 = arg1.props.position or UDim2.new(0.5, 0, 0.5, 0)
            str1 = "component_assets/circle_17"
        end

        local anchorPoint = arg1.props.anchorPoint or var2

        if arg1.props.isFullHeight then
            local y

            if arg1.props.distanceFromTop > 0 then
                y = UDim.new(1, -arg1.props.distanceFromTop)
            else
                y = UDim.new(1, 0)
                if screenSize.X >= 540 and screenSize.Y >= 700 then
                    y = UDim.new(0.8, 0)
                end
            end
            return Roact.createElement(ImageSetComponent.Button, {
                Position = var3,
                Size = UDim2.new(uDim, y),
                AnchorPoint = anchorPoint,
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Image = Images[str1],
                ImageColor3 = theme.BackgroundUIDefault.Color,
                ImageTransparency = theme.BackgroundUIDefault.Transparency,
                ScaleType = Enum.ScaleType.Slice,
                SliceCenter = rect,
                AutoButtonColor = false,
                ClipsDescendants = true,
                Selectable = false
            }, {
                BackgroundImage = Roact.createElement(ImageSetComponent.Label, {
                    Size = UDim2.new(1, 0, 1, 0),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Position = UDim2.new(0.5, 0, 0.5, 0),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0
                }, arg1.props[Roact.Children])
            })
        end
        local createElement = Roact.createElement
        local button = ImageSetComponent.Button

        local tbl1 = {
            Position = var3,
            Size = arg1.contentSize:map(function(arg3): UDim2
                return UDim2.new(0, arg3.X, 0, arg3.Y)
            end),
            AnchorPoint = anchorPoint,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Image = Images[str1],
            ImageColor3 = theme.BackgroundUIDefault.Color,
            ImageTransparency = theme.BackgroundUIDefault.Transparency,
            ScaleType = Enum.ScaleType.Slice,
            SliceCenter = rect,
            AutoButtonColor = false,
            ClipsDescendants = true,
            Selectable = false
        }

        local tbl2 = { BackgroundImage = 0 }
        local createElement2 = Roact.createElement
        local var5 = FitFrameVertical
        local tbl3 = {
            Position = UDim2.new(0.5, 0, 0.5, 0),
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            width = uDim
        }

        tbl3[Roact.Change.AbsoluteSize] = function(arg3)
            arg1.changeContentSize(arg3.AbsoluteSize)
        end

        tbl2.BackgroundImage = createElement2(var5, tbl3, arg1.props[Roact.Children])
        return createElement(button, tbl1, tbl2)
    end)
end

return var1
