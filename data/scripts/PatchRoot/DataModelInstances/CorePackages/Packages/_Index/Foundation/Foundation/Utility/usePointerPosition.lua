-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:20:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local Wrappers = require(Foundation.Utility.Wrappers)
local Signal = Wrappers.Signal
local Connection = Wrappers.Connection

local function usePointerPosition(arg1)
    local var1, var2 = React.useBinding(Vector2.zero)

    React.useEffect(function()
        if not arg1 then
            return
        end

        local function setPositionFromInput(arg2)
            if arg2.Position.X > 0 or arg2.Position.Y > 0 then
                var2(Vector2.new(arg2.Position.X, arg2.Position.Y))
            end
        end

        local tbl1 = { Signal.Connect(arg1.InputBegan, setPositionFromInput), Signal.Connect(arg1.InputChanged, setPositionFromInput), Signal.Connect(arg1.InputEnded, setPositionFromInput) }

        return function()
            for _, value in tbl1 do
                Connection.Disconnect(value)
            end
        end
    end, { arg1 })

    return var1
end

return usePointerPosition
