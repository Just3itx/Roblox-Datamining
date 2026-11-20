-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:41:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Localization = require(CorePackages.Workspace.Packages.RobloxAppLocales).Localization

local var1 = nil
local success, result = pcall(function(): string
    return game:GetService("LocalizationService").RobloxLocaleId
end)

local bool1 = success
local var2 = result

local module = {}

function module.LocStringUA(_, arg1)
    if bool1 and not var1 then
        var1 = Localization.new(var2)
    else
        var1 = Localization.new("en-us")
    end

    return var1.localizationContext:getString(var2, arg1) or arg1
end

return module
