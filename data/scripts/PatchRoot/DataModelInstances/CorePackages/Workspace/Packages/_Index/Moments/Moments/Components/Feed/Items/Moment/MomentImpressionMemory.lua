-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:10:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local React = require(MomentsParent.React)
local Signals = require(MomentsParent.Signals)
local SignalsReact = require(MomentsParent.SignalsReact)

local VerticalPager = require(Moments.Components.VerticalPager)

local useSignalState = SignalsReact.useSignalState
local useVerticalPager = VerticalPager.useVerticalPager
local usePagerItem = VerticalPager.usePagerItem

local context = React.createContext(nil)

return table.freeze({
    Provider = function(tbl1)
        local var1 = useVerticalPager()
        local item = usePagerItem().item

        local var2 = React.useRef({})
        local value = React.useCallback(function(str1: string)
            local tbl2 = var2.current[str1]
            if tbl2 == nil then
                tbl2 = { current = false }
                var2.current[str1] = tbl2
            end
            return tbl2
        end, {})

        local var4 = React.useMemo(function()
            return Signals.createComputed(function(arg1): boolean
                return not (item == nil) and var1.store.getCurrentItem(arg1) == item
            end)
        end, { var1, item })
        local var5 = useSignalState(var4)

        React.useEffect(function()
            if var5 then
                return
            end
            for _, value in var2.current do
                value.current = false
            end
        end, { var5 })

        return React.createElement(context.Provider, { value = value }, tbl1.children)
    end,
    useImpressionRef = function(str1: string)
        local var1 = React.useContext(context)
        local var2 = React.useRef(false)
        if var1 ~= nil then
            return (var1(str1))
        end

        return var2
    end
})
