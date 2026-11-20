-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:51:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Map = LuauPolyfill.Map
local Set = LuauPolyfill.Set
local Object = LuauPolyfill.Object
local console = LuauPolyfill.console
local setTimeout = LuauPolyfill.setTimeout
local clearTimeout = LuauPolyfill.clearTimeout
local invariant = require(scriptParentParent.jsUtils.invariant)

local _isEntirelyVisible = nil
local _getPixelsVisible = nil
local _isViewable = nil

local module = {}
module.__index = module
function module.new(tbl1)
    local self = setmetatable({}, module)

    self._hasInteracted = false
    self._timers = Set.new()
    self._viewableIndices = {}
    self._viewableItems = Map.new()
    self._config = tbl1 == nil and { viewAreaCoveragePercentThreshold = 0 } or tbl1
    return self
end

function module:dispose()
    self._timers:forEach(function(arg1)
        clearTimeout(arg1)
    end)
end

function module:computeViewableItems(last: number, num1: number, num2: number, func1: (...any) -> (...any), arg1)
    local itemVisiblePercentThreshold = self._config.itemVisiblePercentThreshold
    local viewAreaCoveragePercentThreshold = self._config.viewAreaCoveragePercentThreshold
    local bool1 = viewAreaCoveragePercentThreshold ~= nil
    local var1 = if bool1 then viewAreaCoveragePercentThreshold else itemVisiblePercentThreshold
    invariant(
        not (var1 == nil) and itemVisiblePercentThreshold ~= nil ~= (viewAreaCoveragePercentThreshold ~= nil),
        "Must set exactly one of itemVisiblePercentThreshold or viewAreaCoveragePercentThreshold"
    )
    local result = {}
    if last == 0 then
        return result
    end

    local var2 = arg1 or { first = 1, last = last }
    local first = var2.first
    local last2 = var2.last

    if last < last2 then
        console.warn(
            "Invalid render range computing viewability { renderRange = " .. tostring(arg1) .. ", itemCount = " .. tostring(last) .. " }"
        )
        return {}
    end

    local num3 = 0

    while first <= last2 do
        local var3 = func1(first)
        if not var3 then
            first += 1
        else
            local var4 = var3.offset - num1
            local var5 = var4 + var3.length
            if var4 < num2 and var5 > 0 then
                if _isViewable(bool1, var1, var4, var5, num2, var3.length) then
                    table.insert(result, first)
                    num3 = first
                else
                    num3 = first
                end
            elseif num3 >= 1 then
                break
            end

            first += 1
        end
    end

    return result
end

function module:onUpdate(num1: number, num2: number, num3: number, func1: (...any) -> (...any), func2: (...any) -> (...any), func3: (...any) -> (...any), arg1)
    if self._config.waitForInteraction and not self._hasInteracted or num1 == 0 or not func1(1) then
        return
    end

    local tbl1 = {}
    if num1 then
        tbl1 = self:computeViewableItems(num1, num2, num3, func1, arg1)
    end

    if #self._viewableIndices == #tbl1 and Array.every(self._viewableIndices, function(arg2, arg3): boolean
        return arg2 == tbl1[arg3]
    end) then
        return
    end
    self._viewableIndices = tbl1
    if not self._config.minimumViewTime then
        self:_onUpdateSync(tbl1, func3, func2)
        return
    end

    local var1 = nil
    var1 = setTimeout(function()
        self._timers:delete(var1)
        self:_onUpdateSync(tbl1, func3, func2)
    end, self._config.minimumViewTime)

    self._timers:add(var1)
end

function module:resetViewableIndices()
    self._viewableIndices = {}
end

function module:recordInteraction()
    self._hasInteracted = true
end

function module:_onUpdateSync(arg1, callback, arg2)
    arg1 = Array.filter(arg1, function(arg3)
        return Array.includes(self._viewableIndices, arg3)
    end)
    local _viewableItems = self._viewableItems
    local map = Map.new(Array.map(arg1, function(arg3)
        local var1 = arg2(arg3, true)
        return { var1.key, var1 }
    end))
    local changed = {}
    for _, value in ipairs(map:keys()) do
        if not _viewableItems:has(value) then
            table.insert(changed, map:get(value))
        end
    end
    for _, value in ipairs(_viewableItems:keys()) do
        if map:has(value) then
            continue
        end

        local var1 = _viewableItems:get(value)
        table.insert(changed, Object.assign({}, var1, { isViewable = false }))
    end

    if not (#changed > 0) then
        return
    end

    self._viewableItems = map
    callback({ viewableItems = Array.from(map:values()), changed = changed, viewabilityConfig = self._config })
end

_isViewable = function(bool1: boolean, num1: number, num2: number, num3: number, num4: number, num5: number): boolean
    if _isEntirelyVisible(num2, num3, num4) then
        return true
    end
    local var1 = _getPixelsVisible(num2, num3, num4)
    return num1 <= 100 * (if bool1 then var1 / num4 else var1 / num5)
end

_getPixelsVisible = function(num1: number, num2: number, num3: number): number
    return math.max(0, math.min(num2, num3) - math.max(num1, 0))
end

_isEntirelyVisible = function(num1: number, num2: number, num3: number): boolean
    return num1 >= 0 and num2 <= num3 and num1 < num2
end

return module
