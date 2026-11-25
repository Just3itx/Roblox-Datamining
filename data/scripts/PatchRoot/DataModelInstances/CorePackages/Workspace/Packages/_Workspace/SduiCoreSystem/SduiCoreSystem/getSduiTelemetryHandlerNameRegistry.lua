-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T10:01:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiCoreSystem = script:FindFirstAncestor("SduiCoreSystem")

local _SduiBuilderTypes = require(SduiCoreSystem.SduiBuilderTypes)

local function createSduiTelemetryHandlerNameRegistry()
    local debugGetRegisteredConfigs = ({})

    local function registerTelemetryHandler(str1: string, tbl2) -- Luacid: Inlined by compiler; 1 call site recovered
        debugGetRegisteredConfigs[str1] = tbl2
    end

    return {
        getTelemetryHandler = function(str1: string)
            local var1 = debugGetRegisteredConfigs[str1]
            if var1 == nil then
                return nil
            end

            if not var1.handler and var1.lazyHandler then
                var1.handler = var1.lazyHandler()
            end
            return var1.handler
        end,
        registerTelemetryHandler = registerTelemetryHandler,
        registerTelemetryHandlers = function(tbl2)
            for value, value2 in tbl2 do
                registerTelemetryHandler(value, value2)
            end
        end,
        debug_clear = function()
            table.clear(debugGetRegisteredConfigs)
        end,
        debug_getRegisteredConfigs = function()
            return debugGetRegisteredConfigs
        end
    }
end
local var1 = nil
local function getSduiTelemetryHandlerNameRegistry()
    if var1 == nil then
        var1 = createSduiTelemetryHandlerNameRegistry()
    end
    return var1
end

return getSduiTelemetryHandlerNameRegistry
