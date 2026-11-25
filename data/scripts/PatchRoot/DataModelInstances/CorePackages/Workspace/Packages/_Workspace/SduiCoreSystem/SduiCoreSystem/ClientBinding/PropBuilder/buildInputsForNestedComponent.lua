-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T09:41:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiCoreSystem = script:FindFirstAncestor("SduiCoreSystem")
local SduiCoreSystemParent = SduiCoreSystem.Parent
local FFlagSduiErrorPaths = require(SduiCoreSystemParent.SharedFlags).FFlagSduiErrorPaths

local _SduiClientBindingTypes = require(SduiCoreSystem.ClientBinding.SduiClientBindingTypes)
local SduiPropUtils = require(SduiCoreSystem.ClientBinding.PropBuilder.SduiPropUtils)
local splitDottedPath = require(SduiCoreSystem.ClientBinding.splitDottedPath)

local _Signals = require(SduiCoreSystemParent.Signals)

local function buildInputsForNestedComponent(arg1, tbl1, arg2, arg3, tbl2, arg4)
    if not tbl1 then
        return
    end

    for value, value2 in tbl1 do
        if not value2.kind then
            continue
        end

        local type = value2.kind.type
        if type == "binding_path" then
            local value3 = value2.kind.value
            local var1 = splitDottedPath(value3)
            local var2, _ = SduiPropUtils.resolveBindingPathValue(arg3 or false, var1, arg2, arg1, nil, false, arg4)

            tbl2[value] = var2
        elseif type == "literal" then
            local value3 = value2.kind.value and value2.kind.value.kind and value2.kind.value.kind.value
            if value3 == nil then
                error(`Failed to determine value for nested input arg {value}`)
            end
            tbl2[value] = value3
        elseif type == "translation" then
            if arg4 and arg4.resolveLocalizedLiteral then
                local resolveLocalizedLiteral = arg4.resolveLocalizedLiteral
                local value3 = value2.kind.value
                local errorContext = if FFlagSduiErrorPaths then arg4.errorContext else nil
                tbl2[value] = resolveLocalizedLiteral(value3, errorContext)
            end
        elseif type == "format" then
            local value3 = value2.kind.value
            tbl2[value] = SduiPropUtils.generateFormatStringPropValue(value3, arg2, arg4, arg1)(arg3 or false).data
        else
            error(`Unrecognized inputDataType for key {value}`)
        end
    end
end

return buildInputsForNestedComponent
