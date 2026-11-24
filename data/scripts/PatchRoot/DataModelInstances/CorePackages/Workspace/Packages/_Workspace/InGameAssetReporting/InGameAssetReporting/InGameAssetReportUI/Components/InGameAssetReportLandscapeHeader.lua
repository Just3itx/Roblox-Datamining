-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T22:21:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InGameAssetReportingParent = script:FindFirstAncestor("InGameAssetReporting").Parent

local React = require(InGameAssetReportingParent.React)
local UIBlox = require(InGameAssetReportingParent.UIBlox)
local normalizeFontFace = require(InGameAssetReportingParent.Foundation).Utility.normalizeFontFace

local ButtonStack = UIBlox.App.Button.ButtonStack
local ButtonType = UIBlox.App.Button.Enum.ButtonType
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

local function renderHeaderBarLeft(onActivated, onActivated2, onActivated3, isRedoEnabled, isUndoEnabled) -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = isRedoEnabled or isUndoEnabled
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
            ),
            UndoButton = var1
                and React.createElement(IconButton, {
                    iconSize = IconSize.Medium,
                    icon = Images["icons/actions/edit/undo"],
                    isDisabled = not isUndoEnabled,
                    layoutOrder = 2,
                    onActivated = onActivated2
                }),
            RedoButton = var1
                and React.createElement(IconButton, {
                    iconSize = IconSize.Medium,
                    icon = Images["icons/actions/edit/redo"],
                    isDisabled = not isRedoEnabled,
                    layoutOrder = 3,
                    onActivated = onActivated3
                })
        })
    end
end

local function renderHeaderBarRight(onActivated, _, text) -- Luacid: Inlined by compiler; 1 call site recovered
    return function()
        return React.createElement("Frame", {
            BackgroundTransparency = 1,
            Size = UDim2.new(0, 144, 1, 0)
        }, {
            Layout = React.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                VerticalAlignment = Enum.VerticalAlignment.Center
            }),
            Buttons = React.createElement(
                ButtonStack,
                {
                    buttons = {{
                        buttonType = ButtonType.PrimarySystem,
                        props = { onActivated = onActivated, text = text }
                    }}
                }
            )
        })
    end
end

local function LandscapeModeHeader(tbl1)
    local createElement = React.createElement
    local tbl2 = {
        BorderSizePixel = 0,
        BackgroundTransparency = 0.1,
        BackgroundColor3 = Color3.fromHex("#000000"),
        LayoutOrder = 1,
        Size = UDim2.new(1, 0, 0, 71),
        ZIndex = 2
    }
    local tbl3 = { Bar = 0 }
    local createElement2 = React.createElement
    local var1 = HeaderBar
    local tbl4 = {
        backgroundTransparency = 1,
        barHeight = 72,
        renderLeft = renderHeaderBarLeft(
            tbl1.backAction,
            tbl1.undoAnnotationPoints,
            tbl1.redoAnnotationPoints,
            tbl1.isRedoEnabled,
            tbl1.isUndoEnabled
        ),
        renderRight = 0,
        renderCenter = 0
    }
    local nextAction = tbl1.nextAction
    local _annotationPoints = tbl1.annotationPoints
    tbl4.renderRight = renderHeaderBarRight(nextAction, nil, tbl1.nextText)
    tbl4.renderCenter = renderHeaderBarCenter(tbl1.titleText)
    tbl3.Bar = createElement2(var1, tbl4)
    return createElement("Frame", tbl2, tbl3)
end

return LandscapeModeHeader
