-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:01:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local React = require(scriptParentParent.React)
local _Message = require(script.Parent.Message)

local Context = React.createContext(nil)

return {
    Context = Context,
    Provider = function(tbl1)
        local value = React.useMemo(function()
            return {
                write = tbl1.upsertMessage,
                remove = tbl1.removeMessage
            }
        end, { tbl1.upsertMessage, tbl1.removeMessage })

        return React.createElement(Context.Provider, { value = value }, tbl1.children)
    end,
    useMessageWriter = function()
        return React.useContext(Context)
    end
}
