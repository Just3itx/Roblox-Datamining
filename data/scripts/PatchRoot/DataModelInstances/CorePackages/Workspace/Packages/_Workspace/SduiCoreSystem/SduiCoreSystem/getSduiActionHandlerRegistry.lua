-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T10:00:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiCoreSystem = script:FindFirstAncestor("SduiCoreSystem")

local _SduiActionType = require(SduiCoreSystem.SduiActionType)
local _SduiBuilderTypes = require(SduiCoreSystem.SduiBuilderTypes)

local function createSduiActionHandlerRegistry()
    local debugGetRegisteredActionHandlerConfigs = ({})

    local function registerActionHandlerConfig(arg1, arg2) -- Luacid: Inlined by compiler; 1 call site recovered
        debugGetRegisteredActionHandlerConfigs[arg1] = arg2
    end

    return {
        getActionHandlerConfig = function(arg1)
            local var1 = debugGetRegisteredActionHandlerConfigs[arg1]

            if var1 and not var1.handler and var1.lazyHandler then
                var1.handler = var1.lazyHandler()
            end
            if var1 and not var1.telemetryHandler then
                local lazyTelemetryHandler = var1.lazyTelemetryHandler
                if lazyTelemetryHandler then
                    var1.telemetryHandler = lazyTelemetryHandler()
                end
            end
            return var1
        end,
        registerActionHandlerConfig = registerActionHandlerConfig,
        registerActionHandlerConfigs = function(tbl2)
            for value, value2 in tbl2 do
                registerActionHandlerConfig(value, value2)
            end
        end,
        getRegisteredActionTypes = function()
            local registeredActionTypes = {}
            for value in debugGetRegisteredActionHandlerConfigs do
                table.insert(registeredActionTypes, value)
            end
            table.sort(registeredActionTypes)
            return registeredActionTypes
        end,
        debug_clear = function()
            table.clear(debugGetRegisteredActionHandlerConfigs)
        end,
        debug_getRegisteredActionHandlerConfigs = function()
            return debugGetRegisteredActionHandlerConfigs
        end
    }
end
local var1 = nil
local function getSduiActionHandlerRegistry()
    if var1 == nil then
        var1 = createSduiActionHandlerRegistry()
    end
    return var1
end

return getSduiActionHandlerRegistry
