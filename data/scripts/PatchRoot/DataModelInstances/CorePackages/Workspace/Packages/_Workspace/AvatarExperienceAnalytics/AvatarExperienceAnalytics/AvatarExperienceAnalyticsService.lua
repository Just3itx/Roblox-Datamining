-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:41:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local AvatarExperienceAnalytics = script:FindFirstAncestor("AvatarExperienceAnalytics")

local open3DFullView = require(AvatarExperienceAnalytics.open3DFullView)
local close3DFullView = require(AvatarExperienceAnalytics.close3DFullView)

local AnalyticsService = require(AvatarExperienceAnalytics.AnalyticsService)

local reportAvatarEventCounterV1 = require(AvatarExperienceAnalytics.reportAvatarEventCounterV1)
local Constants = require(AvatarExperienceAnalytics.Constants)

local module = {}

local var1 = nil

function module.get(_)
    if var1 then
        return var1
    end

    local var2 = AnalyticsService
    local tbl1 = {
        open3DFullView = function(arg1)
            open3DFullView(var2.EventStream, arg1)
        end,
        close3DFullView = function(arg1)
            close3DFullView(var2.EventStream, arg1)
        end,
        toggleCameraInEditorAndShop = function(arg1, pageName)
            var2.EventStream:sendTelemetryEvent(
                "CameraInEditorAndCatalogButton",
                "CameraInEditorAndCatalogButton_Toggle",
                {
                    actionName = if arg1 then "Button Enabled" else "Button Disabled",
                    pageName = pageName
                }
            )
            reportAvatarEventCounterV1(
                if arg1 then Constants.AVATAR_EVENT_COUNTER_NAME.AXCameraEnabled else Constants.AVATAR_EVENT_COUNTER_NAME.AXCameraDisabled
            )
        end
    }

    var1 = tbl1
    return tbl1
end

return module
