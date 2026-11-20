-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:40:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local var1 = require(CorePackages.Workspace.Packages.RobloxTranslator):FormatByKey(
    "Feature.SettingsHub.Prompt.RestartOnMicAccessChange"
)
return function(tbl1)
    return if tbl1:GetPlatform() == Enum.Platform.Android then "<b>" .. var1 .. "</b>" else nil
end
