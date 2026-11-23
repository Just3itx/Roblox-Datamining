-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:41:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceAnalyticsParent = script:FindFirstAncestor("AvatarExperienceAnalytics").Parent

local Roact = require(AvatarExperienceAnalyticsParent.Roact)
local RoactRodux = require(AvatarExperienceAnalyticsParent.RoactRodux)
local ArgCheck = require(AvatarExperienceAnalyticsParent.ArgCheck)
local t = require(AvatarExperienceAnalyticsParent.t)
local FFlagUseNavigationSelectors = require(AvatarExperienceAnalyticsParent.SharedFlags).FFlagUseNavigationSelectors
local Selectors = require(AvatarExperienceAnalyticsParent.NavigationRodux).Selectors

local FFlagSignalsNavP3gAvatarExperience = require(AvatarExperienceAnalyticsParent.SharedFlags).FFlagSignalsNavP3gAvatarExperience

local React = require(AvatarExperienceAnalyticsParent.React)
local Cryo = require(AvatarExperienceAnalyticsParent.Cryo)
local useSignalState = require(AvatarExperienceAnalyticsParent.SignalsReact).useSignalState
local GetLegacyNavigationStore = if FFlagSignalsNavP3gAvatarExperience then require(AvatarExperienceAnalyticsParent.NavigationRodux).GetLegacyNavigationStore else nil
local var1 = Roact.PureComponent:extend("AvatarExperienceImpressionsDetector")

local function func1(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if FFlagUseNavigationSelectors then
        return Selectors.selectCurrentPageName(arg1)
    end
    local history = arg1.Navigation.history
    local var2 = history[#history]
    return var2[#var2].name
end

local strictInterface = t.strictInterface
local tbl1 = {
    scanDebounceSeconds = t.optional(t.number),
    viewFillPercent = t.optional(t.number),
    parentRef = t.optional(t.table),
    onRequestImpressionsSignal = t.table,
    viewPortBounds = t.strictInterface({ min = t.Vector2, max = t.Vector2 }),
    appPage = t.optional(t.string),
    currentPage = t.optional(t.string),
    pageEligible = if FFlagSignalsNavP3gAvatarExperience then t.optional(t.boolean) else nil,
    pageFilter = t.optional(t.callback),
    collectObjectsFunc = t.optional(t.callback),
    filterImpressionFunc = t.optional(t.callback),
    onImpressionsDetected = t.union(t.callback, t.table)
}
var1.validateProps = strictInterface(tbl1)

var1.defaultProps = { scanDebounceSeconds = 1, viewFillPercent = 0.25 }

function var1.init(arg1)
    arg1.isMounted = false
    arg1.lastImpressionTick = nil
    arg1.nextImpressionTick = nil
end

function var1._isInstanceVisible(arg1, arg2): boolean
    if not arg2 then
        return false
    end

    local viewPortBounds = arg1.props.viewPortBounds
    ArgCheck.assert(viewPortBounds ~= nil)
    if not viewPortBounds then
        return false
    end

    local var2 = viewPortBounds.max - viewPortBounds.min
    ArgCheck.assert(var2.X > 0)
    ArgCheck.assert(var2.Y > 0)
    local var3 = var2 * arg1.props.viewFillPercent

    ArgCheck.assert(var3.X > 0 and var3.Y > 0)
    if var3.X <= 0 or var3.Y <= 0 then
        return false
    end

    if arg2.AbsoluteSize.X <= 0 or arg2.AbsoluteSize.Y <= 0 then
        return false
    end

    local absolutePosition = arg2.AbsolutePosition
    local var4 = absolutePosition + arg2.AbsoluteSize / 2
    local var5 = absolutePosition + arg2.AbsoluteSize
    local bool1 = var4.X > viewPortBounds.min.X and var4.X < viewPortBounds.max.X
    local bool2 = var4.Y > viewPortBounds.min.Y and var4.Y < viewPortBounds.max.Y

    if bool1 and bool2 then
        return true
    end

    local var6 = absolutePosition:Max(viewPortBounds.min)
    local var7 = var5:Min(viewPortBounds.max) - var6

    local bool3 = var7.X >= var3.X

    if bool2 and bool3 then
        return true
    end

    local bool4 = var7.Y >= var3.Y

    return if bool1 and bool4 then true else not not (bool3 and bool4)
end

function var1._defaultObjectCollector(arg1)
    return arg1:GetChildren()
end

function var1._calculateImpressions(arg1)
    if not arg1.isMounted then
        return
    end

    if arg1.props.pageFilter then
        if not arg1.props.pageFilter(arg1.props.currentPage) then
            return
        end
    elseif FFlagSignalsNavP3gAvatarExperience then
        if not arg1.props.pageEligible then
            return
        end
    elseif arg1.props.appPage ~= arg1.props.currentPage then
        return
    end

    local current = arg1.props.parentRef and arg1.props.parentRef.current
    if not (current and arg1:_isInstanceVisible(current)) then
        return
    end

    arg1.lastImpressionTick = tick()
    local tbl2 = {}
    local var2 = (arg1.props.collectObjectsFunc or arg1._defaultObjectCollector)(current)
    if var2 then
        for _, value in var2 do
            if value:IsA("GuiObject")
                and arg1:_isInstanceVisible(value)
                and (arg1.props.filterImpressionFunc == nil or arg1.props.filterImpressionFunc(value))
            then
                table.insert(tbl2, value)
            end
        end
    end

    if #tbl2 > 0 then
        ArgCheck.assert(arg1.props.onImpressionsDetected ~= nil)
        arg1.props.onImpressionsDetected(tbl2)
    end
end

function var1._requestImpressions(arg1)
    if not arg1.isMounted or arg1.nextImpressionTick ~= nil or not arg1.props.parentRef or not arg1.props.parentRef.current then
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
    arg1:_requestImpressions()
    if arg1.props.onRequestImpressionsSignal then
        arg1.onRequestImpressionsConnection = arg1.props.onRequestImpressionsSignal:connect(function()
            arg1:_requestImpressions()
        end)
    end
end

function var1.willUnmount(arg1)
    arg1.isMounted = false
    if arg1.onRequestImpressionsConnection ~= nil then
        arg1.onRequestImpressionsConnection:disconnect()
        arg1.onRequestImpressionsConnection = nil
    end
end

function var1.didUpdate(arg1, _, _)
    arg1:_requestImpressions()
end

if not FFlagSignalsNavP3gAvatarExperience then
    return (RoactRodux.connect(function(arg1, _)
        return {
            currentPage = func1(arg1)
        }
    end)(var1))
end

return function(arg1)
    local legacyNavigationStore = GetLegacyNavigationStore(false)

    local currentPage = useSignalState(legacyNavigationStore.getCurrentPageName)

    local var3 = arg1.pageFilter and { currentPage = currentPage } or {
        pageEligible = arg1.appPage == currentPage
    }
    return React.createElement(var1, Cryo.Dictionary.union(arg1, var3))
end
