-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:30:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local React = require(MomentsParent.React)
local Signals = require(MomentsParent.Signals)

local _FeedTypes = require(script.Parent.FeedTypes)
local NavigationDestinationType = require(Moments.Enums.NavigationDestinationType)

local FFlagMomentsFixRecommendationImpressionLifecycle = require(Moments.Flags.FFlagMomentsFixRecommendationImpressionLifecycle)
local FFlagMomentsNavigationEvent = require(Moments.Flags.FFlagMomentsNavigationEvent)

local HttpService = game:GetService("HttpService")

local function mintViewId(): string -- Luacid: Inlined by compiler; 2 call sites recovered
    return HttpService:GenerateGUID(false)
end

local function resolvePagerDestination(tbl1, leftItemId: string?, toIndex: number) -- Luacid: Inlined by compiler; 1 call site recovered
    return if tbl1 == nil or leftItemId == nil or tbl1.leftItemId ~= leftItemId or tbl1.toIndex ~= toIndex then NavigationDestinationType.Unknown else tbl1.destination
end

local function useFeedTelemetry(arg1, tbl1)
    local active = tbl1.active

    local var1 = React.useRef(nil)
    local var2 = React.useRef(1)
    local var3 = React.useRef(0)
    local var4 = React.useRef(nil)
    local var5 = React.useRef(nil)
    local var6 = React.useRef(nil)

    local var7 = React.useRef(tbl1.telemetry)
    var7.current = tbl1.telemetry
    local var8 = React.useRef(tbl1.recommendationSource)
    var8.current = tbl1.recommendationSource
    local var9 = React.useRef(tbl1.getAttribution)
    var9.current = tbl1.getAttribution
    local var10 = React.useRef(tbl1.onItemBecameActive)
    var10.current = tbl1.onItemBecameActive
    local var11 = React.useRef(tbl1.onEndStateReached)
    var11.current = tbl1.onEndStateReached
    local var12 = React.useRef(tbl1.onViewEnded)
    var12.current = tbl1.onViewEnded
    local var13 = React.useRef(tbl1.inactiveDestination)
    var13.current = tbl1.inactiveDestination

    local var14 = React.useRef(active)
    var14.current = active

    local flushView = React.useCallback(function(destination)
        local current = var1.current
        if current == nil then
            return nil
        end
        local current2 = var3.current
        if var4.current ~= nil then
            current2 += os.clock() - var4.current
        end
        local current3 = var5.current
        var1.current = nil
        var4.current = nil
        var3.current = 0
        var5.current = nil

        if current2 <= 0 then
            return current3
        end
        var7.current.logView(
            current,
            {
                durationSeconds = current2,
                itemPosition = var2.current,
                recommendationSource = var8.current
            }
        )
        local current4 = var12.current
        if FFlagMomentsNavigationEvent and current3 ~= nil and current4 ~= nil then
            current4(current, {
                viewId = current3,
                durationSeconds = current2,
                itemPosition = var2.current,
                destination = destination or NavigationDestinationType.Unknown
            })
        end
        return current3
    end, {})

    React.useEffect(function()
        local effect = Signals.createEffect(function(arg2)
            local currentItem = arg1.getCurrentItem(arg2)
            local destination

            if FFlagMomentsNavigationEvent then
                local current = var1.current

                local current2 = var6.current
                local itemId = if current == nil then nil else current.itemId
                local currentIndex = arg1.getCurrentIndex(false)

                if current2 ~= nil and itemId ~= nil and current2.leftItemId == itemId and current2.toIndex == currentIndex then
                    destination = current2.destination
                else
                    destination = resolvePagerDestination(nil, nil, nil)
                end

                var6.current = nil
            else
                destination = nil
            end
            flushView(destination)
            if currentItem == nil then
                return
            end

            if (currentItem.kind == "endState" or currentItem.kind == "caughtUp") and var14.current and var11.current then
                var11.current(arg1.getCurrentIndex(false))
            end
            local current = var9.current(currentItem)
            if current == nil then
                return
            end
            var1.current = current

            var2.current = arg1.getCurrentIndex(false)
            var3.current = 0
            local var17 = var5
            var17.current = if FFlagMomentsNavigationEvent then mintViewId() else nil

            local var18 = var4
            var18.current = if var14.current then os.clock() else nil

            if var14.current and var10.current then
                var10.current(currentItem)
            end
        end)
        return function()
            effect()
            flushView()
        end
    end, { arg1, flushView })

    React.useEffect(function()
        if not active then
            if FFlagMomentsFixRecommendationImpressionLifecycle then
                flushView(var13.current)
                return
            end

            if var4.current ~= nil then
                local var16 = var3
                var16.current += os.clock() - var4.current
                var4.current = nil
            end

            return
        end

        if not FFlagMomentsFixRecommendationImpressionLifecycle or var1.current ~= nil then
            if var1.current ~= nil and var4.current == nil then
                var4.current = os.clock()
            end

            return
        end

        local currentItem = arg1.getCurrentItem(false)
        if currentItem == nil then
            return
        end
        local current = var9.current(currentItem)
        if current == nil then
            return
        end
        var1.current = current
        var2.current = arg1.getCurrentIndex(false)
        var3.current = 0
        var4.current = os.clock()
        local var17 = var5
        var17.current = if FFlagMomentsNavigationEvent then mintViewId() else nil
    end, { active, arg1, flushView })

    return {
        flushView = flushView,
        getViewId = function()
            return var5.current
        end,
        noteUserStep = function(num1: number, toIndex: number)
            local num2 = toIndex - num1
            if num2 ~= 1 and num2 ~= -1 then
                var6.current = nil
                return
            end
            local current = var1.current
            local var16 = var6
            var16.current = {
                leftItemId = if current == nil then nil else current.itemId,
                toIndex = toIndex,
                destination = if num2 == 1 then NavigationDestinationType.NextMoment else NavigationDestinationType.PreviousMoment
            }
        end
    }
end

return useFeedTelemetry
