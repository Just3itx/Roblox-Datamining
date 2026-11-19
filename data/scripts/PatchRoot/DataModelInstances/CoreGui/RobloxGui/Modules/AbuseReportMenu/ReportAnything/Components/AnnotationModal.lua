-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:00:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local GuiService = game:GetService("GuiService")
local RobloxGui = CoreGui:WaitForChild("RobloxGui")

local AbuseReportMenu = script:FindFirstAncestor("AbuseReportMenu")
local CorePackages = game:GetService("CorePackages")

local Roact = require(CorePackages.Packages.Roact)
local Chrome = RobloxGui.Modules.Chrome
local ChromeEnabled = require(CorePackages.Workspace.Packages.Chrome).Enabled
local Service = if ChromeEnabled() then require(Chrome.Service) else nil
local _Types = require(AbuseReportMenu.Components.Types)
local Constants = require(AbuseReportMenu.Components.Constants)

local ScreenshotFlowStepHandlerContainer = require(AbuseReportMenu.ReportAnything.Components.ScreenshotFlowStepHandlerContainer)
local _ReportAnythingAnalytics = require(AbuseReportMenu.ReportAnything.Utility.ReportAnythingAnalytics)

local FFlagEnableConsoleExpControls = require(CorePackages.Workspace.Packages.SharedFlags).FFlagEnableConsoleExpControls

local tbl1 = {
    annotationPageHandle = nil,
    annotationPageFrame = nil,
    annotationPageScreenGui = nil
}

local function unmountAnnotationPage()
    if FFlagEnableConsoleExpControls and (if FFlagEnableConsoleExpControls then ChromeEnabled() else ChromeEnabled) then
        Service:setHideShortcutBar("AnnotationModal", false)
    end
    if tbl1.annotationPageHandle ~= nil then
        Roact.unmount(tbl1.annotationPageHandle)
        tbl1.annotationPageHandle = nil
    end
    if tbl1.annotationPageScreenGui ~= nil then
        tbl1.annotationPageFrame.Parent = nil
        tbl1.annotationPageFrame = nil
        tbl1.annotationPageScreenGui = nil
    end
end

return {
    mountAnnotationPage = function(entryPoint: string, callback: (...any) -> (...any), reportAnythingAnalytics, arg1, callback2: (...any) -> (...any))
        if FFlagEnableConsoleExpControls and (if FFlagEnableConsoleExpControls then ChromeEnabled() else ChromeEnabled) then
            Service:setHideShortcutBar("AnnotationModal", true)
        end
        local vector2, _vector2 = GuiService:GetGuiInset()
        if not tbl1.annotationPageScreenGui then
            local annotationPageContents = Instance.new("ScreenGui")
            annotationPageContents.Name = "AnnotationPageContents"
            annotationPageContents.DisplayOrder = 7
            annotationPageContents.Enabled = true
            annotationPageContents.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
            annotationPageContents.Parent = CoreGui:FindFirstChild(Constants.AbuseReportMenuPlaceholderFrame, true)

            tbl1.annotationPageScreenGui = annotationPageContents

            local frame = Instance.new("Frame")
            frame.BackgroundTransparency = 1
            frame.Position = UDim2.new(0, 0, 0, -vector2.Y)
            frame.Size = UDim2.new(1, 0, 1, vector2.Y)
            frame.Parent = tbl1.annotationPageScreenGui

            tbl1.annotationPageFrame = frame
        end

        local element = Roact.createElement(ScreenshotFlowStepHandlerContainer, {
            screenshot = arg1.screenshotContentId,
            entryPoint = entryPoint,
            backAction = function()
                unmountAnnotationPage()
            end,
            dismissAction = function()
                unmountAnnotationPage()
            end,
            finishAnnotationAction = function(annotationPoints)
                unmountAnnotationPage()
                callback2({ type = Constants.ReportAnythingActions.SetAnnotationPoints, annotationPoints = annotationPoints })

                callback2({ type = Constants.ReportAnythingActions.CompleteAttachment })
            end,
            restartAction = function()
                unmountAnnotationPage()

                callback2({ type = Constants.ReportAnythingActions.ClearAll })

                callback()
            end,
            skipAnnotationAction = function()
                unmountAnnotationPage()
                callback2({ type = Constants.ReportAnythingActions.CompleteAttachment })
            end,
            setAnnotationCircleRadius = function(radius)
                callback2({ type = Constants.ReportAnythingActions.SetAnnotationCircleRadius, radius = radius })
            end,
            setAnnotationAreaDimensions = function(width, height)
                callback2({ type = Constants.ReportAnythingActions.SetAnnotationAreaDimensions, width = width, height = height })
            end,
            initialAnnotationPoints = {},
            initialPageNumber = 1,
            viewportInfo = arg1.identificationResults.avatarIDStats.viewportInfo,
            reportAnythingAnalytics = reportAnythingAnalytics
        })
        callback2({ type = Constants.ReportAnythingActions.SetAnnotationOptionSeen })

        tbl1.annotationPageHandle = Roact.mount(element, tbl1.annotationPageFrame, "AnnotationFlow")
    end,
    unmountAnnotationPage = unmountAnnotationPage
}
