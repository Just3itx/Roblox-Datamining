-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:41:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent
local React = require(AppChatParent.React)
local Cryo = require(AppChatParent.Cryo)

local function createStateContext(arg1)
    local context = React.createContext({
        get = function()
            return Cryo.Dictionary.union({}, arg1)
        end,
        set = function() end
    })

    return {
        Provider = context.Provider,
        useClearState = function()
            local set = React.useContext(context).set
            return React.useCallback(function()
                set(arg1)
            end, { set })
        end,
        useGetState = function()
            return React.useContext(context).get
        end,
        useMergeState = function()
            local set = React.useContext(context).set
            return React.useCallback(function(arg2)
                set(function(arg3)
                    return Cryo.Dictionary.join(arg3, arg2)
                end)
            end, { set })
        end,
        useSetState = function()
            return React.useContext(context).set
        end
    }
end

return createStateContext
