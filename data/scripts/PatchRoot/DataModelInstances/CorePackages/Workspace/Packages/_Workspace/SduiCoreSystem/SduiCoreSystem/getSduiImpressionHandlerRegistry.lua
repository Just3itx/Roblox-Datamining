-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T10:01:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiCoreSystem = script:FindFirstAncestor("SduiCoreSystem")

local _SduiImpressionEventType = require(SduiCoreSystem.SduiImpressionEventType)
local _SduiBuilderTypes = require(SduiCoreSystem.SduiBuilderTypes)

local function createSduiImpressionHandlerRegistry()
    local debugGetRegisteredImpressionHandlerConfigs = ({})

    local function registerImpressionHandlerConfig(arg1, arg2) -- Luacid: Inlined by compiler; 1 call site recovered
        debugGetRegisteredImpressionHandlerConfigs[arg1] = arg2
    end

    return {
        getImpressionHandlerConfig = function(arg1)
            local var1 = debugGetRegisteredImpressionHandlerConfigs[arg1]

            if var1 and not var1.handler and var1.lazyHandler then
                var1.handler = var1.lazyHandler()
            end
            return var1
        end,
        registerImpressionHandlerConfig = registerImpressionHandlerConfig,
        registerImpressionHandlerConfigs = function(tbl2)
            for value, value2 in tbl2 do
                registerImpressionHandlerConfig(value, value2)
            end
        end,
        debug_clear = function()
            table.clear(debugGetRegisteredImpressionHandlerConfigs)
        end,
        debug_getRegisteredImpressionHandlerConfigs = function()
            return debugGetRegisteredImpressionHandlerConfigs
        end
    }
end
local var1 = nil
local function getSduiImpressionHandlerRegistry()
    if var1 == nil then
        var1 = createSduiImpressionHandlerRegistry()
    end
    return var1
end

return getSduiImpressionHandlerRegistry
