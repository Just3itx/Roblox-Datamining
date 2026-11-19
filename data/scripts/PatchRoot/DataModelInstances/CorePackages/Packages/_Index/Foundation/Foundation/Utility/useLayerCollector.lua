-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T10:30:45Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local Wrappers = require(Foundation.Utility.Wrappers)
local Signal = Wrappers.Signal
local Connection = Wrappers.Connection

local function findLayerCollector(arg1)
    if not arg1 then
        return nil
    end

    return arg1:FindFirstAncestorWhichIsA("LayerCollector")
end

local function useLayerCollector(arg1)
    local var1, var2 = React.useState(nil)

    local var3 = React.useCallback(function()
        var2(findLayerCollector(arg1))
    end, { arg1 })

    React.useEffect(function()
        if not arg1 then
            return nil
        end

        var3()

        local var4 = Signal.Connect(arg1.AncestryChanged, var3)

        return function()
            Connection.Disconnect(var4)
        end
    end, { arg1 })

    return var1
end

return useLayerCollector
