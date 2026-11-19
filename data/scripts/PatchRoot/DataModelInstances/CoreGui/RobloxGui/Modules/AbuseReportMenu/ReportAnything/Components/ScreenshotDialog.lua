-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:00:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local UIBlox = require(CorePackages.Packages.UIBlox)
local React = require(CorePackages.Packages.React)
local Cryo = require(CorePackages.Packages.Cryo)

local ImageSetButton = UIBlox.Core.ImageSet.ImageSetButton
local useStyle = UIBlox.Core.Style.useStyle

local ButtonStack = UIBlox.App.Button.ButtonStack
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local scriptParentParent = script.Parent.Parent
local Assets = require(scriptParentParent.Resources.Assets)
local Divider = require(scriptParentParent.Components.Divider)
local ScreenshotHighlighter = require(scriptParentParent.Components.ScreenshotHighlighter)
local VirtualKeyboardMonitor = require(scriptParentParent.Utility.VirtualKeyboardMonitor)
local ScreenshotDialogPortraitModeHeader = require(scriptParentParent.Components.ScreenshotDialogPortraitModeHeader)
local ScreenshotDialogLandscapeModeHeader = require(scriptParentParent.Components.ScreenshotDialogLandscapeModeHeader)
local _ReportAnythingAnalytics = require(scriptParentParent.Utility.ReportAnythingAnalytics)

local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)

local function PortraitModeFooter(tbl1)
    return React.createElement("Frame", {
        BackgroundTransparency = 0,
        Size = UDim2.new(1, 0, 0, 60),
        BackgroundColor3 = Color3.fromHex("#4F545F"),
        AnchorPoint = Vector2.new(0, 1),
        Position = UDim2.fromScale(0, 1),
        LayoutOrder = 4
    }, {
        Layout = React.createElement(
            "UIListLayout",
            {
                FillDirection = Enum.FillDirection.Vertical,
                HorizontalAlignment = Enum.HorizontalAlignment.Center
            }
        ),
        Container = React.createElement("Frame", {
            Size = UDim2.new(0, 400, 1, 0),
            BackgroundTransparency = 1
        }, {
            Padding = React.createElement("UIPadding", {
                PaddingTop = UDim.new(0, 12),
                PaddingBottom = UDim.new(0, 12),
                PaddingLeft = UDim.new(0, 32),
                PaddingRight = UDim.new(0, 32)
            }),
            ActionButtons = React.createElement(ButtonStack, {
                marginBetween = 8,
                buttons = {{
                    buttonType = ButtonType.PrimarySystem,
                    props = {
                        onActivated = function()
                            tbl1.finishAnnotationAction(tbl1.annotationPoints)
                        end,
                        text = RobloxTranslator:FormatByKey("Feature.ReportAbuse.Action.Next")
                    }
                }}
            })
        })
    })
end

local function ScreenshotDialog(tbl1)
    local theme = useStyle().Theme

    local instance = VirtualKeyboardMonitor.getInstance()

    local annotationPoints, var2 = React.useState(Cryo.Dictionary.join({}, tbl1.initialAnnotationPoints or {}))
    local var3, var4 = React.useState({})

    local var5 = React.useCallback(function()
        var2(table.clone(annotationPoints))
    end, { var2, annotationPoints })

    local backAction = React.useCallback(function()
        tbl1.reportAnythingAnalytics.incrementAnnotationBack()
        tbl1.backAction()
    end, { tbl1.backAction, tbl1.reportAnythingAnalytics })

    local handleAnnotationPoints = React.useCallback(function(_)
        tbl1.reportAnythingAnalytics.incrementAnnotationPlace()
        var5()

        var4({})
    end, { var4, var5, tbl1.reportAnythingAnalytics })

    local undoAnnotationPoints = React.useCallback(function()
        if #annotationPoints > 0 then
            tbl1.reportAnythingAnalytics.incrementAnnotationUndo()

            table.insert(var3, 1, annotationPoints[#annotationPoints])
            table.remove(annotationPoints, #annotationPoints)
            var5()
        end
    end, {
        var5,
        annotationPoints,
        var3,
        tbl1.reportAnythingAnalytics
    })
    local redoAnnotationPoints = React.useCallback(function()
        if #var3 > 0 then
            tbl1.reportAnythingAnalytics.incrementAnnotationRedo()

            table.insert(annotationPoints, var3[1])
            table.remove(var3, 1)
            var5()
        end
    end, {
        var5,
        annotationPoints,
        var3,
        tbl1.reportAnythingAnalytics
    })
    local finishAnnotationAction = React.useCallback(function(tbl2)
        tbl1.reportAnythingAnalytics.setAnnotationNext()
        tbl1.finishAnnotationAction(tbl2)
    end, { tbl1.finishAnnotationAction, tbl1.reportAnythingAnalytics })

    local isUndoEnabled = #annotationPoints > 0
    local isRedoEnabled = #var3 > 0

    local createElement = React.createElement
    local str1 = "TextButton"
    local tbl2 = {
        AutoButtonColor = false,
        BorderSizePixel = 0,
        BackgroundColor3 = theme.Overlay.Color,
        BackgroundTransparency = theme.Overlay.Transparency,
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.fromScale(0.5, 0.5),
        AnchorPoint = Vector2.new(0.5, 0.5),
        ZIndex = 10,
        Text = ""
    }

    tbl2[React.Event.Activated] = function()
        warn("OverlayActivated")
        if instance:isKeyboardJustOff() then
            return
        end
        if tbl1.dismissAction then
            warn("Menu dismissed")
            tbl1.dismissAction()
        end
    end

    local tbl3 = { ScreenshotDialog = 0 }

    local createElement2 = React.createElement
    local var11 = ImageSetButton
    local tbl4 = {
        Active = true,
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        Image = Assets.Images.RoundedRect.Image,
        ImageColor3 = theme.BackgroundUIDefault.Color,
        ImageTransparency = theme.BackgroundUIDefault.Transparency,
        ScaleType = Assets.Images.RoundedRect.ScaleType,
        SliceCenter = Assets.Images.RoundedRect.SliceCenter
    }
    local tbl5 = { HeaderAndContent = 0, Footer = 0 }

    local createElement3 = React.createElement
    local str2 = "Frame"
    local tbl6 = {
        Size = UDim2.new(1, 0, 1, if tbl1.isSmallPortraitMode then -60 else 0),
        BackgroundTransparency = 1
    }
    local tbl7 = {
        Layout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder
        }),
        Header = 0,
        Divider = 0,
        ScreenshotAnnotation = 0
    }
    local element

    if tbl1.isSmallPortraitMode then
        element = React.createElement(ScreenshotDialogPortraitModeHeader, {
            titleText = tbl1.titleText,
            backAction = backAction,
            undoAnnotationPoints = undoAnnotationPoints,
            redoAnnotationPoints = redoAnnotationPoints,
            isRedoEnabled = isRedoEnabled,
            isUndoEnabled = isUndoEnabled,
            annotationPoints = annotationPoints
        })
    else
        element = React.createElement(ScreenshotDialogLandscapeModeHeader, {
            titleText = tbl1.titleText,
            backAction = backAction,
            finishAnnotationAction = finishAnnotationAction,
            undoAnnotationPoints = undoAnnotationPoints,
            redoAnnotationPoints = redoAnnotationPoints,
            isRedoEnabled = isRedoEnabled,
            isUndoEnabled = isUndoEnabled,
            annotationPoints = annotationPoints
        })
    end

    tbl7.Header = element

    tbl7.Divider = React.createElement(Divider, { LayoutOrder = 2 })

    tbl7.ScreenshotAnnotation = React.createElement(
        "Frame",
        {
            BackgroundTransparency = 1,
            LayoutOrder = 3,
            Size = UDim2.new(1, 0, 1, -49),
            ZIndex = 1
        },
        {
            Container = React.createElement("Frame", {
                Size = UDim2.fromScale(1, 1),
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.fromScale(0.5, 0.5),
                BackgroundTransparency = 1
            }, {
                Layout = React.createElement(
                    "UIListLayout",
                    {
                        HorizontalAlignment = Enum.HorizontalAlignment.Center,
                        VerticalAlignment = Enum.VerticalAlignment.Center
                    }
                ),
                Padding = React.createElement("UIPadding", {
                    PaddingTop = UDim.new(0, 16),
                    PaddingBottom = UDim.new(0, 16),
                    PaddingLeft = UDim.new(0, 16),
                    PaddingRight = UDim.new(0, 16)
                }),
                AnnotationLayer = React.createElement("Frame", {
                    Size = UDim2.new(1, 0, 1, 0),
                    BorderSizePixel = 2,
                    BorderMode = Enum.BorderMode.Outline,
                    BorderColor3 = Color3.fromRGB(255, 255, 255)
                }, {
                    UIAspectRatioConstraint = React.createElement("UIAspectRatioConstraint", { AspectRatio = tbl1.imageAspectRatio }),
                    ScreenshotImage = React.createElement(
                        "ImageLabel",
                        {
                            Size = UDim2.fromScale(1, 1),
                            Image = tbl1.screenshot,
                            ScaleType = Enum.ScaleType.Fit,
                            ZIndex = 1
                        },
                        {}
                    ),
                    Highlighter = React.createElement(ScreenshotHighlighter, {
                        annotationPoints = annotationPoints,
                        handleAnnotationPoints = handleAnnotationPoints,
                        setAnnotationCircleRadius = tbl1.setAnnotationCircleRadius,
                        setAnnotationAreaDimensions = tbl1.setAnnotationAreaDimensions,
                        ZIndex = 3
                    }, {})
                })
            })
        }
    )
    tbl5.HeaderAndContent = createElement3(str2, tbl6, tbl7)

    tbl5.Footer = if tbl1.isSmallPortraitMode then React.createElement(
        PortraitModeFooter,
        { finishAnnotationAction = finishAnnotationAction, annotationPoints = annotationPoints }
    ) else nil
    tbl3.ScreenshotDialog = createElement2(var11, tbl4, tbl5)
    return createElement(str1, tbl2, tbl3)
end

return ScreenshotDialog
