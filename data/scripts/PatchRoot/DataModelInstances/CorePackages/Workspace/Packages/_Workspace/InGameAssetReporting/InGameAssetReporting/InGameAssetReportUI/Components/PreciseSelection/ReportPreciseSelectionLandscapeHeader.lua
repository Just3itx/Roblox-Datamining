-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T22:21:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InGameAssetReportingParent = script:FindFirstAncestor("InGameAssetReporting").Parent

local React = require(InGameAssetReportingParent.React)
local UIBlox = require(InGameAssetReportingParent.UIBlox)
local Foundation = require(InGameAssetReportingParent.Foundation)

local Button = Foundation.Button
local ButtonVariant = Foundation.Enums.ButtonVariant
local InputSize = Foundation.Enums.InputSize
local normalizeFontFace = Foundation.Utility.normalizeFontFace

local HeaderBar = UIBlox.App.Bar.HeaderBar
local IconButton = UIBlox.App.Button.IconButton
local IconSize = UIBlox.App.ImageSet.Enum.IconSize
local Images = UIBlox.App.ImageSet.Images
local withStyle = UIBlox.Style.withStyle

local function renderHeaderBarCenter(text) -- Luacid: Inlined by compiler; 1 call site recovered
    return function()
        return withStyle(function(arg1)
            local theme = arg1.Theme

            return React.createElement("TextLabel", {
                Text = text,
                FontFace = normalizeFontFace(arg1.Tokens.Typography.TitleLarge.Font),
                TextColor3 = theme.TextEmphasis.Color,
                TextTransparency = theme.TextEmphasis.Transparency,
                TextSize = 20,
                TextWrapped = true,
                TextXAlignment = Enum.TextXAlignment.Center,
                TextYAlignment = Enum.TextYAlignment.Center,
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1
            })
        end)
    end
end

local function renderHeaderBarLeft(onActivated) -- Luacid: Inlined by compiler; 1 call site recovered
    return function()
        return React.createElement("Frame", {
            BackgroundTransparency = 1,
            Size = UDim2.new(0, 120, 1, 0)
        }, {
            Layout = React.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalAlignment = Enum.HorizontalAlignment.Left,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                SortOrder = Enum.SortOrder.LayoutOrder
            }),
            BackButton = React.createElement(
                IconButton,
                {
                    iconSize = IconSize.Medium,
                    icon = Images["icons/navigation/pushBack"],
                    layoutOrder = 1,
                    onActivated = onActivated
                }
            )
        })
    end
end

local function renderHeaderBarRight(onActivated, text, title, text2, isOpen, onClose) -- Luacid: Inlined by compiler; 1 call site recovered
    return function()
        return React.createElement("Frame", {
            BackgroundTransparency = 1,
            Size = UDim2.new(0, 144, 1, 0)
        }, {
            Layout = React.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalAlignment = Enum.HorizontalAlignment.Right,
                VerticalAlignment = Enum.VerticalAlignment.Center
            }),
            CoachmarkWrapper = React.createElement(Foundation.Coachmark, {
                title = title,
                text = text2,
                isOpen = isOpen or false,
                side = Foundation.Enums.PopoverSide.Bottom,
                align = Foundation.Enums.PopoverAlign.End,
                onClose = onClose
            }, {
                NextButton = React.createElement(Button, {
                    variant = ButtonVariant.Emphasis,
                    inputSize = InputSize.Large,
                    onActivated = onActivated,
                    text = text,
                    width = UDim.new(0, 144)
                })
            })
        })
    end
end

local function LandscapeModeHeader(tbl1)
    return React.createElement("Frame", {
        BorderSizePixel = 0,
        BackgroundTransparency = 0.1,
        BackgroundColor3 = Color3.fromHex("#000000"),
        LayoutOrder = 1,
        Size = UDim2.new(1, 0, 0, 71),
        ZIndex = 2
    }, {
        Bar = React.createElement(HeaderBar, {
            backgroundTransparency = 1,
            barHeight = 72,
            renderLeft = renderHeaderBarLeft(tbl1.backAction),
            renderRight = renderHeaderBarRight(
                tbl1.nextAction,
                tbl1.nextText,
                tbl1.coachmarkTitle,
                tbl1.coachmarkText,
                tbl1.isCoachmarkOpen,
                tbl1.onCoachmarkClose
            ),
            renderCenter = renderHeaderBarCenter(tbl1.titleText)
        })
    })
end

return LandscapeModeHeader
