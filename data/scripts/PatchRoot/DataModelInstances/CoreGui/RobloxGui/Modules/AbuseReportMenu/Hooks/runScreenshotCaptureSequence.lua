-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:51:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AbuseReportMenu = script:FindFirstAncestor("AbuseReportMenu")

local CorePackages = game:GetService("CorePackages")
local GuiService = game:GetService("GuiService")
local RunService = game:GetService("RunService")

local _Types = require(AbuseReportMenu.Components.Types)

local FFlagIEMTabFocusNav = require(CorePackages.Workspace.Packages.SharedFlags).FFlagIEMTabFocusNav

local TnSAvatarIdentification = require(CorePackages.Workspace.Packages.TnSAvatarIdentification)
local TnSAdIdentification = require(CorePackages.Workspace.Packages.TnSAdIdentification)
local ScreenshotManager = require(CorePackages.Workspace.Packages.TnSScreenshot).ScreenshotManager

local AvatarIdentification = TnSAvatarIdentification.AvatarIdentification
local AdIdentification = TnSAdIdentification.AdIdentification

local num1 = game:DefineFastInt("AbuseReportMenuScreenshotReduceMotionWaitFrames", 20)
local num2 = game:DefineFastInt("AbuseReportMenuScreenshotWaitFrames", 10)

local UserGameSettings = UserSettings():GetService("UserGameSettings")

local function defaultGetWaitFrames(): number -- Luacid: Inlined by compiler; 1 call site recovered
    return if UserGameSettings.ReducedMotion then num1 else num2
end

local function defaultGetWaitTime(): number
    return defaultGetWaitFrames() / 60
end

local function defaultDeps()
    return {
        takeScreenshot = function(arg1)
            return ScreenshotManager:TakeScreenshotWithCallback(arg1)
        end,
        getVisibleAvatars = function()
            return AvatarIdentification.getVisibleAvatars()
        end,
        getVisibleAds = function()
            return AdIdentification.getVisibleAds()
        end,
        runService = RunService,
        getWaitFrames = defaultGetWaitFrames,
        getWaitTime = defaultGetWaitTime
    }
end

local function runIdentification(tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    local identifiedAvatars, avatarIdStats = tbl1.getVisibleAvatars()
    local identifiedAds, adIdStats = tbl1.getVisibleAds()
    return {
        identifiedAvatars = identifiedAvatars,
        identifiedAds = identifiedAds,
        avatarIDStats = avatarIdStats,
        adIDStats = adIdStats
    }
end

local function runScreenshotCaptureSequence(tbl1, tbl2)
    local var1 = tbl2 or defaultDeps()

    local selectedCoreObject = if FFlagIEMTabFocusNav then GuiService.SelectedCoreObject else nil

    tbl1.hide()

    local num3 = 0
    local startTime = os.clock()
    local bool1 = false

    local connection = nil
    connection = var1.runService.Heartbeat:Connect(function()
        if not bool1 and num3 >= 1 then
            bool1 = true
            var1.takeScreenshot(tbl1.onScreenshotUploaded)
            tbl1.onScreenshotTaken()
            tbl1.onIdentificationCompleted((runIdentification(var1)))
        end

        local bool2 = num3 >= var1.getWaitFrames()
        local bool3 = os.clock() - startTime >= var1.getWaitTime()
        if not (bool1 and bool2 and bool3) then
            num3 += 1
            return
        end

        connection:Disconnect()
        tbl1.show()
        if FFlagIEMTabFocusNav and selectedCoreObject and selectedCoreObject:IsDescendantOf(game) then
            GuiService.SelectedCoreObject = selectedCoreObject
        end
        tbl1.onCaptureEnd()
    end)
end
return runScreenshotCaptureSequence
