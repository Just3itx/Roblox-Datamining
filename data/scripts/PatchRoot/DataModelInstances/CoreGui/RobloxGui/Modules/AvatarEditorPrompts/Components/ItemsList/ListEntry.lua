-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:11:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local _Modules = game:GetService("CoreGui").RobloxGui.Modules

local Cryo = require(CorePackages.Packages.Cryo)
local Roact = require(CorePackages.Packages.Roact)
local t = require(CorePackages.Packages.t)
local UIBlox = require(CorePackages.Packages.UIBlox)
local Foundation = require(CorePackages.Packages.Foundation)
local GetTextSize = require(CorePackages.Workspace.Packages.Style).GetTextSize
local normalizeFontFace = Foundation.Utility.normalizeFontFace
local FFlagFontFaceAX = require(CorePackages.Workspace.Packages.SharedFlags).FFlagFontFaceAX
local RoactFitComponents = require(CorePackages.Packages.AvatarExperienceDeps).RoactFitComponents
local FitTextLabel = RoactFitComponents.FitTextLabel
local withStyle = UIBlox.Style.withStyle

local var1 = Roact.PureComponent:extend("ListEntry")

var1.validateProps = t.strictInterface({
    text = t.string,
    hasBullet = t.boolean,
    layoutOrder = t.integer,
    positionChangedCallback = t.optional(t.callback),
    NextSelectionLeft = t.optional(t.table),
    NextSelectionRight = t.optional(t.table),
    NextSelectionUp = t.optional(t.table),
    NextSelectionDown = t.optional(t.table),
    forwardRef = t.optional(t.table)
})

function var1.render(arg1)
    return withStyle(function(arg2)
        local font = arg2.Font
        local theme = arg2.Theme

        local font2 = font.CaptionBody.Font
        local textSize = font.BaseSize * font.CaptionBody.RelativeSize

        local textSizeX = GetTextSize("• ", textSize, arg2.Tokens.Typography.BodySmall.Font, Vector2.new(10000, 10000)).X
        local forwardRef = arg1.props.forwardRef

        local createElement = Roact.createElement
        local fitFrameVertical = RoactFitComponents.FitFrameVertical
        local tbl1 = {
            width = UDim.new(1, 0),
            FillDirection = Enum.FillDirection.Horizontal,
            VerticalAlignment = Enum.VerticalAlignment.Top,
            BackgroundTransparency = 1,
            LayoutOrder = arg1.props.layoutOrder,
            [Roact.Change.AbsolutePosition] = arg1.props.positionChangedCallback,
            NextSelectionLeft = arg1.props.NextSelectionLeft,
            NextSelectionRight = arg1.props.NextSelectionRight,
            NextSelectionUp = arg1.props.NextSelectionUp,
            NextSelectionDown = arg1.props.NextSelectionDown,
            [Roact.Ref] = forwardRef
        }
        local tbl2 = {
            Bullet = arg1.props.hasBullet
                and Roact.createElement("TextLabel", {
                    BackgroundTransparency = 1,
                    Size = UDim2.fromOffset(textSizeX, textSize),
                    Text = "• ",
                    FontFace = normalizeFontFace(arg2.Tokens.Typography.BodySmall.Font),
                    TextSize = textSize,
                    TextColor3 = theme.TextDefault.Color,
                    TextTransparency = theme.TextDefault.Transparency,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    LayoutOrder = 1
                }),
            Text = 0
        }

        local createElement2 = Roact.createElement
        local var2 = FitTextLabel
        local tbl3 = {
            width = UDim.new(1, arg1.props.hasBullet and -textSizeX or 0),
            BackgroundTransparency = 1,
            Text = arg1.props.text,
            Font = 0,
            TextSize = 0,
            TextColor3 = 0,
            TextTransparency = 0,
            TextXAlignment = 0,
            LayoutOrder = 2
        }

        if FFlagFontFaceAX then
            font2 = normalizeFontFace(arg2.Tokens.Typography.BodySmall.Font)
        end

        tbl3.Font = font2

        tbl3.TextSize = textSize
        tbl3.TextColor3 = theme.TextDefault.Color
        tbl3.TextTransparency = theme.TextDefault.Transparency
        tbl3.TextXAlignment = Enum.TextXAlignment.Left
        tbl2.Text = createElement2(var2, tbl3)
        return createElement(fitFrameVertical, tbl1, tbl2)
    end)
end

return Roact.forwardRef(function(arg1, forwardRef)
    return Roact.createElement(var1, Cryo.Dictionary.join(arg1, { forwardRef = forwardRef }))
end)
