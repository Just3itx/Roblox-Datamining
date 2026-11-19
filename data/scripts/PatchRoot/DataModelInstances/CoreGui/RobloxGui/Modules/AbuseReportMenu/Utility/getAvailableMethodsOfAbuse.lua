-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:01:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AbuseReportMenu = script:FindFirstAncestor("AbuseReportMenu")
local CorePackages = game:GetService("CorePackages")
local Constants = require(AbuseReportMenu.Components.Constants)

local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)

function getAvailableMethodsOfAbuse(bool1: boolean, bool2: boolean)
    local tbl1 = {{
        label = RobloxTranslator:FormatByKey(Constants.localizationKeys[Constants.AbuseMethods.TextChat]),
        subLabel = RobloxTranslator:FormatByKey("Feature.SettingsHub.MethodOfAbuse.Text.Subtitle"),
        identifier = Constants.AbuseMethods.TextChat
    }}

    if bool2 then
        tbl1[#tbl1 + 1] = {
            label = RobloxTranslator:FormatByKey(Constants.localizationKeys[Constants.AbuseMethods.Avatar]),
            subLabel = RobloxTranslator:FormatByKey("Feature.SettingsHub.MethodOfAbuse.AvatarSubtitle"),
            identifier = Constants.AbuseMethods.Avatar
        }
    else
        tbl1[#tbl1 + 1] = {
            label = RobloxTranslator:FormatByKey(Constants.localizationKeys[Constants.AbuseMethods.Other]),
            subLabel = RobloxTranslator:FormatByKey("Feature.SettingsHub.MethodOfAbuse.Other.Subtitle"),
            identifier = Constants.AbuseMethods.Other
        }
    end
    if bool1 then
        table.insert(tbl1, 1, {
            label = RobloxTranslator:FormatByKey(Constants.localizationKeys[Constants.AbuseMethods.VoiceChat]),
            subLabel = RobloxTranslator:FormatByKey("Feature.SettingsHub.MethodOfAbuse.VoiceChat.Subtitle"),
            identifier = Constants.AbuseMethods.VoiceChat
        })
    end

    return tbl1
end

return getAvailableMethodsOfAbuse
