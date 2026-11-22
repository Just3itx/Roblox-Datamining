-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:50:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local React = require(MomentsParent.React)
local Signals = require(MomentsParent.Signals)
local SignalsReact = require(MomentsParent.SignalsReact)

local _Types = require(script.Parent.Types)
local createPagerStore = require(script.Parent.createPagerStore)

local function noop() end

local getActiveIndex = Signals.createSignal(1)
local getScrollState = Signals.createSignal("Idle")
local signal3 = Signals.createSignal(false)

local store = createPagerStore()

local VerticalPagerContext = React.createContext({
    store = store,
    getActiveIndex = getActiveIndex,
    getScrollState = getScrollState,
    scrollToIndex = noop,
    next = noop,
    previous = noop,
    removeItem = noop,
    analytics = nil
})

local PagerItemContext = React.createContext({ index = 0, item = nil, getIsActive = signal3, getIsVisible = signal3 })

local function usePagerItem() -- Luacid: Inlined by compiler; 1 call site recovered
    return (React.useContext(PagerItemContext))
end

return {
    VerticalPagerContext = VerticalPagerContext,
    PagerItemContext = PagerItemContext,
    useVerticalPager = function()
        return (React.useContext(VerticalPagerContext))
    end,
    usePagerItem = usePagerItem,
    useIsPagerItemActive = function()
        local var1 = usePagerItem()

        return SignalsReact.useSignalState(var1.getIsActive)
    end
}
