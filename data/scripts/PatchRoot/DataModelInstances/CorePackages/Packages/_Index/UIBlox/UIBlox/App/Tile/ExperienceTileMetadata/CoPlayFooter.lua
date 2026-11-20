-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:01:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent
local UIBloxConfig = require(scriptParentParentParentParent.UIBloxConfig)

local Cryo = require(scriptParentParentParentParentParent.Cryo)
local React = require(scriptParentParentParentParentParent.React)
local normalizeFontFace = require(scriptParentParentParentParentParent.Foundation).Utility.normalizeFontFace

local Label = require(scriptParentParentParentParent.Core.ImageSet.ImageSetComponent).Label
local GenericTextLabel = require(scriptParentParentParentParent.Core.Text.GenericTextLabel.GenericTextLabel)
local useStyle = require(scriptParentParentParentParent.Core.Style.useStyle)
local _StyleTypes = require(scriptParentParentParentParent.App.Style.StyleTypes)
local _Fonts = require(scriptParentParentParentParent.App.Style.Fonts)

local tbl1 = {
    size = UDim2.fromScale(1, 1),
    faceGroupCount = 3,
    maxBadgeDisplayNumber = 99,
    styleProps = {},
    showEmphasisBorder = false
}

local tbl2 = {
    containerGap = 6,
    faceGroupGap = -9,
    faceBorderWidth = 3,
    faceBorderRadius = 50,
    faceWidth = 24,
    faceHeight = 24,
    badgeBorderWidth = 3,
    badgeBorderRadius = 50,
    badgeSpacingLeading = 9,
    badgeSpacingTrailing = 9,
    badgeHeight = 24
}

local function getAvatarImage(id: string): string -- Luacid: Inlined by compiler; 1 call site recovered
    return string.format("rbxthumb://type=AvatarHeadShot&id=%s&w=150&h=150", tostring(id))
end

local function renderCornerStroke(tbl3)
    return React.createElement(React.Fragment, nil, {
        Corner = React.createElement("UICorner", { CornerRadius = UDim.new(0, tbl3.borderRadius) }),
        Stroke = React.createElement("UIStroke", {
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
            Color = tbl3.borderColor.Color,
            Transparency = tbl3.borderColor.Transparency,
            Thickness = tbl3.borderWidth
        })
    })
end

local function renderEmphasisBorder(borderWidth: number, tbl3, arg1, zIndex: number?)
    local theme = arg1.Theme
    local num1 = borderWidth - 1
    local num2 = (1 - borderWidth) / 2
    return React.createElement("Frame", {
        BackgroundTransparency = 1,
        Position = UDim2.new(0, num2, 0, num2),
        Size = UDim2.new(1, num1, 1, num1),
        ZIndex = zIndex
    }, { renderCornerStroke(
            {
                borderWidth = 1,
                borderColor = theme.ContextualPrimaryDefault,
                borderRadius = tbl3.badgeBorderRadius
            }
        ) })
end

local function renderBadge(tbl3, tbl4, arg1)
    local var1 = if tbl3.usersCount > tbl3.maxDisplayNumber then tostring(tbl3.maxDisplayNumber) .. "+" else tostring(tbl3.usersCount)
    local theme = arg1.Theme
    local font = arg1.Font

    local var2 = tbl4.badgeBackgroundColor or theme.BackgroundUIDefault
    local badgeBorderWidth = tbl4.badgeBorderWidth
    local borderColor = tbl4.badgeBorderColor or arg1.Theme.BackgroundDefault
    local badgeBorderRadius = tbl4.badgeBorderRadius
    local badgeSpacingLeading = tbl4.badgeSpacingLeading
    local badgeSpacingTrailing = tbl4.badgeSpacingTrailing
    local badgeHeight = tbl4.badgeHeight
    local var4 = tbl4.badgeContentColor or theme.TextMuted

    local badgeContainer = React.createElement("Frame", {
        LayoutOrder = tbl3.layoutOrder,
        ZIndex = tbl3.ZIndex,
        Size = UDim2.fromOffset(0, badgeHeight),
        BorderSizePixel = 0,
        BackgroundColor3 = var2.Color,
        BackgroundTransparency = var2.Transparency,
        AutomaticSize = Enum.AutomaticSize.X
    }, {
        renderCornerStroke({ borderWidth = badgeBorderWidth, borderColor = borderColor, borderRadius = badgeBorderRadius }),
        SizeConstraint = React.createElement("UISizeConstraint", { MinSize = Vector2.new(badgeHeight, 0) }),
        Content = React.createElement("TextLabel", {
            Size = UDim2.fromScale(1, 1),
            BorderSizePixel = 0,
            Text = var1,
            TextXAlignment = Enum.TextXAlignment.Center,
            TextYAlignment = Enum.TextYAlignment.Center,
            FontFace = normalizeFontFace(font.CaptionHeader.Font),
            TextSize = font.BaseSize * font.CaptionHeader.RelativeSize,
            TextColor3 = var4.Color,
            TextTransparency = var4.Transparency,
            BackgroundTransparency = 1,
            AutomaticSize = Enum.AutomaticSize.X,
            ZIndex = tbl3.ZIndex + 1
        }, {
            Padding = React.createElement(
                "UIPadding",
                {
                    PaddingLeft = UDim.new(0, badgeSpacingLeading),
                    PaddingRight = UDim.new(0, badgeSpacingTrailing)
                }
            )
        })
    })
    return React.createElement("Frame", {
        LayoutOrder = tbl3.layoutOrder,
        ZIndex = tbl3.ZIndex,
        Size = UDim2.fromOffset(0, badgeHeight),
        BorderSizePixel = 0,
        BackgroundColor3 = var2.Color,
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.X
    }, {
        BadgeContainer = badgeContainer,
        emphasisBorder = if tbl3.showEmphasisBorder then renderEmphasisBorder(badgeBorderWidth, tbl4, arg1, tbl3.ZIndex + 1) else nil
    })
end

local function renderFaceImage(tbl3, tbl4, arg1)
    local var1 = tbl4.faceBackgroundColor or arg1.Theme.TextDefault
    local faceBorderWidth = tbl4.faceBorderWidth
    local borderColor = tbl4.faceBorderColor or arg1.Theme.BackgroundDefault
    local faceBorderRadius = tbl4.faceBorderRadius
    local faceWidth = tbl4.faceWidth
    local faceHeight = tbl4.faceHeight
    return React.createElement(Label, {
        LayoutOrder = tbl3.layoutOrder,
        ZIndex = tbl3.ZIndex,
        Size = UDim2.fromOffset(faceWidth, faceHeight),
        Image = getAvatarImage(tbl3.user),
        BackgroundColor3 = var1.Color,
        BackgroundTransparency = var1.Transparency,
        BorderSizePixel = 0
    }, {
        renderCornerStroke({ borderWidth = faceBorderWidth, borderColor = borderColor, borderRadius = faceBorderRadius }),
        emphasisBorder = if tbl3.showEmphasisBorder then renderEmphasisBorder(faceBorderWidth, tbl4, arg1, tbl3.ZIndex + 1) else nil
    })
end

local function renderFaces(tbl3, tbl4, arg1, num1: number, bool1: boolean, num2: number)
    local users = tbl3.users
    local faceGroupGap = tbl4.faceGroupGap
    local badgeBorderWidth = tbl4.badgeBorderWidth
    local faceBorderWidth = tbl4.faceBorderWidth
    local offset = math.max(badgeBorderWidth, faceBorderWidth)

    local tbl5 = {
        ListLayout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, faceGroupGap)
        }),
        Padding = React.createElement("UIPadding", {
            PaddingLeft = UDim.new(0, badgeBorderWidth),
            PaddingTop = UDim.new(0, offset),
            PaddingRight = UDim.new(0, faceBorderWidth),
            PaddingBottom = UDim.new(0, offset)
        }),
        Badge = if bool1 then renderBadge({
            usersCount = #users,
            layoutOrder = 0,
            ZIndex = num1 + 1,
            maxDisplayNumber = tbl3.maxBadgeDisplayNumber,
            showEmphasisBorder = tbl3.showEmphasisBorder
        }, tbl4, arg1) else nil
    }

    local usersLen = #users

    for layoutOrder = 1, math.min(num2, usersLen) do
        local str1 = "Face_" .. layoutOrder
        tbl5[str1] = renderFaceImage({
            user = users[layoutOrder],
            layoutOrder = layoutOrder,
            ZIndex = num1 - layoutOrder,
            showEmphasisBorder = tbl3.showEmphasisBorder
        }, tbl4, arg1)
    end

    return React.createElement(
        "Frame",
        {
            AutomaticSize = Enum.AutomaticSize.XY,
            BackgroundTransparency = 1,
            BorderSizePixel = 0
        },
        tbl5
    )
end

local function CoPlayFooter(tbl3)
    local var1 = Cryo.Dictionary.join(tbl1, tbl3)
    if not UIBloxConfig.fixCoplayFooterConditionalHooks and (not var1.users or #var1.users == 0) then
        return nil
    end

    local var2 = useStyle()
    local var3, var4 = React.useBinding(Vector2.new(0, 0))
    local var5 = Cryo.Dictionary.join(tbl2, var1.styleProps)
    local var6

    if UIBloxConfig.fixCoplayFooterConditionalHooks then
        var6 = React.useCallback(function(arg1)
            var4(arg1.AbsoluteSize)
        end, { var4 })

        if not var1.users or #var1.users == 0 then
            return nil
        end
    else
        var6 = nil
    end

    local containerGap = var5.containerGap
    local colorStyle = var5.labelContentColor or var2.Theme.TextMuted

    local faceGroupCount = var1.faceGroupCount
    local bool1 = #var1.users > faceGroupCount + 1
    if not bool1 then
        faceGroupCount += 1
    end

    local var8 = faceGroupCount + 1

    if not UIBloxConfig.fixCoplayFooterConditionalHooks then
        var6 = React.useCallback(function(arg1)
            var4(arg1.AbsoluteSize)
        end, { var4 })
    end

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl4 = {
        Size = var1.size,
        Position = var1.position,
        AnchorPoint = var1.anchorPoint,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        LayoutOrder = var1.layoutOrder
    }
    local tbl5 = {
        ListLayout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            Padding = UDim.new(0, containerGap)
        }),
        FacesFrame = React.createElement("Frame", {
            LayoutOrder = 1,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            AutomaticSize = Enum.AutomaticSize.XY,
            [React.Change.AbsoluteSize] = var6
        }, {
            Faces = renderFaces(var1, var5, var2, var8, bool1, faceGroupCount)
        }),
        LabelFrame = 0
    }
    local element

    if var1.labelText then
        element = React.createElement("Frame", {
            LayoutOrder = 2,
            Size = var3:map(function(vector2: Vector2): UDim2
                return UDim2.new(1, -vector2.X - containerGap, 1, 0)
            end),
            BackgroundTransparency = 1,
            BorderSizePixel = 0
        }, {
            Label = React.createElement(GenericTextLabel, {
                Size = UDim2.fromScale(1, 1),
                Text = var1.labelText,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Center,
                TextTruncate = Enum.TextTruncate.AtEnd,
                TextWrapped = false,
                fontStyle = var5.fontStyle or var2.Font.CaptionBody,
                colorStyle = colorStyle
            })
        })
    else
        element = nil
    end

    tbl5.LabelFrame = element
    return createElement(str1, tbl4, tbl5)
end

return CoPlayFooter
