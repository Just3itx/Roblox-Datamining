-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:51:29Z
-- Luau bytecode version: 14 | Luau type version: 3
local AbuseReportMenu = script:FindFirstAncestor("AbuseReportMenu")
local _Types = require(AbuseReportMenu.Components.Types)
local MenuConfigs = AbuseReportMenu.MenuConfigs

local OptionalAttachScreenshotMenuConfig = require(MenuConfigs.Experience.OptionalAttachScreenshotMenuConfig)
local AbuseReasonMenuConfig = require(MenuConfigs.Experience.AbuseReasonMenuConfig)
local SubmitReportButtonMenuConfig = require(MenuConfigs.Experience.SubmitReportButtonMenuConfig)
return {
    AbuseReasonMenuConfig,
    OptionalAttachScreenshotMenuConfig,
    require(MenuConfigs.Experience.FreeFormCommentMenuConfig),
    SubmitReportButtonMenuConfig
}
