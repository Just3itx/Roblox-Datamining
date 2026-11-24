-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T22:21:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InGameAssetReporting = script:FindFirstAncestor("InGameAssetReporting")
local InGameAssetReportingParent = InGameAssetReporting.Parent

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local ExperienceStateCaptureService = game:GetService("ExperienceStateCaptureService")

local Cryo = require(InGameAssetReportingParent.Cryo)
local React = require(InGameAssetReportingParent.React)
local withLocalization = require(InGameAssetReportingParent.Localization).withLocalization
local ScreenshotManager = require(InGameAssetReportingParent.Screenshot).ScreenshotManager

local Constants = require(InGameAssetReporting.InGameAssetReportUI.Resources.Constants)
local AnalyticsReducer = require(InGameAssetReporting.InGameAssetReportUI.Resources.AnalyticsReducer)
local SceneAnalysis = require(InGameAssetReporting.Analysis.SceneAnalysis)
local InGameAssetReportSubmitDialog = require(InGameAssetReporting.InGameAssetReportUI.Components.InGameAssetReportSubmitDialog)
local InGameAssetReportErrorModal = require(InGameAssetReporting.InGameAssetReportUI.Components.InGameAssetReportErrorModal)
local InGameAssetReportCompleteModal = require(InGameAssetReporting.InGameAssetReportUI.Components.InGameAssetReportCompleteModal)
local InGameAssetReportLandscapeHeader = require(InGameAssetReporting.InGameAssetReportUI.Components.InGameAssetReportLandscapeHeader)

local InGameAssetReportPortraitHeaderFooter = require(InGameAssetReporting.InGameAssetReportUI.Components.InGameAssetReportPortraitHeaderFooter)
local ScreenshotHighlighter = require(InGameAssetReporting.InGameAssetReportUI.Components.ScreenshotHighlighter)
local buildReport = require(InGameAssetReporting.Utility.buildReport)
local InGameAssetReportAnalytics = require(InGameAssetReporting.InGameAssetReportUI.Resources.InGameAssetReportAnalytics)

local function func1(arg1)
    return arg1.point
end

local function func2(arg1)
    return arg1.interpretationResult
end

return function(tbl1)
    local annotationPoints, var2 = React.useState({})
    local var3, var4 = React.useState({})
    local var5, var6 = React.useState(false)
    local var7, var8 = React.useState(false)
    local var9, var10 = React.useState(false)
    local var11, var12 = React.useState("")
    local results, var14 = React.useState(nil)
    local var15, var16 = React.useState(nil)
    local var17, var18 = React.useState(true)
    local var19, analyticsDispatch = React.useReducer(AnalyticsReducer, Constants.AnalyticsInitialState)
    local var21, var22 = React.useState(nil)

    local viewportSize = game.Workspace.CurrentCamera.ViewportSize
    local isPortraitMode = tbl1.getIsSmallPortraitMode(viewportSize)

    React.useEffect(function()
        analyticsDispatch(
            {
                type = Constants.AnalyticsActions.AccumulateForTimeSpent,
                accumulated_time_ms = workspace:GetServerTimeNow() * 1000
            }
        )
        analyticsDispatch({ type = Constants.AnalyticsActions.SetPlaceId, place_id = game.PlaceId })
    end, {})

    local handleNewAnnotationPoint = React.useCallback(function(vector2: Vector2, num1: number)
        local tbl2 = { point = vector2, interpretationResult = 0 }
        local interpretAnnotation = SceneAnalysis.interpretAnnotation
        local var23 = vector2 * viewportSize
        local viewportSizeX = viewportSize.X
        local viewportSizeY = viewportSize.Y
        tbl2.interpretationResult = interpretAnnotation(var23, num1 * math.max(viewportSizeX, viewportSizeY), function() end)

        tbl2.signalConnection = ExperienceStateCaptureService.ItemSelectedInCaptureMode:Once(function(instance: Instance)
            tbl2.engineSignalItem = instance
        end)

        for _, value in ipairs(annotationPoints) do
            value.signalConnection:Disconnect()
        end

        if #annotationPoints == 0 and var11 == "" then
            ScreenshotManager:TakeScreenshotWithCallback(var12, nil)
        end

        local var24 = table.clone(annotationPoints)
        table.insert(var24, tbl2)
        var2(var24)
        var4({})

        analyticsDispatch({ type = Constants.AnalyticsActions.IncremementAnnotationCount })

        task.defer(tbl2.interpretationResult.raycastComputation)
    end, {
        annotationPoints,
        var2,
        var4,
        var11
    })
    local undoAnnotationPoints = React.useCallback(function()
        if not (#annotationPoints > 0) then
            return
        end
        local var24 = table.clone(annotationPoints)
        local var25 = table.clone(var3)

        table.insert(var25, table.remove(var24))

        var4(var25)
        var2(var24)

        analyticsDispatch({ type = Constants.AnalyticsActions.IncremementAnnotationUndoCount })
    end, {
        var2,
        annotationPoints,
        var4,
        var3
    })
    local redoAnnotationPoints = React.useCallback(function()
        if not (#var3 > 0) then
            return
        end
        local var25 = table.clone(annotationPoints)
        local var26 = table.clone(var3)

        table.insert(var25, table.remove(var26))

        var4(var26)
        var2(var25)

        analyticsDispatch({ type = Constants.AnalyticsActions.IncremementAnnotationRedoCount })
    end, { annotationPoints, var3 })

    local nextAction = React.useCallback(function()
        if #annotationPoints == 0 and var11 == "" then
            ScreenshotManager:TakeScreenshotWithCallback(var12, nil)
        end

        local var26 = Cryo.List.map(annotationPoints, function(arg1)
            return arg1.engineSignalItem
        end)
        local var27 = SceneAnalysis.interpretInstanceListForGUIObjects(var26)
        local var28 = SceneAnalysis.extractItemsFromInterpretations({ var27 }, function() end)

        var16(var28)
        task.defer(var28.computation)

        local var29 = Cryo.List.map(annotationPoints, func2)
        local var30 = SceneAnalysis.extractItemsFromInterpretations(var29, function() end)
        var14(var30)
        var6(true)

        analyticsDispatch({
            type = Constants.AnalyticsActions.SetViewportInformation,
            viewport_size_x = viewportSize.X,
            viewport_size_y = viewportSize.Y,
            is_portrait_mode = isPortraitMode
        })
        analyticsDispatch({ type = Constants.AnalyticsActions.IncrementNextCount })

        task.defer(var30.computation)
    end, {
        annotationPoints,
        var6,
        var14,
        var11,
        viewportSize,
        isPortraitMode
    })

    local backAction = React.useCallback(function()
        InGameAssetReportAnalytics(var19, 2)
        tbl1.backAction()
    end, { tbl1.backAction, var19 })

    local var1 = Cryo.List.map(annotationPoints, func1)

    local onSubmit = React.useCallback(function(reasonSelection: string, surfaceSelection: string, arg1)
        var6(false)
        var8(true)

        analyticsDispatch({
            type = Constants.AnalyticsActions.SetExtractionResults,
            results = results,
            final_annotation_count = #annotationPoints
        })

        analyticsDispatch({ type = Constants.AnalyticsActions.SetReasonSelection, reason_selection = reasonSelection })

        analyticsDispatch({ type = Constants.AnalyticsActions.SetSurfaceSelection, surface_selection = surfaceSelection })

        analyticsDispatch({ type = Constants.AnalyticsActions.SetCommentAdded, comment_added = #arg1 > 0 })

        local report = buildReport(Players.LocalPlayer.UserId, var11, results, reasonSelection, surfaceSelection, arg1, var1, var15)

        if report then
            Players:ReportAbuseV3(Players.LocalPlayer, report)
        end
    end, {
        results,
        var15,
        var6,
        var8,
        var11,
        annotationPoints,
        var1
    })

    local onBack = React.useCallback(function()
        var14(nil)
        var6(false)
    end, { var6, var14 })

    local onClose = React.useCallback(function()
        var8(false)
        InGameAssetReportAnalytics(var19, 1)
        tbl1.onReportComplete()
    end, {
        tbl1.onReportComplete,
        annotationPoints,
        var8,
        var19
    })

    local onExceedMaxAnnotationLimit = React.useCallback(function()
        for _, value in ipairs(annotationPoints) do
            value.signalConnection:Disconnect()
        end

        var10(true)
    end, { var10, annotationPoints })

    local var13 = React.useCallback(function()
        var10(false)
    end, {})

    local var34 = React.useCallback(function()
        if var17 then
            var18(false)
        else
            analyticsDispatch({ type = Constants.AnalyticsActions.SetDidUserResize, did_user_resize = true })
        end

        if not var5 then
            var2({})
            var4({})
        end
    end, { var17, var5 })

    local isUndoEnabled = #annotationPoints > 0
    local isRedoEnabled = #var3 > 0

    React.useEffect(function()
        if var21 then
            var21:Disconnect()
        end

        local connection = UserInputService.InputEnded:Connect(function(input: InputObject)
            if input.KeyCode == Enum.KeyCode.Escape then
                backAction()
            end
        end)

        var22(connection)
    end, { backAction })

    return withLocalization(
        {
            mainTitle = "Feature.ReportAbuse.Label.HighlightProblem",
            next = "CommonUI.Controls.Action.Continue"
        }
    )(
        function(arg1)
            local createElement = React.createElement
            local str1 = "Frame"
            local tbl2 = {
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                [React.Change.AbsoluteSize] = var34
            }
            local tbl3 = {
                Header = 0,
                Footer = 0,
                ScreenshotAnnotation = 0,
                ErrorStateModal = 0,
                SubmitDialog = 0,
                ReportCompleteModal = 0
            }
            local createElement2 = React.createElement
            local str2 = "TextButton"
            local tbl4 = {
                Size = UDim2.new(1, 0, 0, 72),
                BackgroundTransparency = 1,
                ZIndex = 2,
                AutoButtonColor = false
            }

            local tbl5 = {
                Layout = React.createElement("UIListLayout", {
                    FillDirection = Enum.FillDirection.Vertical,
                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
                    SortOrder = Enum.SortOrder.LayoutOrder
                }),
                InGameAssetReportModeHeader = 0
            }
            local element

            if isPortraitMode then
                element = React.createElement(InGameAssetReportPortraitHeaderFooter.PortraitModeHeader, {
                    titleText = arg1.mainTitle,
                    nextText = arg1.next,
                    backAction = backAction,
                    undoAnnotationPoints = undoAnnotationPoints,
                    redoAnnotationPoints = redoAnnotationPoints,
                    isRedoEnabled = isRedoEnabled,
                    isUndoEnabled = isUndoEnabled,
                    annotationPoints = annotationPoints
                })
            else
                element = React.createElement(InGameAssetReportLandscapeHeader, {
                    titleText = arg1.mainTitle,
                    nextText = arg1.next,
                    nextAction = nextAction,
                    backAction = backAction,
                    undoAnnotationPoints = undoAnnotationPoints,
                    redoAnnotationPoints = redoAnnotationPoints,
                    isRedoEnabled = isRedoEnabled,
                    isUndoEnabled = isUndoEnabled,
                    annotationPoints = annotationPoints
                })
            end

            tbl5.InGameAssetReportModeHeader = element
            tbl3.Header = createElement2(str2, tbl4, tbl5)
            local element2

            if isPortraitMode then
                element2 = React.createElement("TextButton", {
                    Size = UDim2.new(1, 0, 0, 60),
                    Position = UDim2.new(0, 0, 1, -60),
                    ZIndex = 2,
                    BackgroundTransparency = 1,
                    AutoButtonColor = false
                }, {
                    InGameAssetReportModeFooter = React.createElement(
                        InGameAssetReportPortraitHeaderFooter.PortraitModeFooter,
                        {
                            nextAction = nextAction,
                            annotationPoints = annotationPoints,
                            nextText = arg1.next
                        }
                    )
                })
            else
                element2 = nil
            end

            tbl3.Footer = element2

            tbl3.ScreenshotAnnotation = React.createElement(
                "Frame",
                {
                    BackgroundTransparency = 1,
                    LayoutOrder = 2,
                    Size = UDim2.new(1, 0, 1, 0),
                    ZIndex = 1
                },
                {
                    Highlighter = React.createElement(ScreenshotHighlighter, {
                        annotationPoints = var1,
                        handleNewAnnotationPoint = handleNewAnnotationPoint,
                        onExceedMaxAnnotationLimit = onExceedMaxAnnotationLimit,
                        ZIndex = 2
                    }, {})
                }
            )
            tbl3.ErrorStateModal = if var9 then React.createElement(InGameAssetReportErrorModal, { screenSize = viewportSize, onBack = var13 }) else nil

            tbl3.SubmitDialog = if var5 then React.createElement(
                InGameAssetReportSubmitDialog,
                {
                    screenSize = viewportSize,
                    onSubmit = onSubmit,
                    onBack = onBack,
                    analyticsDispatch = analyticsDispatch
                }
            ) else nil

            tbl3.ReportCompleteModal = if var7 then React.createElement(InGameAssetReportCompleteModal, { screenSize = viewportSize, onClose = onClose }) else nil
            return createElement(str1, tbl2, tbl3)
        end
    )
end
