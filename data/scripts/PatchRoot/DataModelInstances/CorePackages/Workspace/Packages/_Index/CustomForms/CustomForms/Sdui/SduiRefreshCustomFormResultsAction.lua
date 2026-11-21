-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T09:41:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CustomForms = script:FindFirstAncestor("CustomForms")
local CustomFormsParent = CustomForms.Parent

local Promise = require(CustomFormsParent.Promise)
local _SduiCoreSystem = require(CustomFormsParent.SduiCoreSystem)

local customFormEntry = require(CustomForms.Sdui.customFormEntry)
local getSduiCustomFormVerticalRegistry = require(CustomForms.Sdui.getSduiCustomFormVerticalRegistry)

local function isId(arg1): boolean -- Luacid: Inlined by compiler; 4 call sites recovered
    return type(arg1) == "string" and arg1 ~= ""
end

local function SduiRefreshCustomFormResultsAction(arg1, _, arg2)
    local actionParams = if arg1 then arg1.actionParams else nil
    local entityId = if actionParams then actionParams.entityId else nil
    local formId = if actionParams then actionParams.formId else nil
    local cfVertical = if actionParams then actionParams.cfVertical else nil
    local configKey = arg2.configKey

    if not (isId(entityId) and isId(formId) and isId(cfVertical) and isId(configKey)) then
        return Promise.resolve(nil)
    end
    assert(configKey, "checked above")

    local var1 = getSduiCustomFormVerticalRegistry().getVertical(cfVertical)
    local fetchResults = if var1 then var1.fetchResults else nil

    if not fetchResults then
        return Promise.resolve(nil)
    end

    local current = customFormEntry.findForm(configKey, formId)

    if current == nil then
        return Promise.resolve(nil)
    end

    return Promise.try(fetchResults, { entityId = entityId, formId = formId, cfVertical = cfVertical, current = current }):andThen(
        function(tbl1)
            if tbl1 == nil then
                return nil
            elseif not customFormEntry.updateForm(configKey, formId, function()
                return tbl1
            end) then
                return Promise.reject(`Fresh data for form {formId} doesn't match its entry under {configKey}`)
            end
            return nil
        end
    )
end
return SduiRefreshCustomFormResultsAction
