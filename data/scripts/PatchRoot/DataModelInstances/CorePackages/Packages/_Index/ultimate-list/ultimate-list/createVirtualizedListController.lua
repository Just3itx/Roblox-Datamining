-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:41:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ultimateList = script:FindFirstAncestor("ultimate-list")

local DataSourceMethods = require(ultimateList.DataSources.DataSourceMethods)
local _DataSources = require(ultimateList.DataSources)
local _Dimensions = require(ultimateList.Dimensions)
local DimensionsMethods = require(ultimateList.Dimensions.DimensionsMethods)
local binarySearchIndexRangeInView = require(script.binarySearchIndexRangeInView)
local createDebugLogger = require(ultimateList.Util.createDebugLogger)
local exhaustiveMatch = require(ultimateList.Util.exhaustiveMatch)

local debugLogger = createDebugLogger("createVirtualizedListController")

local function createVirtualizedListController(dataSource, lastDimensions, str1: string)
    local tbl1 = {
        range = Vector3.new(),
        canvasSize = UDim2.new(),
        windowSize = Vector2.new(),
        lastDimensions = lastDimensions,
        scrollSizeAxis = 0,
        cachedLastResult = {},
        dataSource = dataSource
    }

    local num1 = 0

    local dominantAxis = 0
    local vector2 = Vector2.new()
    local num2 = 0

    local function getRangeAxes(): (number, number) -- Luacid: Inlined by compiler; 2 call sites recovered
        local num3 = math.max(0, num1 - num2)
        return num3, num1 + dominantAxis + num2 - num3
    end

    local function getIndexRangeInViewForSize(num3: number, rangeAxes: number, num4: number): Vector3 -- Luacid: Inlined by compiler; 2 call sites recovered
        return Vector3.new(rangeAxes // num3 + 1, (rangeAxes + num4) // num3 + 1)
    end

    local function getIndexRangeInViewForUDim2(uDim2: UDim2, rangeAxes: number, num3: number): Vector3
        local amountPerNonDominantInGrid = DimensionsMethods.getAmountPerNonDominantInGrid(uDim2, vector2, str1)
        local var1 = if str1 == "x" then uDim2.X.Offset elseif str1 == "y" then uDim2.Y.Offset else exhaustiveMatch(str1)
        local x = 1 + rangeAxes // var1 * amountPerNonDominantInGrid
        local y = (1 + (rangeAxes + num3) // var1) * amountPerNonDominantInGrid

        debugLogger(
            "getIndexRangeInView: amountPerNonDominant = %d, scrollAxis = %d, dominantSize = %d. Going from %d to %d",
            amountPerNonDominantInGrid,
            rangeAxes,
            var1,
            x,
            y
        )

        return Vector3.new(x, y)
    end

    local function getIndexRangeInView()
        local num3, num4 = getRangeAxes()

        if lastDimensions.type == "consistentUDim2" then
            return (getIndexRangeInViewForUDim2(lastDimensions.udim2, num3, num4))
        elseif lastDimensions.type == "consistentSize" then
            return getIndexRangeInViewForSize(lastDimensions.size, num3, num4)
        elseif lastDimensions.type == "getter" then
            return binarySearchIndexRangeInView(dataSource, lastDimensions.callback, num3, num4, str1)
        end
        if lastDimensions.type ~= "spaced" then
            return exhaustiveMatch(lastDimensions.type)
        end

        if lastDimensions.inner.type == "consistentSize" then
            return getIndexRangeInViewForSize(lastDimensions.inner.size + lastDimensions.spacing, num3, num4)
        elseif lastDimensions.inner.type == "consistentUDim2" then
            return (getIndexRangeInViewForUDim2(
                lastDimensions.inner.udim2 + UDim2.fromOffset(if str1 ~= "x" then 0 else lastDimensions.spacing, if str1 ~= "y" then 0 else lastDimensions.spacing),
                num3,
                num4
            ))
        end

        if lastDimensions.inner.type ~= "spaced" and lastDimensions.inner.type ~= "getter" then
            return exhaustiveMatch(lastDimensions.inner.type)
        end

        error("Unsupported spaced dimensions")
    end

    local tbl2 = ({})

    local function callUpdateCallbacks() -- Luacid: Inlined by compiler; 2 call sites recovered
        for value in tbl2 do
            value()
        end
    end

    local function update()
        local x, num3 = getRangeAxes()

        if tbl1.offsetBoundaries ~= nil
            and tbl1.offsetBoundaries.X <= x
            and tbl1.offsetBoundaries.Y >= num3 + x
            and tbl1.windowSize == vector2
            and tbl1.dataSource == dataSource
            and tbl1.lastDimensions == lastDimensions
        then
            return
        end

        local range = getIndexRangeInView()
        local cachedLastResult = DataSourceMethods.getByRange(dataSource, range)

        if #cachedLastResult == 0 then
            debugLogger("View changed, but no items in list")

            tbl1 = {
                range = range,
                canvasSize = DimensionsMethods.getCanvasSize(lastDimensions, dataSource, vector2, str1),
                windowSize = vector2,
                lastDimensions = lastDimensions,
                cachedLastResult = {},
                offsetBoundaries = Vector3.new(x, num3 + x),
                dataSource = dataSource
            }
            callUpdateCallbacks()
            return
        end

        local uDimRect = DimensionsMethods.getUDimRect(lastDimensions, cachedLastResult[1], range.X, vector2, str1)

        local uDimRect2 = DimensionsMethods.getUDimRect(lastDimensions, cachedLastResult[#cachedLastResult], range.Y, vector2, str1)

        debugLogger(
            "View changed: %d..%d (scroll axis: %d, window axis: %d, offset boundaries: %* - %*)",
            range.X,
            range.Y,
            num1,
            dominantAxis,
            tbl1.offsetBoundaries and tbl1.offsetBoundaries.X,
            tbl1.offsetBoundaries and tbl1.offsetBoundaries.Y
        )

        local tbl3 = {
            range = range,
            canvasSize = DimensionsMethods.getCanvasSize(lastDimensions, dataSource, vector2, str1),
            windowSize = vector2,
            lastDimensions = lastDimensions,
            cachedLastResult = cachedLastResult,
            offsetBoundaries = 0,
            dataSource = 0
        }
        local x2 = if str1 == "x" then uDimRect.position.X.Offset elseif str1 == "y" then uDimRect.position.Y.Offset else exhaustiveMatch(str1)
        local y

        if str1 == "x" then
            y = uDimRect2.position.X.Offset + uDimRect2.size.X.Offset
        elseif str1 == "y" then
            y = uDimRect2.position.Y.Offset + uDimRect2.size.Y.Offset
        else
            y = exhaustiveMatch(str1)
        end

        tbl3.offsetBoundaries = Vector3.new(x2, y)

        tbl3.dataSource = dataSource
        tbl1 = tbl3
        callUpdateCallbacks()
    end

    local function setScrollAxis(num3: number)
        num1 = num3
        update()
    end

    local function setDataSource(arg3)
        assert(dataSource.type == arg3.type, "Data source type changed, you must keep it the same")

        if DataSourceMethods.equals(dataSource, arg3) then
            return
        end

        dataSource = arg3
        update()
    end

    local function setDimensions(arg3)
        if DimensionsMethods.equals(lastDimensions, arg3) then
            return
        end

        lastDimensions = arg3
        update()
    end

    local function setWindowSize(vector2_2: Vector2)
        if vector2 == vector2_2 then
            return
        end

        vector2 = vector2_2
        dominantAxis = DimensionsMethods.getDominantAxis(vector2_2, str1)

        update()
    end

    local function getWindowSize()
        return vector2
    end

    local function setOverscan(num3: number)
        assert(num3 >= 0, "overscan must not be negative")

        if num2 == num3 then
            return
        end

        num2 = num3
        update()
    end

    local function get(): number
        return tbl1.cachedLastResult
    end

    local function getCanvasSize(): number
        return tbl1.canvasSize
    end

    local function getRange(): number
        return tbl1.range
    end

    local function bindToUpdate(func1: (...any) -> (...any))
        tbl2[func1] = true
        return function()
            tbl2[func1] = nil
        end
    end

    local var1 = if dataSource.type == "mutableSource" then dataSource.methods.bindToChanged(update) else nil

    return {
        setScrollAxis = setScrollAxis,
        setDataSource = setDataSource,
        setDimensions = setDimensions,
        setWindowSize = setWindowSize,
        getWindowSize = getWindowSize,
        setOverscan = setOverscan,
        get = get,
        getCanvasSize = getCanvasSize,
        getRange = getRange,
        bindToUpdate = bindToUpdate,
        destroy = function()
            if var1 ~= nil then
                var1()
            end
        end
    }
end

return createVirtualizedListController
