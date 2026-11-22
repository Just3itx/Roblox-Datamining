-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:31:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local BuilderIcons = require(MomentsParent.BuilderIcons)
local Foundation = require(MomentsParent.Foundation)
local MomentsCommon = require(MomentsParent.MomentsCommon)
local React = require(MomentsParent.React)

local Button = Foundation.Button
local FoundationProvider = Foundation.FoundationProvider
local Icon = Foundation.Icon
local FoundationText = Foundation.Text
local View = Foundation.View

local ColorMode = Foundation.Enums.ColorMode
local FillBehavior = Foundation.Enums.FillBehavior
local IconSize = Foundation.Enums.IconSize
local InputSize = Foundation.Enums.InputSize

local MomentMediaTile = MomentsCommon.Media.MomentMediaTile
local useTokens = Foundation.Hooks.useTokens

local Constants = require(Moments.Constants)

local function renderMedia(media, cornerRadius: number)
    if media.kind == "thumbnail" then
        local mediaItem = table.clone(media.mediaItem)
        mediaItem.cornerRadius = cornerRadius
        return React.createElement(
            View,
            {
                LayoutOrder = 1,
                tag = "size-1200-1200",
                testId = "moments-post-status-card-thumbnail"
            },
            {
                Tile = React.createElement(MomentMediaTile, { mediaItem = mediaItem, isActive = false })
            }
        )
    end

    local bool1 = media.kind == "momentsIcon"
    local createElement = React.createElement
    local var1 = View
    local tbl1 = {
        LayoutOrder = 1,
        tag = "row align-x-center align-y-center size-1200-1200 radius-small bg-shift-200",
        testId = if bool1 then "moments-post-status-card-moments-icon" else "moments-post-status-card-unavailable"
    }

    local tbl2 = {
        Icon = React.createElement(Icon, {
            name = if bool1 then BuilderIcons.Icon.Moments else BuilderIcons.Icon.ArrowSpinClockwiseDashed,
            size = IconSize.Large
        })
    }
    return createElement(var1, tbl1, tbl2)
end

local function PostStatusCardView(tbl1)
    local var1 = useTokens()

    local distance, var3 = React.useBinding(400)
    local var4 = React.useCallback(function(arg1)
        var3(arg1.AbsoluteSize.Y)
    end, {})

    local var5 = if tbl1.shown ~= nil then React.joinBindings({ shown = tbl1.shown, distance = distance }):map(function(tbl2): UDim2
        return UDim2.fromOffset(0, (tbl2.shown - 1) * tbl2.distance)
    end) else UDim2.new()

    local tbl2 = ({})
    for layoutOrder, action in tbl1.actions do
        local str1 = `Action{layoutOrder}`
        tbl2[str1] = React.createElement(Button, {
            LayoutOrder = layoutOrder,
            text = action.text,
            variant = action.variant,
            size = InputSize.Small,
            fillBehavior = FillBehavior.Fill,
            onActivated = action.onActivated,
            testId = `moments-post-status-card-action-{layoutOrder}`
        })
    end

    local createElement = React.createElement
    local var6 = View
    local tbl3 = {
        tag = "position-top-center anchor-top-center size-full-0 auto-y",
        ZIndex = Constants.ZIndex.PostStatusCard
    }
    local tbl4 = { Slide = 0 }
    local createElement2 = React.createElement
    local str1 = "Frame"
    local tbl5 = {
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        Position = var5,
        [React.Change.AbsoluteSize] = var4
    }
    local tbl6 = { Inset = 0 }
    local createElement3 = React.createElement
    local var7 = View
    local tbl7 = {
        tag = "col align-x-center size-full-0 auto-y",
        padding = {
            top = UDim.new(0, tbl1.topInset),
            left = UDim.new(0, tbl1.leftInset + var1.Padding.XLarge),
            right = UDim.new(0, tbl1.rightInset + var1.Padding.XLarge)
        }
    }
    local tbl8 = { DarkScope = 0 }

    local createElement4 = React.createElement
    local var8 = FoundationProvider
    local tbl9 = {
        colorMode = ColorMode.Dark
    }
    local tbl10 = { Card = 0 }
    local createElement5 = React.createElement
    local var9 = View
    local tbl11 = {
        tag = "row align-y-top gap-large size-full-0 auto-y padding-large radius-medium bg-surface-100",
        sizeConstraint = {
            MaxSize = Vector2.new(480, math.huge)
        },
        testId = "moments-post-status-card"
    }
    local tbl12 = {
        Media = if tbl1.media == nil then nil else renderMedia(tbl1.media, var1.Radius.Small),
        Content = React.createElement(View, { LayoutOrder = 2, tag = "col grow gap-xxsmall auto-y" }, {
            Title = React.createElement(FoundationText, {
                LayoutOrder = 1,
                tag = "size-full-0 auto-y text-title-medium text-align-x-left text-truncate-end content-emphasis",
                Text = tbl1.title
            }),
            Body = React.createElement(FoundationText, {
                LayoutOrder = 2,
                tag = "size-full-0 auto-y text-body-medium text-wrap text-align-x-left content-default",
                Text = tbl1.body
            }),
            Actions = if #tbl1.actions > 0 then React.createElement(View, { LayoutOrder = 3, tag = "row gap-small size-full-0 auto-y padding-top-medium" }, tbl2) else nil
        })
    }
    tbl10.Card = createElement5(var9, tbl11, tbl12)
    tbl8.DarkScope = createElement4(var8, tbl9, tbl10)
    tbl6.Inset = createElement3(var7, tbl7, tbl8)
    tbl4.Slide = createElement2(str1, tbl5, tbl6)
    return createElement(var6, tbl3, tbl4)
end

return PostStatusCardView
