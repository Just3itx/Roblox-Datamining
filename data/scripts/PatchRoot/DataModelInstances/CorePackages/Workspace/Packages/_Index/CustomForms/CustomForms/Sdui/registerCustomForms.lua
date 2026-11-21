-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T09:41:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CustomForms = script:FindFirstAncestor("CustomForms")
local CustomFormsParent = CustomForms.Parent

local SduiCoreSystem = require(CustomFormsParent.SduiCoreSystem)
local SduiActionType = SduiCoreSystem.SduiActionType
local SduiComponentType = SduiCoreSystem.SduiComponentType
local getSduiActionHandlerRegistry = SduiCoreSystem.getSduiActionHandlerRegistry
local getSduiComponentRegistry = SduiCoreSystem.getSduiComponentRegistry
local SharedFlags = require(CustomFormsParent.SharedFlags)

local FFlagSduiApiStoreUpdateInputData = SharedFlags.FFlagSduiCustomFormEnabled
    and SharedFlags.FFlagSduiUnwrapStructPropEnvelope
    and SharedFlags.FFlagSduiApiStoreUpdateInputData

local function registerCustomFormActions()
    local tbl1 = {
        [SduiActionType.SubmitCustomFormResponse] = FFlagSduiApiStoreUpdateInputData and {
            lazyHandler = function()
                return require(CustomForms.Sdui.SduiSubmitCustomFormResponseAction)
            end,
            skipUnifiedLogging = false
        } or nil,
        [SduiActionType.RefreshCustomFormResults] = FFlagSduiApiStoreUpdateInputData and {
            lazyHandler = function()
                return require(CustomForms.Sdui.SduiRefreshCustomFormResultsAction)
            end,
            skipUnifiedLogging = true
        } or nil
    }

    getSduiActionHandlerRegistry().registerActionHandlerConfigs(tbl1)
end

local function registerCustomFormComponents()
    local tbl1 = {
        [SduiComponentType.CustomForm] = FFlagSduiApiStoreUpdateInputData and {
            getLazyComponent = function()
                return require(CustomForms.Sdui.SduiCustomForm)
            end
        } or nil
    }

    getSduiComponentRegistry().registerComponentDefinitions(tbl1)
end

return {
    registerCustomForms = function()
        registerCustomFormActions()
        registerCustomFormComponents()
    end,
    registerCustomFormActions = registerCustomFormActions,
    registerCustomFormComponents = registerCustomFormComponents
}
