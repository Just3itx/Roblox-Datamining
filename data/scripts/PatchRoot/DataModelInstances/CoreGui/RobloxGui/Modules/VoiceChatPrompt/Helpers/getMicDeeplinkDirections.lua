-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:40:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)

local var1 = RobloxTranslator:FormatByKey("Feature.SettingsHub.Prompt.AndroidWithDeeplink")
local var2 = RobloxTranslator:FormatByKey("Feature.SettingsHub.Prompt.WindowsWithDeeplink")
local var3 = RobloxTranslator:FormatByKey("Feature.SettingsHub.Prompt.AndroidWithoutDeeplink")
local var4 = RobloxTranslator:FormatByKey("Feature.SettingsHub.Prompt.WindowsWithoutDeeplink")

return function(bool1: boolean, tbl1)
    local platform = tbl1:GetPlatform()

    if platform == Enum.Platform.Android then
        if bool1 then
            return var1
        end

        return var3
    end

    if platform == Enum.Platform.Windows then
        if bool1 then
            return var2
        end

        return var4
    end

    return nil
end
