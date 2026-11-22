-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:10:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local React = require(MomentsParent.React)
local Signals = require(MomentsParent.Signals)
local SignalsReact = require(MomentsParent.SignalsReact)

local VerticalPagerContext = require(Moments.Components.VerticalPager.VerticalPagerContext)
local _FeedTypes = require(Moments.Components.Feed.FeedTypes)
local GameGetPlayabilityStore = require(MomentsParent.DataHydration.GameGetPlayabilityStore)
local isVideoEligibleForPlayability = require(MomentsParent.VideoUtils).isVideoEligibleForPlayability

local useSignalState = SignalsReact.useSignalState
local useVerticalPager = VerticalPagerContext.useVerticalPager

local tbl1 = {
    data = Signals.createComputed(function()
        return nil
    end),
    status = Signals.createComputed(function(): string
        return "Ready"
    end)
}

local function useEdpVideoEligibilityViewModel(tbl2)
    local var1 = useVerticalPager()
    local var2 = GameGetPlayabilityStore(false)
    local str1 = tostring(tbl2.universeId or 0)
    local bool1 = not (tbl2.universeId == nil) and tbl2.universeId > 0
    local var3 = React.useRef(false)

    local var4 = React.useMemo(function()
        if not bool1 then
            return tbl1
        end
        return (var2.getAndFetchPlayability(str1))
    end, { bool1, var2, str1 })
    local var5 = useSignalState(var4.data)
    local var6 = useSignalState(var4.status)
    local var7 = isVideoEligibleForPlayability(var6 == "Ready", var5)

    local status = bool1 and var6 ~= "Failed" and (var6 == "Ready" and (if var7 then "Eligible" else "Ineligible") or "Loading")
        or "Ineligible"

    React.useEffect(function()
        if status ~= "Ineligible" or var3.current then
            return
        end

        for value, value2 in var1.store.getItems(false) do
            if value2.kind == "moment" and value2.moment.momentId == tbl2.momentId then
                var3.current = true
                var1.removeItem(value)
                return
            end
        end
    end, { var1, tbl2.momentId, status })

    return { status = status }
end

return useEdpVideoEligibilityViewModel
