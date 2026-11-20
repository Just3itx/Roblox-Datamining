-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:40:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UGCValidationService = game:GetService("UGCValidationService")

local scriptParentParent = script.Parent.Parent

local Analytics = require(scriptParentParent.Analytics)

local _Types = require(scriptParentParent.util.Types)

local function validateCanLoad(assetId: string, arg1)
    local success, result = pcall(function(): boolean
        return UGCValidationService:CanLoadAsset(assetId)
    end)

    if success and result then
        return true
    end

    Analytics.reportFailure(Analytics.ErrorType.validateCanLoad, nil, arg1)
    return false, { "Asset could not be loaded" }
end

return validateCanLoad
