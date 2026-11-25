-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T09:51:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiCoreSystem = script:FindFirstAncestor("SduiCoreSystem")
local SduiCoreSystemParent = SduiCoreSystem.Parent
local SduiCapabilityFlags = require(SduiCoreSystem.ClientBinding.SduiCapabilityFlags)

local resolveRuntimeFlagValues = require(SduiCoreSystem.ClientBinding.resolveRuntimeFlagValues)
local FFlagSduiDefineUnreadRuntimeFlags = require(SduiCoreSystemParent.SharedFlags).FFlagSduiDefineUnreadRuntimeFlags

local module = {}

function module.isEnabled(str1: string): boolean
    return SduiCapabilityFlags[str1] == true
end

function module.getEnabledCapabilities()
    local enabledCapabilities = {}
    for k, sduiCapabilityFlag in SduiCapabilityFlags do
        if sduiCapabilityFlag then
            table.insert(enabledCapabilities, k)
        end
    end
    return enabledCapabilities
end

local function resolveNamesToNumbers(tbl1)
    if #tbl1 == 0 then
        return {}
    end

    local capability = require(SduiCoreSystemParent.ServiceContractsProto).apppageplatform.shared.capability.Capability

    local result = {}
    for _, value in tbl1 do
        local name = capability.fromName(value)
        if name == nil then
            warn(`SduiCapabilities: unknown capability name {value}`)
        else
            table.insert(result, capability.toNumber(name))
        end
    end
    return result
end

function module.createQueryValue(tbl1)
    local tbl2 = resolveNamesToNumbers(tbl1)
    if #tbl2 == 0 then
        return nil
    end

    table.sort(tbl2)
    local var1 = table.create(#tbl2)
    for _, value in tbl2 do
        table.insert(var1, tostring(value))
    end
    return table.concat(var1, ",")
end

function module.addToQueryParams(tbl1, tbl2)
    local tbl3 = {}
    for _, value in tbl2 do
        if module.isEnabled(value) then
            table.insert(tbl3, value)
        end
    end
    local enabledCapabilities = module.createQueryValue(tbl3)
    if enabledCapabilities ~= nil then
        tbl1.enabledCapabilities = enabledCapabilities
    end
end

function module.getEnabledCapabilityNumbers(tbl1)
    local tbl2 = {}
    for _, value in tbl1 do
        if module.isEnabled(value) then
            table.insert(tbl2, value)
        end
    end
    local tbl3 = resolveNamesToNumbers(tbl2)
    table.sort(tbl3)
    return tbl3
end

function module.getEnabledCapabilityNumbersWithoutExtendedMarker()
    local tbl1 = {}
    for _, value in module.getEnabledCapabilities() do
        if value ~= "CAPABILITY_SUPPORTS_EXTENDED_CLIENT_CAPABILITIES" then
            table.insert(tbl1, value)
        end
    end
    return module.getEnabledCapabilityNumbers(tbl1)
end

function module.addAllToQueryParams(tbl1)
    local enabledCapabilities = module.createQueryValue(module.getEnabledCapabilities())
    if enabledCapabilities ~= nil then
        tbl1.enabledCapabilities = enabledCapabilities
    end
end

local function resolveRuntimeSupportNumbers(tbl1, arg1, str1: string)
    local protoVariableMapper = require(SduiCoreSystem.ClientBinding.ProtoVariableMapper)
    local result = {}
    for _, value in tbl1 do
        local var1 = protoVariableMapper.mapLuaEnumFormatToProto(value, str1, arg1)
        if var1 == nil then
            continue
        end

        local var2 = arg1.toNumber(var1)
        if var2 ~= 0 then
            table.insert(result, var2)
        end
    end

    table.sort(result)
    return result
end

local bool1 = false

local function readRuntimeFlag(str1: string)
    local success, result = pcall(game.GetFastFlag, game, str1)
    if success and type(result) == "boolean" then
        return true, result
    end
    return pcall(game.DefineFastFlag, game, str1, false)
end

local function getRuntimeFlagValues()
    local var1, var2, var3 = resolveRuntimeFlagValues(not FFlagSduiDefineUnreadRuntimeFlags and function(str1: string)
        return pcall(game.GetFastFlag, game, str1)
    end or readRuntimeFlag)

    if not bool1 and var2 + var3 > 0 then
        bool1 = true
        warn(`SduiCapabilities: ignored {var2} invalid runtime flag names and {var3} unreadable flags`)
    end

    return var1
end

local function getRuntimeSupportFields()
    local shared = require(SduiCoreSystemParent.ServiceContractsProto).apppageplatform.shared
    return {
        registered_ui_component_types = resolveRuntimeSupportNumbers(
            require(SduiCoreSystem.getSduiComponentRegistry)().getRegisteredComponentTypes(),
            shared.ui_component_type.UiComponentType,
            "UI_COMPONENT_TYPE_"
        ),
        registered_action_types = resolveRuntimeSupportNumbers(
            require(SduiCoreSystem.getSduiActionHandlerRegistry)().getRegisteredActionTypes(),
            shared.actions.ActionType,
            "ACTION_TYPE_"
        ),
        runtime_flag_values = getRuntimeFlagValues()
    }
end

function module.buildClientCapabilities()
    local serviceContractsProto = require(SduiCoreSystemParent.ServiceContractsProto)
    local clientCapabilities = serviceContractsProto.apppageplatform.shared.client_capabilities.ClientCapabilities
    local platform = serviceContractsProto.apppageplatform.shared.client_capabilities.Platform
    local tbl1 = {
        enabled_capabilities = module.getEnabledCapabilityNumbers(module.getEnabledCapabilities()),
        platform = platform.toNumber("PLATFORM_APP")
    }
    for value, value2 in getRuntimeSupportFields() do
        tbl1[value] = value2
    end
    return clientCapabilities.new(tbl1)
end

return module
