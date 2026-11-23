-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:30:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent
local React = require(AppChatParent.React)
local Cryo = require(AppChatParent.Cryo)

local function createReactTelemetryLayer(arg1, arg2)
    local context = React.createContext(function()
        return Cryo.Dictionary.union({}, arg2)
    end)

    return {
        Context = context,
        Provider = function(tbl1)
            local var1 = React.useContext(arg1)
            local value = React.useCallback(function()
                local value = tbl1.value
                if typeof(value) == "function" then
                    value = value()
                end
                return Cryo.Dictionary.union(var1(), value)
            end, { var1, tbl1.value })

            return React.createElement(context.Provider, { value = value }, tbl1.children)
        end
    }
end
return createReactTelemetryLayer
