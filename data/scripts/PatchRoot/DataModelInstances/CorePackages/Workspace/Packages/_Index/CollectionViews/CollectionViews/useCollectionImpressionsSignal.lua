-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:11:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CollectionViewsParent = script:FindFirstAncestor("CollectionViews").Parent
local React = require(CollectionViewsParent.React)
local Signal = require(CollectionViewsParent.AppCommonLib).Signal

local function useCollectionImpressionsSignal<T>(arg1: T)
    local var1 = React.useRef(nil)
    if var1.current == nil then
        var1.current = Signal.new()
    end
    local current = var1.current

    React.useEffect(function()
        current:fire()

        local connection = if arg1 then arg1:connect(function()
            current:fire()
        end) else nil

        return function()
            if connection then
                connection:disconnect()
            end
        end
    end, { arg1, current })

    return current, (React.useCallback(function()
        current:fire()
    end, { current }))
end

return useCollectionImpressionsSignal
