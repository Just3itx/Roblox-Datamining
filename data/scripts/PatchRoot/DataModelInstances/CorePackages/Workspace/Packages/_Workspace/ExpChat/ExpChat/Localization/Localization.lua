-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:01:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChatParent = script:FindFirstAncestor("ExpChat").Parent
local Roact = require(ExpChatParent.Roact)
local React = require(ExpChatParent.React)
local Dictionary = require(ExpChatParent.llama).Dictionary

local function mapStringToBeLocalized(arg1, arg2)
    if type(arg2) == "table" then
        local success, result = pcall(function()
            return arg1:FormatByKey(arg2[1], arg2[2])
        end)

        return if success then result else ""
    end
    if type(arg2) ~= "string" then
        return ""
    end

    local success, result = pcall(function()
        return arg1:FormatByKey(arg2)
    end)

    return if success then result else ""
end

local function getConnect(context) -- Luacid: Inlined by compiler; 1 call site recovered
    return function(arg1)
        local function transformedMapper(arg2, props)
            return Dictionary.map(arg1(props), function(arg3, _)
                return (mapStringToBeLocalized(arg2, arg3))
            end)
        end

        return function(arg2)
            local var1 = Roact.Component:extend("Connected-" .. tostring(arg2))

            function var1.render(arg3)
                return Roact.createElement(context.Consumer, {
                    render = function(arg4)
                        return Roact.createElement(arg2, Dictionary.join(arg3.props, transformedMapper(arg4, arg3.props)))
                    end
                })
            end

            return var1
        end
    end
end

local function getUseLocalization(context) -- Luacid: Inlined by compiler; 1 call site recovered
    return function(tbl1)
        local var1 = React.useContext(context)
        return Dictionary.map(tbl1, function(arg1, _)
            return (mapStringToBeLocalized(var1, arg1))
        end)
    end
end

return function(arg1)
    local context = Roact.createContext(arg1)

    return {
        Consumer = context.Consumer,
        Provider = context.Provider,
        connect = getConnect(context),
        useLocalization = getUseLocalization(context)
    }
end
