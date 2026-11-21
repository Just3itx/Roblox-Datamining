-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T17:21:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameCollectionsParent = script:FindFirstAncestor("GameCollections").Parent
local React = require(GameCollectionsParent.React)
local Signal = require(GameCollectionsParent.AppCommonLib).Signal
local useRouteName = require(GameCollectionsParent.Navigation).useRouteName
local useSelector = require(GameCollectionsParent.RoactUtils).Hooks.RoactRodux.useSelector
local Cryo = require(GameCollectionsParent.Cryo)
local Impressions = require(GameCollectionsParent.Impressions)
local ScreenSizeImpressionsDetector = Impressions.ScreenSizeImpressionsDetector
local ImpressionsVisualizer = Impressions.ImpressionsVisualizer

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

    local var8 = useRouteName()
    local var9 = useSelector(function(arg1)
        return arg1.ScreenSize
    end)

    local var10 = React.useRef(tbl1.impressionsTag)

    React.useEffect(function()
        if var10.current == tbl1.impressionsTag then
            return
        end

        var10.current = tbl1.impressionsTag
        var7(tbl1.dataUpdatedTimestamp)
        var1.current = {}
        var3.current:onClearAllImpressions()
        var3.current:setImpressionsTag(tbl1.impressionsTag)
    end, { tbl1.impressionsTag })

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
        if not (if type(tbl1.pageContext) == "table" then Cryo.List.find(tbl1.pageContext, var8) ~= nil else var8 == tbl1.pageContext) then
            return
        end

        var2.current:fire()
        if tbl1.dataUpdatedTimestamp ~= var6 then
            var7(tbl1.dataUpdatedTimestamp)
            var1.current = {}
            var3.current:onClearAllImpressions()
        end
    end, {
        var8,
        tbl1.pageContext,
        tbl1.dataUpdatedTimestamp,
        var6,
        var9
    })
    React.useEffect(function()
        if var4 ~= nil and #var4 > 0 then
            tbl1.sendGameImpressions(var4)
            var3.current:onSendImpressions(var4)
            var5({})
        end
    end, { var4 })

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

    return React.createElement(ScreenSizeImpressionsDetector, {
        onRequestImpressionsSignal = var2.current,
        parentRef = tbl1.parentRef,
        filterImpressionFunc = filterImpressionFunc,
        onImpressionsDetected = onImpressionsDetected,
        impressionsTag = tbl1.impressionsTag
    })
end
