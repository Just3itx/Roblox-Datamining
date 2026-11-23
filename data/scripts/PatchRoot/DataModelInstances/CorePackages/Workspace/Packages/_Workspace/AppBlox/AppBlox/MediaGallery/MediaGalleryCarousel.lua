-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:30:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppBloxParent = script:FindFirstAncestor("AppBlox").Parent
local Cryo = require(AppBloxParent.Cryo)
local React = require(AppBloxParent.React)

local UIBlox = require(AppBloxParent.UIBlox)
local Button = UIBlox.App.Button.Button
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local Images = UIBlox.App.ImageSet.Images
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel

local _MediaGalleryTypes = require(script.Parent.MediaGalleryTypes)

local uDim2 = UDim2.fromScale(0.4, 0.512)
local uDim2_2 = UDim2.fromScale(0.25, 0.33)

local tbl1 = {
    numItemsShown = 3.5,
    itemAspectRatio = 16 / 9,
    itemPadding = 16,
    borderRadius = UDim.new(0, 8)
}

local function MediaGalleryCarousel(tbl2)
    local var1 = Cryo.Dictionary.join(tbl1, tbl2)
    local var2, var3 = React.useState(Vector2.zero)

    local var4 = React.useCallback(function(arg1)
        local var4 = var1.itemPadding * (var1.numItemsShown - 1)

        local x = (arg1.AbsoluteSize.X - var4) / var1.numItemsShown

        var3(Vector2.new(x, x / var1.itemAspectRatio))
    end, { var1.itemAspectRatio, var1.numItemsShown })

    local var5 = React.useCallback(function(arg1)
        if var1.onVideoPlayActivated and var1.items[arg1].isYouTubeVideo then
            return var1.onVideoPlayActivated(arg1)
        end

        if var1.onPreviewActivated then
            return var1.onPreviewActivated(arg1)
        end
    end, { var1.items, var1.onVideoPlayActivated, var1.onPreviewActivated })

    local tbl3 = ({})
    for layoutOrder, item in var1.items do
        local var6 = "Item" .. layoutOrder
        local createElement = React.createElement
        local str1 = "ImageButton"
        local tbl4 = {
            LayoutOrder = layoutOrder,
            Size = UDim2.fromOffset(var2.X, var2.Y),
            Image = item.imageId,
            ScaleType = Enum.ScaleType.Crop,
            BackgroundTransparency = 1,
            AutoButtonColor = false
        }

        tbl4[React.Event.Activated] = function()
            var5(layoutOrder)
        end
        local tbl5 = {
            Corner = React.createElement("UICorner", { CornerRadius = var1.borderRadius }),
            PlayButton = 0,
            PlayIcon = 0
        }
        local var7

        if item.isYouTubeVideo then
            local createElement2 = React.createElement
            local var8 = Button
            local tbl6 = {
                buttonType = ButtonType.PrimaryContextual,
                size = uDim2,
                anchorPoint = Vector2.new(0.5, 0.5),
                position = UDim2.fromScale(0.5, 0.5),
                onActivated = 0
            }

            function tbl6.onActivated()
                var5(layoutOrder)
            end

            var7 = createElement2(var8, tbl6)
        else
            var7 = nil
        end

        tbl5.PlayButton = var7
        local element = if item.isYouTubeVideo then React.createElement(ImageSetLabel, {
            Size = uDim2_2,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5),
            Image = Images["icons/common/play"],
            BackgroundTransparency = 1,
            ZIndex = 2
        }) else nil
        tbl5.PlayIcon = element
        tbl3[var6] = createElement(str1, tbl4, tbl5)
    end

    return React.createElement("ScrollingFrame", {
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        AutomaticCanvasSize = Enum.AutomaticSize.XY,
        ScrollBarImageTransparency = 1,
        ScrollingDirection = Enum.ScrollingDirection.X,
        ClipsDescendants = false,
        [React.Change.AbsoluteSize] = var4
    }, {
        Layout = React.createElement("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            FillDirection = Enum.FillDirection.Horizontal,
            Padding = UDim.new(0, var1.itemPadding)
        }),
        Items = React.createElement(React.Fragment, {}, tbl3)
    })
end

return MediaGalleryCarousel
