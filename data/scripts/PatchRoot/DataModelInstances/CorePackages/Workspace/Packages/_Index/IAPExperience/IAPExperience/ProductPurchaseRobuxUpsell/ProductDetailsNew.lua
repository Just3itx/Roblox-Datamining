-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:20:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local Roact = require(scriptParentParentParent.Roact)

local RoactFitComponents = require(scriptParentParentParent.RoactFitComponents)
local FitFrameVertical = RoactFitComponents.FitFrameVertical
local FitTextLabel = RoactFitComponents.FitTextLabel

local UIBlox = require(scriptParentParentParent.UIBlox)

local Images = UIBlox.App.ImageSet.Images
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local IconSize = UIBlox.App.Constant.IconSize
local withStyle = UIBlox.Core.Style.withStyle

local ModelViewport = require(scriptParentParent.Generic.ModelViewport)
local Constants = require(scriptParentParent.Generic.Constants)

local getEnableCondenseRobuxUpsell = require(scriptParentParent.Flags.getEnableCondenseRobuxUpsell)

local iconsCommonRobux = Images["icons/common/robux"]
local iconsStatusImageunavailable = Images["icons/status/imageunavailable"]

local FFlagPopularFillIconEnabled = require(scriptParentParent.Flags.FFlagPopularFillIconEnabled)
local GetFStringPopularFillIconLocation = require(scriptParentParent.Flags.GetFStringPopularFillIconLocation)
local Image = if FFlagPopularFillIconEnabled then Images[GetFStringPopularFillIconLocation()] else nil
local uDim2 = if FFlagPopularFillIconEnabled then UDim2.new(0, 16, 0, 16) else UDim2.new(0, 0, 0, 0)
local var2 = Roact.Component:extend(script.Name)

function var2.init(arg1)
    arg1.contentRef = Roact.createRef()
    arg1.state = {
        contentSize = Vector2.new(0, 0)
    }
    function arg1.changeContentSize(arg2)
        if arg1.state.contentSize ~= arg2.AbsoluteSize then
            arg1:setState({ contentSize = arg2.AbsoluteSize })
        end
    end
end

local function getPopularityThreshold(catalogSize: number, userVariant: number): number
    if userVariant ~= 1 and userVariant ~= 2 then
        return 0
    end

    if catalogSize <= 2 then
        return 0
    end

    if catalogSize <= 5 then
        return 1
    end

    if catalogSize <= 7 then
        if userVariant == 1 then
            return 1
        end

        return 2
    end

    if catalogSize <= 9 then
        if userVariant == 1 then
            return 2
        end

        if catalogSize <= 8 then
            return 2
        end

        return 3
    end

    if catalogSize <= 20 then
        if userVariant == 1 then
            return 2
        end

        return 4
    end

    if catalogSize <= 50 then
        if userVariant == 1 then
            return 3
        end

        return 5
    end

    if catalogSize <= 100 then
        if userVariant == 1 then
            return 4
        end

        return 7
    end

    if userVariant == 1 then
        return 7
    end

    return 12
end

local function createItemBadge(_, props)
    local popularIcon = if FFlagPopularFillIconEnabled and props.isPopularItem then Roact.createElement(
        ImageSetLabel,
        {
            Size = uDim2,
            BackgroundTransparency = 1,
            Image = Image,
            ImageColor3 = Color3.fromRGB(0, 0, 0),
            LayoutOrder = 1
        }
    ) else nil
    local tbl1 = {
        UIListLayout = Roact.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 1)
        }),
        TextLabel = Roact.createElement("TextLabel", {
            Text = props.badgeText,
            BackgroundTransparency = 1,
            Size = UDim2.new(0, 34, 0, 12),
            AutomaticSize = Enum.AutomaticSize.X,
            TextColor3 = Color3.fromRGB(25, 27, 29),
            Font = Enum.Font.BuilderSansBold,
            TextSize = 12,
            TextYAlignment = Enum.TextYAlignment.Center,
            TextXAlignment = Enum.TextXAlignment.Left,
            LayoutOrder = 2
        }),
        UIPadding = Roact.createElement("UIPadding", {
            PaddingLeft = UDim.new(0, 4),
            PaddingRight = UDim.new(0, 8),
            PaddingTop = UDim.new(0, 2),
            PaddingBottom = UDim.new(0, 2)
        }),
        UICorner = Roact.createElement("UICorner", { CornerRadius = UDim.new(1, 8) }),
        UIStroke = Roact.createElement("UIStroke", { Color = Color3.fromRGB(206, 183, 115), Thickness = 1 })
    }

    if popularIcon then
        tbl1.PopularIcon = popularIcon
    end

    return Roact.createElement("Frame", {
        BackgroundTransparency = 0,
        Size = UDim2.new(0, 44, 0, 20),
        BackgroundColor3 = Color3.fromRGB(239, 215, 109),
        AutomaticSize = Enum.AutomaticSize.XY,
        LayoutOrder = 3,
        AnchorPoint = Vector2.new(0, 1)
    }, tbl1)
end

local function createItemIconComponent(image, xOffset: number?, yOffset: number?, theme, _)
    local tbl1 = {
        ItemImage = Roact.createElement(ImageSetLabel, {
            BackgroundTransparency = 1,
            Size = UDim2.new(0, xOffset, 0, yOffset),
            ScaleType = Enum.ScaleType.Stretch,
            Image = image,
            ImageTransparency = if image ~= iconsStatusImageunavailable then 0 else theme.UIDefault.Transparency or 0,
            ImageColor3 = image == iconsStatusImageunavailable and theme.UIDefault.Color or Color3.new(1, 1, 1)
        })
    }

    return Roact.createElement(FitFrameVertical, {
        BackgroundTransparency = 1,
        width = UDim.new(1, 0),
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        VerticalAlignment = Enum.VerticalAlignment.Top,
        LayoutOrder = 1
    }, tbl1)
end

local function createItemDetailsComponent(props, maximumWidth: number, theme, font)
    local tbl1 = {
        ItemName = Roact.createElement(FitTextLabel, {
            LayoutOrder = 1,
            BackgroundTransparency = 1,
            width = FitTextLabel.Width.FitToText,
            maximumWidth = maximumWidth * 0.55,
            Font = font.Header2.Font,
            Text = props.itemName,
            TextSize = font.BaseSize * font.Header2.RelativeSize,
            TextColor3 = theme.TextEmphasis.Color,
            TextWrapped = true,
            TextXAlignment = Enum.TextXAlignment.Left
        }),
        ItemCostFrame = 0
    }
    local createElement = Roact.createElement
    local var3 = FitFrameVertical
    local tbl2 = {
        LayoutOrder = 2,
        BackgroundTransparency = 1,
        width = UDim.new(0.5, 0),
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        VerticalAlignment = Enum.VerticalAlignment.Top,
        contentPadding = UDim.new(0, 2)
    }
    local tbl3 = {
        RobuxIcon = Roact.createElement(ImageSetLabel, {
            LayoutOrder = 1,
            BackgroundTransparency = 1,
            Size = UDim2.new(0, 24, 0, 24),
            ScaleType = Enum.ScaleType.Stretch,
            Image = iconsCommonRobux,
            ImageColor3 = theme.IconEmphasis.Color,
            ImageTransparency = theme.IconEmphasis.Transparency
        }),
        ItemCost = Roact.createElement(FitTextLabel, {
            LayoutOrder = 2,
            BackgroundTransparency = 1,
            TextWrapped = true,
            width = FitTextLabel.Width.FitToText,
            maximumWidth = maximumWidth,
            Font = font.Header2.Font,
            Text = tostring(props.itemRobuxCost),
            TextSize = font.BaseSize * font.Header2.RelativeSize,
            TextColor3 = theme.TextEmphasis.Color
        })
    }
    tbl1.ItemCostFrame = createElement(var3, tbl2, tbl3)

    if props.userVariant
        and props.catalogSize
        and props.salesRank
        and getPopularityThreshold(props.catalogSize, props.userVariant) >= props.salesRank
    then
        tbl1.ItemBadge = createItemBadge(font, props)
    end

    return Roact.createElement(FitFrameVertical, {
        LayoutOrder = 2,
        BackgroundTransparency = 1,
        width = UDim.new(0.45, 0),
        FillDirection = Enum.FillDirection.Vertical,
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        contentPadding = UDim.new(0, 5)
    }, tbl1)
end

function var2.render(arg1)
    local props = arg1.props

    return withStyle(function(arg2)
        local theme = arg2.Theme
        local font = arg2.Font

        local normalIconSize = Constants.NORMAL_ICON_SIZE
        if props.model == nil and props.itemIcon == nil then
            normalIconSize = IconSize.Large
        end

        local xOffset = if getEnableCondenseRobuxUpsell() then props.itemIconWidth or normalIconSize else normalIconSize

        if getEnableCondenseRobuxUpsell() then
            normalIconSize = props.itemIconHeight or normalIconSize
        end

        local var3

        if props.model ~= nil then
            var3 = Roact.createElement(
                ModelViewport,
                {
                    model = props.model,
                    Position = UDim2.fromOffset(5, 5),
                    Size = UDim2.fromOffset(xOffset, normalIconSize)
                }
            )
        else
            local var4 = props.itemIcon or iconsStatusImageunavailable
            var3 = createItemIconComponent(var4, xOffset, normalIconSize, theme, props)
        end

        local itemDetailsFrame = createItemDetailsComponent(props, arg1.state.contentSize.X, theme, font)

        return Roact.createElement(FitFrameVertical, {
            LayoutOrder = props.layoutOrder,
            BackgroundTransparency = 1,
            width = UDim.new(1, 0),
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            contentPadding = UDim.new(0, 6),
            [Roact.Ref] = arg1.contentRef,
            [Roact.Change.AbsoluteSize] = arg1.changeContentSize
        }, {
            ItemIconFrame = Roact.createElement(FitFrameVertical, {
                LayoutOrder = 1,
                BackgroundTransparency = 1,
                width = UDim.new(0.45, 0),
                HorizontalAlignment = Enum.HorizontalAlignment.Right,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                margin = { top = 0, bottom = 0, left = 0, right = 20 }
            }, { ItemIcon = var3 }),
            ItemDetailsFrame = itemDetailsFrame
        })
    end)
end

return var2
