-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T12:30:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TelemetryService = game:GetService("TelemetryService")

local _Types = require(script.Parent.Types)
local Constants = require(script.Parent.Constants)
local tryMilestoneOperation = require(script.Parent.tryMilestoneOperation)

return {
    reportHoldGateHit = function(arg1, holdGateHit: boolean)
        return tryMilestoneOperation(function()
            local customFields = table.clone(arg1)
            customFields.dismissSource = Constants.DismissSource.NormalReady
            customFields.holdGateHit = holdGateHit
            TelemetryService:LogCounter({
                eventName = Constants.EVENT_NAME .. "_HoldGateHit",
                backends = { "RobloxTelemetryCounter" },
                lastUpdated = { 2026, 10, 12 },
                description = "Completed normal-first HoldOn screens without reduced motion, with readiness and gate-release observations, split by whether readiness preceded gate release.",
                links = "https://roblox.atlassian.net/wiki/x/AAPROQE"
            }, { customFields = customFields }, 1)
        end)
    end,
    reportContentVisibility = function(arg1, titleVisible: boolean, creatorVisible: boolean, thumbnailVisible: boolean)
        return tryMilestoneOperation(function()
            local customFields = table.clone(arg1)
            customFields.titleVisible = titleVisible
            customFields.creatorVisible = creatorVisible
            customFields.thumbnailVisible = thumbnailVisible
            customFields.allContentVisible = titleVisible and creatorVisible and thumbnailVisible

            TelemetryService:LogCounter({
                eventName = Constants.EVENT_NAME .. "_ContentVisibility",
                backends = { "RobloxTelemetryCounter" },
                lastUpdated = { 2026, 10, 11 },
                description = "Completed loading screens with mount and dismissal-start observations, split by title, creator, thumbnail, and all-content visibility before dismissal.",
                links = "https://roblox.atlassian.net/wiki/x/AAPROQE"
            }, { customFields = customFields }, 1)
        end)
    end,
    reportAddedWait = function(arg1, num1: number, dismissSource)
        return tryMilestoneOperation(function()
            local customFields = table.clone(arg1)
            customFields.dismissSource = dismissSource
            TelemetryService:LogStat({
                eventName = "TiltLoadingScreenAddedWait",
                backends = { "RobloxTelemetryStat" },
                lastUpdated = { 2026, 10, 1 },
                description = "Milliseconds from the first dismissal request to dismissal start in completed loading screens.",
                links = "https://roblox.atlassian.net/wiki/x/AAPROQE"
            }, { customFields = customFields }, num1)
        end)
    end,
    getMilestoneSessionMetadata = function(subcategory: string, page)
        return {
            category = Constants.CATEGORY,
            page = page,
            subcategory = subcategory,
            AppVersion = RunService:GetRobloxVersion(),
            CoreScriptVersion = RunService:GetCoreScriptVersion(),
            Platform = tostring(UserInputService:GetPlatform())
        }
    end,
    countMilestonesStarted = function(customFields)
        return tryMilestoneOperation(function()
            TelemetryService:LogCounter({
                eventName = Constants.EVENT_NAME .. "_MilestonesStarted",
                backends = { "RobloxTelemetryCounter" },
                lastUpdated = { 2026, 11, 2 },
                description = "Instrumented loading screens, before tracker initialization.",
                links = "https://roblox.atlassian.net/wiki/x/AAPROQE"
            }, { customFields = customFields }, 1)
        end)
    end,
    countMilestonesOutcome = function(arg1, outcome)
        return tryMilestoneOperation(function()
            local customFields = table.clone(arg1)
            customFields.outcome = outcome
            TelemetryService:LogCounter({
                eventName = Constants.EVENT_NAME .. "_MilestonesOutcome",
                backends = { "RobloxTelemetryCounter" },
                lastUpdated = { 2026, 11, 2 },
                description = "Terminal outcomes of instrumented loading screens, independent of TTI sampling.",
                links = "https://roblox.atlassian.net/wiki/x/AAPROQE"
            }, { customFields = customFields }, 1)
        end)
    end
}
