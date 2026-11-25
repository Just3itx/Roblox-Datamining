-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T09:51:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function createStructValue(value)
    local str1 = typeof(value)
    if value == nil then
        return {
            kind = { type = "null_value", value = 0 }
        }
    elseif str1 == "string" then
        return {
            kind = { type = "string_value", value = value }
        }
    elseif str1 == "number" then
        return {
            kind = { type = "number_value", value = value }
        }
    elseif str1 == "boolean" then
        return {
            kind = { type = "bool_value", value = value }
        }
    else
        if str1 ~= "table" then
            error(`createStructValue cannot represent a {str1}`)
        end

        if next(value) == nil or value[1] ~= nil then
            local values = ({})
            for value, value2 in value do
                values[value] = createStructValue(value2)
            end
            return {
                kind = {
                    type = "list_value",
                    value = { values = values }
                }
            }
        end

        local fields = ({})
        for value, value2 in value do
            fields[value] = createStructValue(value2)
        end
        return {
            kind = {
                type = "struct_value",
                value = { fields = fields }
            }
        }
    end
end

return {
    createLiteralKind = function(value)
        return { type = "literal", value = value }
    end,
    createBindingPathKind = function(value: string)
        return { type = "binding_path", value = value }
    end,
    createStructValue = createStructValue,
    createMockStruct = function(tbl1)
        local fields = ({})
        for value, value2 in tbl1 do
            fields[value] = createStructValue(value2)
        end
        return { fields = fields }
    end,
    createLiteralProp = function(value, str1: string)
        return {
            kind = { type = "literal", value = value },
            descriptor = { name = str1, fullName = str1 }
        }
    end,
    createBindingPathProp = function(value: string, str2: string)
        return {
            kind = { type = "binding_path", value = value },
            descriptor = { name = str2, fullName = str2 }
        }
    end,
    createTokenProp = function(value, str1: string)
        return {
            kind = { type = "token", value = value },
            descriptor = { name = str1, fullName = str1 }
        }
    end,
    createMockInlineComponent = function(componentType: string, props)
        return {
            kind = {
                value = {
                    props = props,
                    shared = { component_type = componentType }
                }
            }
        }
    end,
    createMockInputForNestedComponent = function(str1: string, value): {kind: {type: string, value: any}} | {kind: {type: string, value: {kind: {value: any}}}}
        return if str1 == "literal" then {
            kind = {
                type = "literal",
                value = {
                    kind = { value = value }
                }
            }
        } elseif str1 == "translation" then {
            kind = { type = "translation", value = value }
        } else {
            kind = { type = "binding_path", value = value }
        }
    end,
    createMockConditionalPropValue = function(options, arg1)
        return {
            kind = {
                type = "conditional",
                value = { options = options }
            },
            descriptor = { fullName = arg1, name = arg1 }
        }
    end,
    createMockConditionalOptions = function(options)
        return { options = options }
    end,
    createMockComparisonConditionOption = function(op: string, field: string, value, kind)
        return {
            condition = {
                kind = {
                    type = "comparison",
                    value = {
                        op = op,
                        field = field,
                        kind = { value = value }
                    }
                }
            },
            kind = kind
        }
    end,
    createMockIsNullConditionOption = function(field: string, kind)
        return {
            condition = {
                kind = {
                    type = "is_null",
                    value = { field = field }
                }
            },
            kind = kind
        }
    end,
    createMockIsNotNullConditionOption = function(field: string, kind)
        return {
            condition = {
                kind = {
                    type = "is_not_null",
                    value = { field = field }
                }
            },
            kind = kind
        }
    end,
    createMockIsEmptyConditionOption = function(field: string, kind)
        return {
            condition = {
                kind = {
                    type = "is_empty",
                    value = { field = field }
                }
            },
            kind = kind
        }
    end,
    createMockIsNotEmptyConditionOption = function(field: string, kind)
        return {
            condition = {
                kind = {
                    type = "is_not_empty",
                    value = { field = field }
                }
            },
            kind = kind
        }
    end,
    createMockContainsConditionOption = function(field: string, type: string, value: string, kind)
        return {
            condition = {
                kind = {
                    type = "contains",
                    value = {
                        field = field,
                        kind = { type = type, value = value }
                    }
                }
            },
            kind = kind
        }
    end,
    createMockAndConditionOption = function(conditions, kind)
        return {
            condition = {
                kind = {
                    type = "and_condition",
                    value = { conditions = conditions }
                }
            },
            kind = kind
        }
    end,
    createMockOrConditionOption = function(conditions, kind)
        return {
            condition = {
                kind = {
                    type = "or_condition",
                    value = { conditions = conditions }
                }
            },
            kind = kind
        }
    end,
    createMockNestedComponentConditionalOption = function(condition, robloxComponent, inputs)
        return {
            condition = condition,
            kind = {
                type = "literal",
                value = { roblox_component = robloxComponent, inputs = inputs }
            }
        }
    end
}
