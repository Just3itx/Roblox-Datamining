-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:00:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CollectionService = game:GetService("CollectionService")
local ImpressionsParent = script:FindFirstAncestor("Impressions").Parent

local Roact = require(ImpressionsParent.Roact)
local ArgCheck = require(ImpressionsParent.ArgCheck)
local t = require(ImpressionsParent.t)
local SharedFlags = require(ImpressionsParent.SharedFlags)
local Constants = require(script.Parent.Constants)

local FFlagLuaAppUseScreenFillBoundsForFrameBoundsImpressions = SharedFlags.FFlagLuaAppUseScreenFillBoundsForFrameBoundsImpressions

local FFlagLuaAppSduiGameDwell = SharedFlags.FFlagLuaAppSduiGameDwell

local var1 = Roact.PureComponent:extend("ImpressionsDetectorWithoutNavigation")

var1.validateProps = t.strictInterface({
    scanDebounceSeconds = t.optional(t.number),
    viewFillPercent = t.optional(t.number),
    parentRef = t.optional(t.table),
    impressionsTag = t.string,
    onRequestImpressionsSignal = t.table,
    viewPortBounds = t.strictInterface({ min = t.Vector2, max = t.Vector2 }),
    viewPortFillBounds = if FFlagLuaAppUseScreenFillBoundsForFrameBoundsImpressions then t.optional(t.strictInterface({ min = t.Vector2, max = t.Vector2 })) else nil,
    filterImpressionFunc = t.optional(t.callback),
    onImpressionsDetected = t.union(t.callback, t.table),
    skipZeroSizes = t.optional(t.boolean),
    visibilityObserver = if FFlagLuaAppSduiGameDwell then t.optional(t.table) else nil,
    isFocused = t.optional(t.boolean),
    navigation = t.optional(t.table)
})

var1.defaultProps = { scanDebounceSeconds = 1, viewFillPercent = 0.25 }

function var1.init(arg1)
    arg1.isMounted = false
    arg1.lastImpressionTick = nil
    arg1.nextImpressionTick = nil
    if FFlagLuaAppSduiGameDwell then
        arg1.visibilityObserverCleanup = nil
    end
end

if FFlagLuaAppSduiGameDwell then
    function var1._attachVisibilityObserver(arg1)
        if arg1.props.visibilityObserver then
            arg1.visibilityObserverCleanup = arg1.props.visibilityObserver.attach(function()
                arg1:_requestImpressions()
            end, arg1.props.scanDebounceSeconds)
        end
    end
end

function var1._boundingBoxIntersectsView(arg1, arg2): boolean
    if not arg2 then
        return false
    end

    local viewPortBounds = arg1.props.viewPortBounds
    ArgCheck.assert(viewPortBounds ~= nil)
    if not viewPortBounds then
        return false
    end

    local absoluteSize = arg2.AbsoluteSize
    local absolutePosition = arg2.AbsolutePosition
    local var2 = absolutePosition + absoluteSize
    local bool1 = var2.X > viewPortBounds.min.X and absolutePosition.X < viewPortBounds.max.X
    local bool2 = var2.Y > viewPortBounds.min.Y and absolutePosition.Y < viewPortBounds.max.Y
    return not not (bool1 and bool2)
end

function var1._isInstanceVisible(arg1, arg2): boolean
    if not arg1:_boundingBoxIntersectsView(arg2) then
        return false
    end

    local viewPortBounds = arg1.props.viewPortBounds
    ArgCheck.assert(viewPortBounds ~= nil)
    local var2 = if FFlagLuaAppUseScreenFillBoundsForFrameBoundsImpressions then arg1.props.viewPortFillBounds or viewPortBounds else viewPortBounds
    local var3 = var2.max - var2.min
    if var3.X <= 0 or var3.Y <= 0 then
        return false
    end
    local var4 = var3 * arg1.props.viewFillPercent

    ArgCheck.assert(var4.X > 0 and var4.Y > 0)
    if var4.X <= 0 or var4.Y <= 0 then
        return false
    end

    local absolutePosition = arg2.AbsolutePosition
    local absoluteSize = arg2.AbsoluteSize
    if arg1.props.skipZeroSizes and (absoluteSize.X == 0 or absoluteSize.Y == 0) then
        return false
    end

    local var5 = absolutePosition + absoluteSize / 2
    local var6 = absolutePosition + absoluteSize
    local bool1 = var5.X > viewPortBounds.min.X and var5.X < viewPortBounds.max.X
    local bool2 = var5.Y > viewPortBounds.min.Y and var5.Y < viewPortBounds.max.Y

    if bool1 and bool2 then
        return true
    end

    local var7 = absolutePosition:Max(viewPortBounds.min)
    local var8 = var6:Min(viewPortBounds.max) - var7

    local bool3 = var8.X >= var4.X

    if bool2 and bool3 then
        return true
    end

    local bool4 = var8.Y >= var4.Y

    return if bool1 and bool4 then true else not not (bool3 and bool4)
end

function var1._calculateImpressions(arg1)
    if not arg1.isMounted or arg1.props.isFocused == false then
        return
    end

    arg1.lastImpressionTick = tick()

    if arg1.props.parentRef ~= nil then
        local current = arg1.props.parentRef.current
        if current == nil or not arg1:_boundingBoxIntersectsView(current) then
            if FFlagLuaAppSduiGameDwell and arg1.props.visibilityObserver then
                arg1.props.visibilityObserver.sample({}, current ~= nil)
            end
            return
        end
    end

    local impressionsTag = arg1.props.impressionsTag
    local tbl1 = {}

    local var2 = FFlagLuaAppSduiGameDwell and arg1.props.visibilityObserver and {} or nil

    local tagged = CollectionService:GetTagged(impressionsTag)
    for _, value in ipairs(tagged) do
        local var3 = value:GetAttribute(Constants.ItemIndex)
        if not (var3 and value:IsA("GuiObject") and arg1:_isInstanceVisible(value)) then
            continue
        end

        if FFlagLuaAppSduiGameDwell and var2 then
            table.insert(var2, var3)
        end
        if arg1.props.filterImpressionFunc == nil or arg1.props.filterImpressionFunc(var3) then
            table.insert(tbl1, var3)
        end
    end

    if FFlagLuaAppSduiGameDwell and var2 then
        arg1.props.visibilityObserver.sample(var2, true)
    end

    if #tbl1 > 0 then
        ArgCheck.assert(arg1.props.onImpressionsDetected ~= nil)
        arg1.props.onImpressionsDetected(tbl1)
    end
end

function var1._requestImpressions(arg1)
    if not arg1.isMounted or arg1.props.isFocused == false or arg1.nextImpressionTick ~= nil or not arg1.props.impressionsTag then
        return
    end

    local var2

    if arg1.lastImpressionTick == nil then
        var2 = 0
    else
        arg1.nextImpressionTick = arg1.lastImpressionTick + arg1.props.scanDebounceSeconds
        var2 = arg1.nextImpressionTick - tick()
    end
    if not (var2 > 0) then
        arg1.nextImpressionTick = nil
        arg1:_calculateImpressions()
        return
    end

    task.delay(var2, function()
        ArgCheck.assert(not (arg1.nextImpressionTick == nil) and tick() > arg1.nextImpressionTick)
        arg1.nextImpressionTick = nil
        arg1:_calculateImpressions()
    end)
end

function var1.render(_)
    return nil
end

function var1.didMount(arg1)
    arg1.isMounted = true
    if FFlagLuaAppSduiGameDwell then
        arg1:_attachVisibilityObserver()
    end
    arg1:_requestImpressions()
    if arg1.props.onRequestImpressionsSignal then
        arg1.onRequestImpressionsConnection = arg1.props.onRequestImpressionsSignal:connect(function()
            arg1:_requestImpressions()
        end)
    end
end

function var1.willUnmount(arg1)
    arg1.isMounted = false
    if FFlagLuaAppSduiGameDwell and arg1.visibilityObserverCleanup then
        arg1.visibilityObserverCleanup("teardown")
        arg1.visibilityObserverCleanup = nil
    end
    if arg1.onRequestImpressionsConnection ~= nil then
        arg1.onRequestImpressionsConnection:disconnect()
        arg1.onRequestImpressionsConnection = nil
    end
end

function var1.didUpdate(arg1, arg2, _)
    if FFlagLuaAppSduiGameDwell then
        if arg2.visibilityObserver ~= arg1.props.visibilityObserver then
            if arg1.visibilityObserverCleanup then
                arg1.visibilityObserverCleanup("collectionReplaced")
                arg1.visibilityObserverCleanup = nil
            end
            arg1:_attachVisibilityObserver()
        elseif arg1.props.visibilityObserver and arg2.isFocused ~= arg1.props.isFocused then
            arg1.props.visibilityObserver.focusChanged(arg1.props.isFocused ~= false)
        end
    end

    arg1:_requestImpressions()
end

return var1
