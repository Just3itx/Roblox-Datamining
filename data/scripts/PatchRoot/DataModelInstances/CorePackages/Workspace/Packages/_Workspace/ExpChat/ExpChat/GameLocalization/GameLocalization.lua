-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:50:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChatParent = script:FindFirstAncestor("ExpChat").Parent
local React = require(ExpChatParent.React)
local Dictionary = require(ExpChatParent.llama).Dictionary

local function getConnect(context) -- Luacid: Inlined by compiler; 1 call site recovered
    return function(arg1)
        local function transformedMapper(arg2, props)
            return Dictionary.map(arg1(props), function(str1: string, _)
                local success, result = pcall(function()
                    return arg2:TranslateGameText(game, str1)
                end)

                return if success then result else ""
            end)
        end

        return function(arg2)
            local var1 = React.Component:extend("Connected-" .. tostring(arg2))

            function var1.render(arg3)
                return React.createElement(context.Consumer, {
                    render = function(arg4)
                        return React.createElement(arg2, Dictionary.join(arg3.props, transformedMapper(arg4, arg3.props)))
                    end
                })
            end

            return var1
        end
    end
end

return function(arg1)
    local context = React.createContext(arg1)

    return {
        Consumer = context.Consumer,
        Provider = context.Provider,
        connect = getConnect(context)
    }
end
