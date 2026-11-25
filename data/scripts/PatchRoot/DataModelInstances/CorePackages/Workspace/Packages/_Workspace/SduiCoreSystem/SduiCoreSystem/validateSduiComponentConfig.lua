-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T10:01:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiCoreSystem = script:FindFirstAncestor("SduiCoreSystem")

local SduiComponentType = require(SduiCoreSystem.SduiComponentType)
local SduiConfigTypes = require(SduiCoreSystem.SduiConfigTypes)
local SduiErrorType = require(SduiCoreSystem.SduiErrors).SduiErrorType
local UiComponentInterface = SduiConfigTypes.UiComponentInterface
local validateInterface = require(SduiCoreSystem.validateInterface)

local function validateSduiComponentConfig(arg1, bool1: boolean?)
    if arg1 == nil then
        return false, {
            errorType = SduiErrorType.NilComponentConfig
        }
    end

    assert(arg1, "componentConfig must exist")
    local var1, message = validateInterface(arg1, UiComponentInterface, bool1)
    if not var1 then
        return false, {
            errorType = SduiErrorType.InvalidComponentConfig,
            message = message
        }
    end
    local componentType = arg1.componentType
    if SduiComponentType[componentType] ~= nil then
        return true
    end
    return false, {
        errorType = SduiErrorType.ComponentTypeNotRecognized
    }
end

return validateSduiComponentConfig
