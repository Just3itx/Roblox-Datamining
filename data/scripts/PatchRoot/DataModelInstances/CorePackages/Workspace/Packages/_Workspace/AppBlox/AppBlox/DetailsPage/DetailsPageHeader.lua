-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:20:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppBloxParent = script:FindFirstAncestor("AppBlox").Parent
local UIBlox = require(AppBloxParent.UIBlox)
local normalizeFontFace = require(AppBloxParent.Foundation).Utility.normalizeFontFace

local withStyle = UIBlox.Core.Style.withStyle
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel

local Images = UIBlox.App.ImageSet.Images
local LoadableImage = UIBlox.App.Loading.LoadableImage
local ActionBar = UIBlox.App.Button.ActionBar

local DeviceType = require(AppBloxParent.RobloxAppEnums).DeviceType

local Roact = require(AppBloxParent.Roact)
local t = require(AppBloxParent.t)

local DetailsPageTitleContent = require(script.Parent.DetailsPageTitleContent)

local FFlagLuaAppFixDetailsPageThumbnailRenderInPhone = require(AppBloxParent.SharedFlags).FFlagLuaAppFixDetailsPageThumbnailRenderInPhone

local bool1 = game:DefineFastFlag("LuaAppBottomAlignDetailsHeaderInfoFrame", false)

local FFlagUIBloxEnableActionBarButtonOverride = require(AppBloxParent.SharedFlags).UIBlox.FFlagUIBloxEnableActionBarButtonOverride
local FFlagUIBloxAddTestIdToActionBar = require(AppBloxParent.SharedFlags).UIBlox.FFlagUIBloxAddTestIdToActionBar

local var1 = Roact.PureComponent:extend("DetailsPageHeader")

var1.defaultProps = {
    thumbnailHeight = 200,
    thumbnailAspectRatio = Vector2.new(1, 1),
    actionBarHeight = 48,
    actionBarWidth = 380
}

var1.validateProps = t.strictInterface({
    thumbnailImageUrl = t.optional(t.string),
    thumbnailAspectRatio = t.optional(t.Vector2),
    thumbnailHeight = t.optional(t.number),
    titleText = t.optional(t.string),
    subTitleText = t.optional(t.string),
    actionBarLabelText = t.optional(t.string),
    renderInfoContent = t.optional(t.callback),
    renderCustomHeader = t.optional(t.callback),
    headerBarBackgroundHeight = t.optional(t.number),
    sideMargin = t.optional(t.number),
    itemPadding = t.optional(t.number),
    bottomMargin = t.optional(t.number),
    gradientHeight = t.optional(t.number),
    thumbnailShadowHeight = t.optional(t.number),
    actionBarHeight = t.optional(t.number),
    actionBarWidth = t.optional(t.number),
    maxContentWidth = t.optional(t.number),
    actionBarProps = t.optional(t.table),
    renderActionBarLabelImpressionsDetector = t.optional(t.callback),
    scrollViewPositionChangedSignal = t.optional(t.table),
    deviceType = t.optional(t.string)
})

function var1.init(arg1)
    arg1.actionBarLabelRef = Roact.createRef()
end

function var1.renderThumbnail(arg1, arg2, arg3, xOffset: number, yOffset: number)
    local createElement = Roact.createElement
    local str1 = "Frame"
    local tbl1 = {
        Size = UDim2.fromOffset(xOffset, yOffset),
        LayoutOrder = 1,
        AnchorPoint = Vector2.new(0, 1),
        Position = UDim2.new(0, 0, 1, 0),
        BackgroundTransparency = 1
    }
    local tbl2 = {
        ThumbnailTile = Roact.createElement(
            LoadableImage,
            {
                cornerRadius = UDim.new(0, 8),
                Size = UDim2.fromScale(1, 1),
                Image = arg1.props.thumbnailImageUrl
            }
        ),
        DropShadow = 0
    }
    local element

    if arg3 > 0 then
        element = Roact.createElement(ImageSetLabel, {
            Size = UDim2.new(1, 0, 0, 28),
            Position = UDim2.fromScale(0, 1),
            BackgroundTransparency = 1,
            Image = Images["component_assets/dropshadow_thumbnail_28"],
            ImageColor3 = arg2.Theme.DropShadow.Color,
            ImageTransparency = arg2.Theme.DropShadow.Transparency,
            ScaleType = Enum.ScaleType.Slice,
            SliceCenter = Rect.new(32, 0, 33, 1)
        })
    else
        element = nil
    end

    tbl2.DropShadow = element
    return createElement(str1, tbl1, tbl2)
end

function var1.renderDesktopMode(arg1, arg2)
    local thumbnailHeight = arg1.props.thumbnailHeight
    local var2 = thumbnailHeight * (arg1.props.thumbnailAspectRatio.X / arg1.props.thumbnailAspectRatio.Y)
    local sideMargin = arg1.props.sideMargin or 48
    local itemPadding = arg1.props.itemPadding or 24

    local var3 = if arg1.props.thumbnailShadowHeight == nil then 28 else arg1.props.thumbnailShadowHeight

    local createElement = Roact.createElement
    local str1 = "Frame"
    local tbl1 = {
        Size = UDim2.new(1, -(var2 + sideMargin * 2), 1, 0),
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.Y,
        LayoutOrder = 2
    }
    local tbl2

    if arg1.props.renderCustomHeader then
        tbl2 = arg1.props.renderCustomHeader()
    else
        tbl2 = {
            Layout = 0,
            TitleInfo = 0,
            ActonBarFrame = 0,
            ActionBarLabel = 0,
            ActionBarLabelImpressionsDetector = 0
        }
        local createElement2 = Roact.createElement
        local str2 = "UIListLayout"
        local tbl3 = {
            SortOrder = Enum.SortOrder.LayoutOrder,
            FillDirection = Enum.FillDirection.Vertical,
            VerticalAlignment = if bool1 then Enum.VerticalAlignment.Bottom else Enum.VerticalAlignment.Top,
            Padding = UDim.new(0, 16)
        }
        tbl2.Layout = createElement2(str2, tbl3)

        tbl2.TitleInfo = Roact.createElement(DetailsPageTitleContent, {
            titleText = arg1.props.titleText,
            subTitleText = arg1.props.subTitleText,
            renderInfoContent = arg1.props.renderInfoContent,
            verticalAlignment = Enum.VerticalAlignment.Top,
            layoutOrder = 1
        })

        local createElement3 = Roact.createElement
        local str3 = "Frame"
        local tbl4 = {
            Size = UDim2.fromOffset(arg1.props.actionBarWidth, arg1.props.actionBarHeight),
            BackgroundTransparency = 1,
            LayoutOrder = 2
        }

        local tbl5 = { ActionBar = 0 }
        local element

        if arg1.props.actionBarProps then
            element = Roact.createElement(ActionBar, {
                button = arg1.props.actionBarProps.button,
                buttonOverride = if FFlagUIBloxEnableActionBarButtonOverride then arg1.props.actionBarProps.buttonOverride else nil,
                icons = arg1.props.actionBarProps.icons,
                iconSize = arg1.props.actionBarProps.iconSize,
                buttonHeight = arg1.props.actionBarProps.buttonHeight,
                buttonPadding = arg1.props.actionBarProps.buttonPadding,
                textButtons = arg1.props.actionBarProps.textButtons,
                enableButtonAtStart = true,
                marginOverride = { left = 0, right = 0, top = 0, bottom = 0 },
                horizontalAlignment = Enum.HorizontalAlignment.Left,
                testId = if FFlagUIBloxAddTestIdToActionBar then "--experience-details" else nil
            })
                or nil
        else
            element = nil
        end

        tbl5.ActionBar = element
        tbl2.ActonBarFrame = createElement3(str3, tbl4, tbl5)
        local element2

        if arg1.props.actionBarLabelText then
            element2 = Roact.createElement("TextLabel", {
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                Text = arg1.props.actionBarLabelText,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextWrapped = true,
                BackgroundTransparency = 1,
                FontFace = normalizeFontFace(arg2.Tokens.Typography.BodyLarge.Font),
                TextSize = arg2.Tokens.FontSize.FontSize_350,
                TextColor3 = arg2.Tokens.Color.Content.Emphasis.Color3,
                TextTransparency = arg2.Tokens.Color.Content.Emphasis.Transparency,
                LayoutOrder = 3,
                [Roact.Ref] = arg1.actionBarLabelRef
            })
        else
            element2 = nil
        end

        tbl2.ActionBarLabel = element2
        local actionBarLabelImpressionsDetector = if arg1.props.actionBarLabelText and arg1.props.renderActionBarLabelImpressionsDetector then arg1.props.renderActionBarLabelImpressionsDetector(arg1.actionBarLabelRef, arg1.props.scrollViewPositionChangedSignal) else nil
        tbl2.ActionBarLabelImpressionsDetector = actionBarLabelImpressionsDetector
    end

    local infoFrame = createElement(str1, tbl1, tbl2)

    local tbl3 = {
        Padding = Roact.createElement(
            "UIPadding",
            {
                PaddingLeft = UDim.new(0, sideMargin),
                PaddingRight = UDim.new(0, sideMargin),
                PaddingBottom = UDim.new(0, 16)
            }
        ),
        ContentFrame = 0
    }
    local createElement2 = Roact.createElement
    local str2 = "Frame"
    local tbl4 = {
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        Position = UDim2.fromScale(0.5, 1),
        AnchorPoint = Vector2.new(0.5, 1),
        BackgroundTransparency = 1
    }
    local tbl5

    if arg1.props.renderCustomHeader then
        tbl5 = {
            CustomHeader = arg1.props.renderCustomHeader(),
            UISizeConstraint = if arg1.props.maxContentWidth then Roact.createElement("UISizeConstraint", { MaxSize = Vector2.new(arg1.props.maxContentWidth, math.huge) }) else nil
        }
    else
        tbl5 = {
            Layout = Roact.createElement("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                FillDirection = Enum.FillDirection.Horizontal,
                VerticalAlignment = Enum.VerticalAlignment.Bottom,
                Padding = UDim.new(0, itemPadding)
            }),
            ThumbnailTileFrame = arg1:renderThumbnail(arg2, var3, var2, thumbnailHeight),
            InfoFrame = infoFrame,
            UISizeConstraint = if arg1.props.maxContentWidth then Roact.createElement("UISizeConstraint", { MaxSize = Vector2.new(arg1.props.maxContentWidth, math.huge) }) else nil
        }
    end

    tbl3.ContentFrame = createElement2(str2, tbl4, tbl5)
    return tbl3
end

function var1.renderisPhone(arg1, arg2)
    local thumbnailHeight = arg1.props.thumbnailHeight
    local var2 = thumbnailHeight * (arg1.props.thumbnailAspectRatio.X / arg1.props.thumbnailAspectRatio.Y)
    local sideMargin = arg1.props.sideMargin or 24

    if not arg1.props.renderCustomHeader then
        return {
            Padding = Roact.createElement(
                "UIPadding",
                {
                    PaddingLeft = UDim.new(0, sideMargin),
                    PaddingRight = UDim.new(0, sideMargin),
                    PaddingBottom = UDim.new(0, 16)
                }
            ),
            ThumbnailTileFrame = if FFlagLuaAppFixDetailsPageThumbnailRenderInPhone then arg1:renderThumbnail(arg2, 0, var2, thumbnailHeight) else arg1:renderThumbnail(arg2, var2, thumbnailHeight)
        }
    end

    return {
        Padding = Roact.createElement(
            "UIPadding",
            {
                PaddingLeft = UDim.new(0, sideMargin),
                PaddingRight = UDim.new(0, sideMargin),
                PaddingBottom = UDim.new(0, 16)
            }
        ),
        ContentFrame = Roact.createElement("Frame", {
            Size = UDim2.fromScale(1, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            AnchorPoint = Vector2.new(0, 1),
            Position = UDim2.fromScale(0, 1),
            BackgroundTransparency = 1
        }, {
            Content = arg1.props.renderCustomHeader()
        })
    }
end

function var1.render(arg1)
    local bool2 = arg1.props.deviceType == DeviceType.Phone

    local thumbnailHeight = arg1.props.thumbnailHeight
    local headerBarBackgroundHeight = arg1.props.headerBarBackgroundHeight or 80

    local yOffset = arg1.props.gradientHeight or thumbnailHeight + 16 - headerBarBackgroundHeight + 44
    local bottomMargin = arg1.props.bottomMargin

    return withStyle(function(arg2)
        local theme = arg2.Theme

        return Roact.createElement("Frame", {
            Size = UDim2.fromScale(1, 1),
            BackgroundTransparency = 1
        }, {
            Layout = Roact.createElement("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                FillDirection = Enum.FillDirection.Vertical,
                VerticalAlignment = Enum.VerticalAlignment.Bottom,
                HorizontalAlignment = Enum.HorizontalAlignment.Left
            }),
            GradientBar = Roact.createElement("Frame", {
                Size = UDim2.new(1, 0, 0, yOffset),
                BackgroundColor3 = theme.BackgroundDefault.Color,
                AnchorPoint = Vector2.new(0, 1),
                BorderSizePixel = 0,
                LayoutOrder = 1
            }, {
                Gradient = Roact.createElement("UIGradient", {
                    Rotation = 270,
                    Transparency = NumberSequence.new(
                        { NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.5, 0.25), NumberSequenceKeypoint.new(1, 1) }
                    )
                })
            }),
            BackgroundBar = Roact.createElement(
                "Frame",
                {
                    Size = UDim2.new(1, 0, 0, headerBarBackgroundHeight),
                    Position = UDim2.fromScale(0, 1),
                    AnchorPoint = Vector2.new(0, 1),
                    BackgroundColor3 = theme.BackgroundDefault.Color,
                    BackgroundTransparency = theme.BackgroundDefault.Transparency,
                    BorderSizePixel = 0,
                    LayoutOrder = 2
                },
                bool2 and arg1:renderisPhone(arg2, thumbnailHeight) or arg1:renderDesktopMode(arg2, thumbnailHeight)
            ),
            Padding = if bottomMargin then Roact.createElement("Frame", { Size = UDim2.new(1, 0, 0, bottomMargin), BackgroundTransparency = 1, LayoutOrder = 3 }) else nil
        })
    end)
end

return var1
