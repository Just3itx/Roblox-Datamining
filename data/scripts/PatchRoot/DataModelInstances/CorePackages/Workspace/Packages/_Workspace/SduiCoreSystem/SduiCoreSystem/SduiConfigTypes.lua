-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T10:01:14Z
-- Luau bytecode version: 14 | Luau type version: 3
local SduiCoreSystem = script:FindFirstAncestor("SduiCoreSystem")
local SduiCoreSystemParent = SduiCoreSystem.Parent
local t = require(SduiCoreSystemParent.t)
local Cryo = require(SduiCoreSystemParent.Cryo)
local _SduiErrors = require(SduiCoreSystem.SduiErrors)

local _SduiComponentType = require(SduiCoreSystem.SduiComponentType)

local ConditionalPropsInterface = require(SduiCoreSystem.ConditionalProps.SduiConditionalPropTypes).ConditionalPropsInterface

local ActionInterface = {
    actionType = t.string,
    actionParams = t.optional(t.table),
    telemetryHandler = t.optional(t.string),
    skipUnifiedLogging = t.optional(t.boolean)
}

local UiComponentInterface = {
    componentType = t.string,
    props = t.optional(t.table),
    templateKey = t.optional(t.string),
    analyticsData = t.optional(t.table),
    children = t.optional(t.table),
    conditionalProps = t.optional(t.array(t.interface(ConditionalPropsInterface))),
    feedItemKey = t.optional(t.string),
    __processed = t.optional(t.boolean),
    __isClientBinding = t.optional(t.boolean),
    __usageRecorded = t.optional(t.boolean)
}

return {
    ActionInterface = ActionInterface,
    UiComponentInterface = UiComponentInterface,
    SduiTemplateInterface = Cryo.Dictionary.join(UiComponentInterface, { componentType = t.optional(t.string) })
}
