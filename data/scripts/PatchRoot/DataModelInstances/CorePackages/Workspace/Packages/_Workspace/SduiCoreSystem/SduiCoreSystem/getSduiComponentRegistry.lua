-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T10:00:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiCoreSystem = script:FindFirstAncestor("SduiCoreSystem")
local SduiCoreSystemParent = SduiCoreSystem.Parent
local _React = require(SduiCoreSystemParent.React)

local _SduiComponentType = require(SduiCoreSystem.SduiComponentType)
local _SduiBuilderTypes = require(SduiCoreSystem.SduiBuilderTypes)

local function createSduiComponentRegistry()
    local tbl1 = ({})

    local function getComponentDefinition(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
        local var1 = tbl1[arg1]

        if not var1 then
            return nil
        end
        if not var1.component and var1.getLazyComponent then
            var1.component = var1.getLazyComponent()
        end
        return var1
    end

    local function registerComponentDefinition(arg1, arg2) -- Luacid: Inlined by compiler; 1 call site recovered
        tbl1[arg1] = arg2
    end

    return {
        getComponent = function(arg1)
            local componentDefinition = getComponentDefinition(arg1)
            return if componentDefinition then componentDefinition.component else nil
        end,
        getComponentDefinition = getComponentDefinition,
        registerComponentDefinition = registerComponentDefinition,
        registerComponentDefinitions = function(tbl2)
            for value, value2 in tbl2 do
                registerComponentDefinition(value, value2)
            end
        end,
        getRegisteredComponentTypes = function()
            local registeredComponentTypes = {}
            for value in tbl1 do
                table.insert(registeredComponentTypes, value)
            end
            table.sort(registeredComponentTypes)
            return registeredComponentTypes
        end
    }
end
local var1 = nil
local function getSduiComponentRegistry()
    if var1 == nil then
        var1 = createSduiComponentRegistry()
    end
    return var1
end

return getSduiComponentRegistry
