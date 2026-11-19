-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:00:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local UIBlox = require(CorePackages.Packages.UIBlox)
local normalizeFontFace = require(CorePackages.Packages.Foundation).Utility.normalizeFontFace
local React = require(CorePackages.Packages.React)

local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)

local ButtonStack = UIBlox.App.Button.ButtonStack
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local HeaderBar = UIBlox.App.Bar.HeaderBar
local IconButton = UIBlox.App.Button.IconButton
local IconSize = UIBlox.App.ImageSet.Enum.IconSize
local Images = UIBlox.App.ImageSet.Images
local withStyle = UIBlox.Style.withStyle

local function renderWrappingCenter(text) -- Luacid: Inlined by compiler; 1 call site recovered
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

local function renderHeaderBarRight(callback, annotationPoints) -- Luacid: Inlined by compiler; 1 call site recovered
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
            Buttons = React.createElement(ButtonStack, {
                buttons = {{
                    buttonType = ButtonType.PrimarySystem,
                    props = {
                        onActivated = function()
                            callback(annotationPoints)
                        end,
                        text = RobloxTranslator:FormatByKey("Feature.ReportAbuse.Action.Next")
                    }
                }}
            })
        })
    end
end

local function LandscapeModeHeader(tbl1)
    return React.createElement("Frame", {
        BackgroundTransparency = 0,
        BackgroundColor3 = Color3.fromHex("#4F545F"),
        LayoutOrder = 1,
        Size = UDim2.new(1, 0, 0, 47),
        ZIndex = 2
    }, {
        Bar = React.createElement(HeaderBar, {
            backgroundTransparency = 1,
            barHeight = 48,
            renderLeft = renderHeaderBarLeft(
                tbl1.backAction,
                tbl1.undoAnnotationPoints,
                tbl1.redoAnnotationPoints,
                tbl1.isRedoEnabled,
                tbl1.isUndoEnabled
            ),
            renderRight = renderHeaderBarRight(tbl1.finishAnnotationAction, tbl1.annotationPoints),
            renderCenter = renderWrappingCenter(tbl1.titleText)
        })
    })
end

return LandscapeModeHeader
