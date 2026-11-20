-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:40:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local Roact = require(scriptParentParentParentParent.Roact)
local t = require(scriptParentParentParentParent.t)
local Label = require(scriptParentParentParent.Core.ImageSet.ImageSetComponent).Label
local Cryo = require(scriptParentParentParentParent.Cryo)

local _StyleTypes = require(scriptParentParent.Style.StyleTypes)
local validateColorInfo = require(scriptParentParentParent.Core.Style.Validator.validateColorInfo)

local Images = require(scriptParentParent.ImageSet.Images)
local IconButton = require(scriptParentParent.Button.IconButton)
local getIconSize = require(scriptParentParent.ImageSet.getIconSize)
local IconSize = require(scriptParentParent.ImageSet.Enum.IconSize)
local GenericTextLabel = require(scriptParentParentParent.Core.Text.GenericTextLabel.GenericTextLabel)
local withStyle = require(scriptParentParentParent.Core.Style.withStyle)
local VoteStates = require(scriptParent.Enum.VoteStates)

local iconsStatusGamesRating_large = Images["icons/status/games/rating_large"]
local iconsActionsVoteVoteDownOff = Images["icons/actions/vote/voteDownOff"]
local iconsActionsVoteVoteDownOn = Images["icons/actions/vote/voteDownOn"]
local iconsActionsVoteVoteUpOff = Images["icons/actions/vote/voteUpOff"]
local iconsActionsVoteVoteUpOn = Images["icons/actions/vote/voteUpOn"]

local tbl1 = {
    containerSpacingTop = 12,
    containerSpacingTrailing = 12,
    containerSpacingBottom = 12,
    containerSpacingLeading = 12,
    containerBorderRadius = 8,
    containerGap = 12,
    statWidgetContainerGap = 12,
    statWidgetIconSize = getIconSize(IconSize.Large),
    statWidgetDataGap = 0,
    buttonGroupGap = 12,
    buttonSize = 44,
    buttonIconSizeEnum = IconSize.Medium
}

local var1 = Roact.PureComponent:extend("RateCount")

var1.validateProps = t.strictInterface({
    position = t.optional(t.UDim2),
    layoutOrder = t.optional(t.integer),
    anchorPoint = t.optional(t.Vector2),
    width = t.optional(t.integer),
    height = t.optional(t.integer),
    rateText = t.optional(t.string),
    rateLabel = t.optional(t.string),
    voteState = t.optional(VoteStates.isEnumValue),
    onVoteDownActivated = t.optional(t.callback),
    onVoteUpActivated = t.optional(t.callback),
    styleProps = t.optional(
        t.strictInterface({
            containerSpacingTop = t.optional(t.integer),
            containerSpacingTrailing = t.optional(t.integer),
            containerSpacingBottom = t.optional(t.integer),
            containerSpacingLeading = t.optional(t.integer),
            containerBorderRadius = t.optional(t.integer),
            containerBackgroundColor = t.optional(validateColorInfo),
            containerGap = t.optional(t.integer),
            statWidgetContainerGap = t.optional(t.integer),
            statWidgetIconSize = t.optional(t.integer),
            statWidgetIconContentColor = t.optional(validateColorInfo),
            statWidgetDataGap = t.optional(t.integer),
            statWidgetDataContentColor = t.optional(validateColorInfo),
            statWidgetDataLabelContentColor = t.optional(validateColorInfo),
            buttonGroupGap = t.optional(t.integer),
            buttonSize = t.optional(t.integer),
            buttonIconSizeEnum = t.optional(IconSize.isEnumValue)
        })
    )
})
var1.defaultProps = {
    height = 72,
    rateText = "",
    rateLabel = "",
    voteState = VoteStates.notVoted
}

function var1.init(arg1)
    function arg1.onVoteDownActivated()
        local onVoteDownActivated = arg1.props.onVoteDownActivated
        if onVoteDownActivated then
            onVoteDownActivated()
        end
    end

    function arg1.onVoteUpActivated()
        local onVoteUpActivated = arg1.props.onVoteUpActivated
        if onVoteUpActivated then
            onVoteUpActivated()
        end
    end
end

function var1.render(arg1)
    local position = arg1.props.position
    local layoutOrder = arg1.props.layoutOrder
    local anchorPoint = arg1.props.anchorPoint

    local width = arg1.props.width
    local height = arg1.props.height
    local uDim2 = if width then UDim2.new(0, width, 0, height) else UDim2.new(1, 0, 0, height)
    local rateText = arg1.props.rateText
    local rateLabel = arg1.props.rateLabel
    local voteState = arg1.props.voteState
    local bool1 = voteState == VoteStates.votedDown
    local bool2 = voteState == VoteStates.votedUp

    return withStyle(function(arg2)
        local var2 = Cryo.Dictionary.join(tbl1, arg1.props.styleProps or {})
        local containerSpacingLeading = var2.containerSpacingLeading
        local containerSpacingTrailing = var2.containerSpacingTrailing
        local containerBorderRadius = var2.containerBorderRadius
        local var3 = var2.containerBackgroundColor or arg2.Theme.BackgroundContrast
        local containerGap = var2.containerGap

        local statWidgetContainerGap = var2.statWidgetContainerGap
        local statWidgetIconSize = var2.statWidgetIconSize
        local var4 = var2.statWidgetIconContentColor or arg2.Theme.IconEmphasis
        local statWidgetDataGap = var2.statWidgetDataGap
        local colorStyle = var2.statWidgetDataContentColor or arg2.Theme.TextEmphasis
        local var5 = var2.statWidgetDataLabelContentColor or arg2.Theme.TextEmphasis

        local buttonGroupGap = var2.buttonGroupGap
        local buttonSize = var2.buttonSize
        local buttonIconSizeEnum = var2.buttonIconSizeEnum
        local xOffset = -(statWidgetIconSize + math.max(getIconSize(buttonIconSizeEnum, arg2), buttonSize) * 2 + statWidgetContainerGap + containerGap + buttonGroupGap)

        return Roact.createElement("Frame", {
            Size = uDim2,
            Position = position,
            AnchorPoint = anchorPoint,
            BackgroundColor3 = var3.Color,
            BackgroundTransparency = var3.Transparency,
            BorderSizePixel = 0,
            LayoutOrder = layoutOrder
        }, {
            RoundCorner = Roact.createElement("UICorner", { CornerRadius = UDim.new(0, containerBorderRadius) }),
            ListLayout = Roact.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalAlignment = Enum.HorizontalAlignment.Left,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, containerGap)
            }),
            Padding = Roact.createElement(
                "UIPadding",
                {
                    PaddingLeft = UDim.new(0, containerSpacingLeading),
                    PaddingRight = UDim.new(0, containerSpacingTrailing)
                }
            ),
            Icon = Roact.createElement(Label, {
                LayoutOrder = 1,
                Size = UDim2.fromOffset(statWidgetIconSize, statWidgetIconSize),
                Image = iconsStatusGamesRating_large,
                ImageColor3 = var4.Color,
                ImageTransparency = var4.Transparency,
                BackgroundTransparency = 1
            }),
            TextSection = Roact.createElement("Frame", {
                LayoutOrder = 2,
                Size = UDim2.new(1, xOffset, 0, 0),
                BackgroundTransparency = 1,
                AutomaticSize = Enum.AutomaticSize.Y
            }, {
                ListLayout = Roact.createElement("UIListLayout", {
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    FillDirection = Enum.FillDirection.Vertical,
                    Padding = UDim.new(0, statWidgetDataGap)
                }),
                RateText = Roact.createElement(GenericTextLabel, {
                    LayoutOrder = 1,
                    AutomaticSize = Enum.AutomaticSize.XY,
                    Text = rateText,
                    colorStyle = colorStyle,
                    fontStyle = arg2.Font.Title,
                    BackgroundTransparency = 1
                }),
                RateLabel = Roact.createElement(GenericTextLabel, {
                    LayoutOrder = 2,
                    AutomaticSize = Enum.AutomaticSize.XY,
                    Text = rateLabel,
                    colorStyle = var5,
                    fontStyle = arg2.Font.CaptionHeader,
                    BackgroundTransparency = 1
                })
            }),
            VoteDown = Roact.createElement(IconButton, {
                layoutOrder = 3,
                size = UDim2.fromOffset(buttonSize, buttonSize),
                icon = bool1 and iconsActionsVoteVoteDownOn or iconsActionsVoteVoteDownOff,
                iconColor3 = arg2.Theme.IconEmphasis.Color,
                iconSize = buttonIconSizeEnum,
                onActivated = arg1.onVoteDownActivated,
                showBackground = true
            }),
            VoteUp = Roact.createElement(IconButton, {
                layoutOrder = 4,
                size = UDim2.fromOffset(buttonSize, buttonSize),
                icon = bool2 and iconsActionsVoteVoteUpOn or iconsActionsVoteVoteUpOff,
                iconColor3 = arg2.Theme.IconEmphasis.Color,
                iconSize = buttonIconSizeEnum,
                onActivated = arg1.onVoteUpActivated,
                showBackground = true
            })
        })
    end)
end

return var1
