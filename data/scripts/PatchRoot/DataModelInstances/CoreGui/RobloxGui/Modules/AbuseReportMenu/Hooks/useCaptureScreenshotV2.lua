-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:51:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AbuseReportMenu = script:FindFirstAncestor("AbuseReportMenu")

local CorePackages = game:GetService("CorePackages")
local React = require(CorePackages.Packages.React)

local Constants = require(AbuseReportMenu.Components.Constants)
local _Types = require(AbuseReportMenu.Components.Types)
local TnSIXPWrapper = require(AbuseReportMenu.IXP.TnSIXPWrapper)
local runScreenshotCaptureSequence = require(script.Parent.runScreenshotCaptureSequence)

local function emptySnapshot() -- Luacid: Inlined by compiler; 2 call sites recovered
    return {
        screenshotId = "",
        identificationResults = Constants.InitialIdentificationResults
    }
end

local function useCaptureScreenshotV2()
    local snapshotRef = React.useRef((emptySnapshot()))

    local isScreenshotTaken, var3 = React.useState(false)

    local var4 = React.useRef("idle")

    local var5 = TnSIXPWrapper.getReportAnythingAvatarEnabled() or TnSIXPWrapper.getReportAnythingExperienceEnabled()

    local var6 = React.useRef(var5)
    var6.current = var5

    local reset = React.useCallback(function()
        snapshotRef.current = emptySnapshot()
        var4.current = "idle"
        var3(false)
    end, {})

    local getIsCapturing = React.useCallback(function(): boolean
        return var4.current == "capturing"
    end, {})

    return {
        captureIfApplicable = React.useCallback(function(tbl1)
            if not var6.current or var4.current ~= "idle" then
                return
            end

            var4.current = "capturing"

            runScreenshotCaptureSequence({
                hide = tbl1.hide,
                show = tbl1.show,
                onScreenshotTaken = function()
                    var3(true)
                end,
                onScreenshotUploaded = function(screenshotId: string)
                    snapshotRef.current = {
                        screenshotId = screenshotId,
                        identificationResults = snapshotRef.current.identificationResults
                    }
                end,
                onIdentificationCompleted = function(identificationResults)
                    snapshotRef.current = {
                        screenshotId = snapshotRef.current.screenshotId,
                        identificationResults = identificationResults
                    }
                end,
                onCaptureEnd = function()
                    var4.current = "done"
                end
            })
        end, {}),
        reset = reset,
        getIsCapturing = getIsCapturing,
        isCaptureApplicable = var5,
        isScreenshotTaken = isScreenshotTaken,
        snapshotRef = snapshotRef
    }
end

return useCaptureScreenshotV2
