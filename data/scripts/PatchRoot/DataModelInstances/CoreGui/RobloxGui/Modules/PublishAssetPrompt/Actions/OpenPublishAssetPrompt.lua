-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:10:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
return require(CorePackages.Packages.Rodux).makeActionCreator(script.Name, function(promptType: string, assetInstance, assetType, guid: string, scopes)
    return {
        promptInfo = {
            promptType = promptType,
            assetInstance = assetInstance,
            assetType = assetType,
            guid = guid,
            scopes = scopes
        }
    }
end)
