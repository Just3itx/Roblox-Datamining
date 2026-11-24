-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T22:21:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InGameAssetReporting = script:FindFirstAncestor("InGameAssetReporting")
local InGameAssetReportingParent = InGameAssetReporting.Parent

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local ExperienceStateCaptureService = game:GetService("ExperienceStateCaptureService")
local HttpService = game:GetService("HttpService")
local ContentProvider = game:GetService("ContentProvider")

local React = require(InGameAssetReportingParent.React)
local withLocalization = require(InGameAssetReportingParent.Localization).withLocalization
local ScreenshotManager = require(InGameAssetReportingParent.Screenshot).ScreenshotManager
local LuauPolyfill = require(InGameAssetReportingParent.LuauPolyfill)
local clearTimeout = LuauPolyfill.clearTimeout
local setTimeout = LuauPolyfill.setTimeout

local Constants = require(InGameAssetReporting.InGameAssetReportUI.Resources.Constants)
local AnalyticsReducer = require(InGameAssetReporting.InGameAssetReportUI.Resources.AnalyticsReducer)
local SceneAnalysis = require(InGameAssetReporting.Analysis.SceneAnalysis)
local InGameAssetReportSubmitDialog = require(InGameAssetReporting.InGameAssetReportUI.Components.InGameAssetReportSubmitDialog)
local InGameAssetReportCompleteModal = require(InGameAssetReporting.InGameAssetReportUI.Components.InGameAssetReportCompleteModal)

local InGameAssetIPInfringementErrorModal = require(InGameAssetReporting.InGameAssetReportUI.Components.InGameAssetIPInfringementErrorModal)

local InGameAssetReportIPInfringementModal = require(InGameAssetReporting.InGameAssetReportUI.Components.InGameAssetReportIPInfringementModal)

local ReportPreciseSelectionLandscapeHeader = require(InGameAssetReporting.InGameAssetReportUI.Components.PreciseSelection.ReportPreciseSelectionLandscapeHeader)

local ReportPreciseSelectionPortraitHeaderFooter = require(InGameAssetReporting.InGameAssetReportUI.Components.PreciseSelection.ReportPreciseSelectionPortraitHeaderFooter)
local buildReport = require(InGameAssetReporting.Utility.buildReport)
local InGameAssetReportAnalytics = require(InGameAssetReporting.InGameAssetReportUI.Resources.InGameAssetReportAnalytics)
local getHighlightModeVariant = require(InGameAssetReporting.Utility.getHighlightModeVariant)

local bool1 = game:DefineFastFlag("PreciseSelectionBugfixesEnabled", false)
local FFlagPrefillPreciseSelectionChoices = require(InGameAssetReportingParent.SharedFlags).FFlagPrefillPreciseSelectionChoices

local var1 = string.gsub(ContentProvider.BaseUrl:lower(), "/m.", "/www.")
local Url = string.gsub(string.gsub(var1, "http:", "https:"), "https://www", "https://apis") .. "rights-management-api/rights/v1/snapshots"

return function(tbl1)
    local var3, var4 = React.useState(false)
    local var5, var6 = React.useState(false)
    local var7, var8 = React.useState(false)
    local screenshotId, var10 = React.useState("")
    local results, var12 = React.useState(nil)
    local var13, var14 = React.useState(true)
    local var15, analyticsDispatch = React.useReducer(AnalyticsReducer, Constants.AnalyticsInitialState)
    local var17, var18 = React.useState(nil)
    local var19, var20 = React.useState(nil)
    local var21, var22 = React.useState(nil)
    local isCoachmarkOpen, var24 = React.useState(false)
    local var25, var26 = React.useState(nil)
    local reportCode, var28 = React.useState("")
    local errorCode, var30 = React.useState(nil)
    local isReportExperienceLoading, var32 = React.useState(false)

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

        var26(setTimeout(function()
            var24(true)
        end, 10000))
    end, { var24, var26 })

    local onCoachmarkClose = React.useCallback(function()
        var24(false)
        if var25 then
            clearTimeout(var25)
        end
    end, { var24, var25 })

    local var34 = React.useCallback(function()
        if bool1 then
            if screenshotId == "" then
                ScreenshotManager:TakeScreenshotWithCallback(var10, nil)
            end
        elseif not screenshotId then
            ScreenshotManager:TakeScreenshotWithCallback(var10, nil)
        end

        onCoachmarkClose()

        var4(true)

        analyticsDispatch({
            type = Constants.AnalyticsActions.SetViewportInformation,
            viewport_size_x = viewportSize.X,
            viewport_size_y = viewportSize.Y,
            is_portrait_mode = isPortraitMode
        })
        analyticsDispatch({ type = Constants.AnalyticsActions.IncrementNextCount })
    end, {
        var4,
        var10,
        screenshotId,
        viewportSize,
        isPortraitMode,
        analyticsDispatch,
        onCoachmarkClose
    })

    local nextAction = React.useCallback(function()
        var12(SceneAnalysis.interpretAndExtractItemsFromInstanceForPreciseSelection(var21))

        var34()
    end, { var34, var12, var21 })

    local backAction = React.useCallback(function()
        InGameAssetReportAnalytics(var15, 2)
        tbl1.backAction()
    end, { tbl1.backAction, var15 })

    React.useEffect(function()
        if var19 then
            var19:Disconnect()
        end
        local connection = ExperienceStateCaptureService.ItemSelectedInCaptureMode:Connect(function(instance: Instance)
            var22(instance)
            if instance then
                analyticsDispatch({ type = Constants.AnalyticsActions.IncremementAnnotationCount })

                if bool1 then
                    onCoachmarkClose()
                end
            end
            if UserInputService.PreferredInput ~= Enum.PreferredInput.Touch then
                var12(SceneAnalysis.interpretAndExtractItemsFromInstanceForPreciseSelection(instance))
                var34()
            end
        end)
        var20(connection)
    end, {
        var22,
        var20,
        var34,
        var12,
        analyticsDispatch,
        onCoachmarkClose
    })

    local onSubmit = React.useCallback(function(reasonSelection: string, surfaceSelection: string, arg1)
        if reasonSelection ~= "ip infringement" then
            var4(false)
            var6(true)
            analyticsDispatch(
                {
                    type = Constants.AnalyticsActions.SetExtractionResults,
                    results = results,
                    final_annotation_count = 0
                }
            )

            analyticsDispatch({ type = Constants.AnalyticsActions.SetReasonSelection, reason_selection = reasonSelection })

            analyticsDispatch({ type = Constants.AnalyticsActions.SetSurfaceSelection, surface_selection = surfaceSelection })

            analyticsDispatch({ type = Constants.AnalyticsActions.SetCommentAdded, comment_added = #arg1 > 0 })

            local variant = getHighlightModeVariant()
            analyticsDispatch({ type = Constants.AnalyticsActions.SetVariant, variant = variant })

            local report = buildReport(
                Players.LocalPlayer.UserId,
                screenshotId,
                results,
                reasonSelection,
                surfaceSelection,
                arg1,
                {},
                nil,
                variant
            )

            if report then
                Players:ReportAbuseV3(Players.LocalPlayer, report)
            end

            return
        end

        if not (results and results.extractedAssets) then
            var30(Constants.IpErrorCodes.ClientNoAssetsExtracted)
            return
        end

        local contents = {}
        for k, extractedAsset in pairs(results.extractedAssets) do
            for _, value in ipairs(extractedAsset) do
                if k == "Package" then
                    value = value.id
                end
                if not value then
                    continue
                end
                local contentId = string.match(value, "%d+")
                if contentId and contentId ~= "" then
                    table.insert(contents, { content_type = "Asset", content_id = contentId })
                end
            end
        end

        if not (#contents > 0) then
            var30(Constants.IpErrorCodes.ClientNoAssetsExtracted)
            return
        end

        local input = {
            screenshot_id = screenshotId,
            universe_id = game.GameId,
            contents = contents
        }
        local body = HttpService:JSONEncode(input)

        HttpService:RequestInternal({
            Url = Url,
            Method = "POST",
            Headers = { ["Content-Type"] = "application/json", Accept = "application/json" },
            Body = body
        }):Start(
            function(_, arg2)
                if arg2.StatusCode == 200 then
                    local success, result = pcall(HttpService.JSONDecode, HttpService, arg2.Body)
                    if success and result and result.code then
                        var28(result.code)
                        var8(true)
                        return
                    end
                    var30(Constants.IpErrorCodes.Unknown)
                    return
                end
                local unknown = Constants.IpErrorCodes.Unknown
                local success, result = pcall(HttpService.JSONDecode, HttpService, arg2.Body)
                if success and result and result.app_error_code and result.app_error_code ~= "" then
                    unknown = result.app_error_code
                end
                var30(unknown)
            end
        )
    end, {
        results,
        var4,
        var6,
        screenshotId,
        var30,
        var8,
        var28,
        analyticsDispatch
    })

    local onBack = React.useCallback(function()
        var12(nil)
        var4(false)
        ExperienceStateCaptureService:ResetHighlight()
    end, { var4, var12 })

    local onClose = React.useCallback(function()
        var6(false)
        InGameAssetReportAnalytics(var15, 1)
        tbl1.onReportComplete()
    end, { tbl1.onReportComplete, var6, var15 })

    local var40 = React.useCallback(function()
        if var13 then
            var14(false)
            return
        end
        analyticsDispatch({ type = Constants.AnalyticsActions.SetDidUserResize, did_user_resize = true })
    end, {
        var13,
        var3,
        analyticsDispatch,
        var14
    })

    React.useEffect(function()
        if var17 then
            var17:Disconnect()
        end

        local connection = UserInputService.InputEnded:Connect(function(input: InputObject)
            if input.KeyCode == Enum.KeyCode.Escape then
                backAction()
            end
        end)

        var18(connection)
    end, { backAction, var18 })

    local var2 = React.useCallback(function()
        var30(nil)
    end, {})

    local onReportExperience = React.useCallback(function()
        var32(true)

        local body = HttpService:JSONEncode({ screenshot_id = screenshotId, universe_id = game.GameId, contents = {} })

        HttpService:RequestInternal({
            Url = Url,
            Method = "POST",
            Headers = { ["Content-Type"] = "application/json", Accept = "application/json" },
            Body = body
        }):Start(
            function(_, arg1)
                var32(false)
                if arg1.StatusCode == 200 then
                    local success, result = pcall(HttpService.JSONDecode, HttpService, arg1.Body)
                    if success and result and result.code then
                        var28(result.code)
                        var30(nil)
                        var8(true)
                        return
                    end
                end
                var30(Constants.IpErrorCodes.Unknown)
            end
        )
    end, {
        screenshotId,
        var28,
        var30,
        var8,
        var32
    })

    return withLocalization({
        mainTitle = "Feature.ReportAbuse.Label.HighlightProblemPrecise",
        next = "CommonUI.Controls.Action.Continue",
        coachmarkTitle = "Feature.ReportAbuse.Label.CantSelectTitle",
        coachmarkText = "Feature.ReportAbuse.Label.CantSelectSubtitle"
    })(
        function(arg1)
            local createElement = React.createElement
            local str1 = "Frame"
            local tbl2 = {
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                [React.Change.AbsoluteSize] = var40
            }
            local tbl3 = {
                Header = 0,
                Footer = 0,
                SubmitDialog = 0,
                ReportCompleteModal = 0,
                IPInfringementModal = 0,
                ErrorModal = 0
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
                element = React.createElement(
                    ReportPreciseSelectionPortraitHeaderFooter.PortraitModeHeader,
                    {
                        titleText = arg1.mainTitle,
                        nextText = arg1.next,
                        backAction = backAction
                    }
                )
            else
                element = React.createElement(ReportPreciseSelectionLandscapeHeader, {
                    titleText = arg1.mainTitle,
                    nextText = arg1.next,
                    nextAction = nextAction,
                    backAction = backAction,
                    coachmarkTitle = arg1.coachmarkTitle,
                    coachmarkText = arg1.coachmarkText,
                    isCoachmarkOpen = isCoachmarkOpen,
                    onCoachmarkClose = onCoachmarkClose
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
                    InGameAssetReportModeFooter = React.createElement(ReportPreciseSelectionPortraitHeaderFooter.PortraitModeFooter, {
                        nextAction = nextAction,
                        nextText = arg1.next,
                        isCoachmarkOpen = isCoachmarkOpen,
                        onCoachmarkClose = onCoachmarkClose,
                        coachmarkTitle = arg1.coachmarkTitle,
                        coachmarkText = arg1.coachmarkText
                    })
                })
            else
                element2 = nil
            end

            tbl3.Footer = element2
            local element3 = if var3 then React.createElement(InGameAssetReportSubmitDialog, {
                screenSize = viewportSize,
                onSubmit = onSubmit,
                onBack = onBack,
                analyticsDispatch = analyticsDispatch,
                extractionResult = if FFlagPrefillPreciseSelectionChoices then results else nil
            }) else nil
            tbl3.SubmitDialog = element3

            tbl3.ReportCompleteModal = if var5 then React.createElement(InGameAssetReportCompleteModal, { screenSize = viewportSize, onClose = onClose }) else nil

            tbl3.IPInfringementModal = if var7 then React.createElement(
                InGameAssetReportIPInfringementModal,
                { screenSize = viewportSize, reportCode = reportCode, onClose = onClose }
            ) else nil

            tbl3.ErrorModal = if errorCode == nil then nil else React.createElement(InGameAssetIPInfringementErrorModal, {
                screenSize = viewportSize,
                onBack = var2,
                errorCode = errorCode,
                onReportExperience = onReportExperience,
                isReportExperienceLoading = isReportExperienceLoading
            })
            return createElement(str1, tbl2, tbl3)
        end
    )
end
