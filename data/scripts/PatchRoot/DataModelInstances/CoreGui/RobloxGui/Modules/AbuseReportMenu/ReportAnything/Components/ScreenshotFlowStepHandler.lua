-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:00:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local React = require(CorePackages.Packages.React)

local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)

local scriptParentParent = script.Parent.Parent
local ScreenshotDialog = require(scriptParentParent.Components.ScreenshotDialog)
local ScreenshotReviewDialog = require(scriptParentParent.Components.ScreenshotReviewDialog)

local _Types = require(script.Parent.Parent.Parent.Components.Types)

local function ScreenshotFlowStepHandler(arg1)
    local var1, var2 = React.useState(if arg1.initialPageNumber == nil then 1 else arg1.initialPageNumber)
    local imageAspectRatio, var4 = React.useState(16 / 9)
    local viewportUiSafeAreaHeight, var6 = React.useState(800)
    local viewportUiSafeAreaWidth, var8 = React.useState(800)
    local isSmallPortraitMode, var10 = React.useState(true)
    local onNextPage = React.useCallback(function()
        var2(2)
    end, { var2 })
    local backAction = React.useCallback(function()
        var2(1)
    end, { var2 })

    React.useEffect(function()
        local currentCamera = game.Workspace.CurrentCamera
        if currentCamera == nil then
            return
        end

        local viewportSize = currentCamera.viewportSize
        if arg1.viewportInfo then
            var4(arg1.viewportInfo.width / arg1.viewportInfo.height)
        else
            var4(viewportSize.X / viewportSize.Y)
        end
        var6(viewportSize.Y)
        var8(viewportSize.X)
        var10(viewportSize.X < viewportSize.Y and viewportSize.X < 800)
    end, {})

    if var1 == 1 then
        return (React.createElement(ScreenshotReviewDialog, {
            imageAspectRatio = imageAspectRatio,
            isSmallPortraitMode = isSmallPortraitMode,
            viewportUISafeAreaHeight = viewportUiSafeAreaHeight,
            viewportUISafeAreaWidth = viewportUiSafeAreaWidth,
            onNextPage = onNextPage,
            onBack = arg1.dismissAction,
            onSkip = arg1.skipAnnotationAction,
            onRestart = arg1.restartAction,
            screenshot = arg1.screenshot,
            reportAnythingAnalytics = arg1.reportAnythingAnalytics
        }, {}))
    end

    local titleText = if arg1.entryPoint == "player" then RobloxTranslator:FormatByKey("Feature.ReportAbuse.Label.SelectPerson") else RobloxTranslator:FormatByKey("Feature.ReportAbuse.Label.SelectProblem")
    return (React.createElement(ScreenshotDialog, {
        titleText = titleText,
        backAction = backAction,
        dismissAction = arg1.dismissAction,
        finishAnnotationAction = arg1.finishAnnotationAction,
        initialAnnotationPoints = arg1.initialAnnotationPoints,
        isSmallPortraitMode = isSmallPortraitMode,
        screenshot = arg1.screenshot,
        imageAspectRatio = imageAspectRatio,
        setAnnotationCircleRadius = arg1.setAnnotationCircleRadius,
        setAnnotationAreaDimensions = arg1.setAnnotationAreaDimensions,
        reportAnythingAnalytics = arg1.reportAnythingAnalytics
    }))
end
return ScreenshotFlowStepHandler
