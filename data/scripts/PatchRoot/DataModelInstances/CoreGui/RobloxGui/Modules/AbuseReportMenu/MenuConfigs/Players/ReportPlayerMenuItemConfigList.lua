-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:00:40Z
-- Luau bytecode version: 14 | Luau type version: 3
local AbuseReportMenu = script:FindFirstAncestor("AbuseReportMenu")
local _Types = require(AbuseReportMenu.Components.Types)
local MenuConfigs = AbuseReportMenu.MenuConfigs

local MethodOfAbuseModalMenuConfig = require(MenuConfigs.Players.MethodOfAbuseModalMenuConfig)
local OptionalAttachScreenshotMenuConfig = require(MenuConfigs.Players.OptionalAttachScreenshotMenuConfig)
local PlayerModalSelectorMenuConfig = require(MenuConfigs.Players.PlayerModalSelectorMenuConfig)
local AbuseReasonModalSelectorMenuConfig = require(MenuConfigs.Players.AbuseReasonModalSelectorMenuConfig)
local SubmitReportButtonMenuConfig = require(MenuConfigs.Players.SubmitReportButtonMenuConfig)
return {
    MethodOfAbuseModalMenuConfig,
    PlayerModalSelectorMenuConfig,
    AbuseReasonModalSelectorMenuConfig,
    OptionalAttachScreenshotMenuConfig,
    require(MenuConfigs.Players.FreeFormCommentMenuConfig),
    SubmitReportButtonMenuConfig
}
