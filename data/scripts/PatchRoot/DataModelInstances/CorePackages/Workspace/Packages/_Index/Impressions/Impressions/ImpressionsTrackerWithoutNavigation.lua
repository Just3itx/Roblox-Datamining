-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:00:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ImpressionsParent = script:FindFirstAncestor("Impressions").Parent
local React = require(ImpressionsParent.React)
local Signal = require(ImpressionsParent.AppCommonLib).Signal
local ImpressionsDetector = require(script.Parent.ImpressionsDetector)
local ImpressionDetectorWithoutNavigation = require(script.Parent.ImpressionDetectorWithoutNavigation)
local ImpressionsVisualizer = require(script.Parent.ImpressionsVisualizer)
local SharedFlags = require(ImpressionsParent.SharedFlags)

local bool1 = game:DefineFastFlag("LuaAppFixImpressionsHookDependencies", false)

local FFlagLuaAppUseScreenFillBoundsForFrameBoundsImpressions = SharedFlags.FFlagLuaAppUseScreenFillBoundsForFrameBoundsImpressions
local FFlagLuaAppSduiGameDwell = SharedFlags.FFlagLuaAppSduiGameDwell

return function(tbl1)
    local var1 = React.useRef({})
    local var2 = React.useRef(Signal.new())

    local var3 = React.useRef(nil)
    if var3.current == nil then
        var3.current = ImpressionsVisualizer.new(tbl1.impressionsTag)
    end
    assert(var3.current, "impressionsVisualizer should always be truthy; check needed for lint")
    local var4, var5 = React.useState({})
    local var6, var7 = React.useState(tbl1.dataUpdatedTimestamp)

    local var8 = React.useRef(tbl1.impressionsTag)
    local viewPortBounds = tbl1.viewPortBounds

    React.useEffect(function()
        if var8.current == tbl1.impressionsTag then
            return
        end

        var8.current = tbl1.impressionsTag
        var7(tbl1.dataUpdatedTimestamp)
        var1.current = {}
        var3.current:onClearAllImpressions()
        var3.current:setImpressionsTag(tbl1.impressionsTag)
        var2.current:fire()
    end, { tbl1.impressionsTag, if bool1 then tbl1.dataUpdatedTimestamp else nil })

    React.useEffect(function()
        var2.current:fire()
        local connection = if tbl1.scrollViewPositionChangedSignal then tbl1.scrollViewPositionChangedSignal:connect(function()
            var2.current:fire()
        end) else nil

        return function()
            if connection ~= nil then
                connection:disconnect()
            end
        end
    end, { tbl1.scrollViewPositionChangedSignal })

    React.useEffect(function()
        if not tbl1.pageContext or tbl1.routeName ~= tbl1.pageContext then
            return
        end

        var2.current:fire()
        if tbl1.dataUpdatedTimestamp ~= var6 then
            var7(tbl1.dataUpdatedTimestamp)
            var1.current = {}
            var3.current:onClearAllImpressions()
        end
    end, {
        tbl1.routeName,
        tbl1.pageContext,
        tbl1.dataUpdatedTimestamp,
        var6,
        viewPortBounds
    })

    local useEffect = React.useEffect

    local function func1()
        if var4 ~= nil and #var4 > 0 then
            tbl1.sendImpressions(var4)
            var3.current:onSendImpressions(var4)
            var5({})
        end
    end

    local sendImpressions = if bool1 then tbl1.sendImpressions else nil
    useEffect(func1, { var4, sendImpressions })

    React.useEffect(function()
        return function()
            var3.current:destroy()
        end
    end, {})

    local filterImpressionFunc = React.useCallback(function(arg1): boolean
        if var1.current[arg1] ~= nil then
            return false
        end

        var1.current[arg1] = true
        return true
    end, {})

    local onImpressionsDetected = React.useCallback(function(arg1)
        if not arg1 or #arg1 == 0 then
            return
        end

        var5(arg1)
    end, {})

    local var11 = if tbl1.pageContext then ImpressionsDetector else ImpressionDetectorWithoutNavigation
    return React.createElement(var11, {
        parentRef = tbl1.parentRef,
        visibilityObserver = if FFlagLuaAppSduiGameDwell then tbl1.visibilityObserver else nil,
        viewPortBounds = viewPortBounds,
        viewPortFillBounds = if FFlagLuaAppUseScreenFillBoundsForFrameBoundsImpressions then tbl1.viewPortFillBounds else nil,
        onRequestImpressionsSignal = var2.current,
        filterImpressionFunc = filterImpressionFunc,
        onImpressionsDetected = onImpressionsDetected,
        impressionsTag = tbl1.impressionsTag
    })
end
