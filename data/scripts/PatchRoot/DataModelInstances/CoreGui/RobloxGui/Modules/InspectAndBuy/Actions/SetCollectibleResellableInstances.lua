-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:00:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local _CollectibleInstance = require(script.Parent.Parent.Models.CollectibleInstance)
return require(CorePackages.Packages.Rodux).makeActionCreator(script.Name, function(collectibleItemId: string?, collectibleItemInstances)
    return {
        collectibleItemId = collectibleItemId,
        collectibleItemInstances = collectibleItemInstances
    }
end)
