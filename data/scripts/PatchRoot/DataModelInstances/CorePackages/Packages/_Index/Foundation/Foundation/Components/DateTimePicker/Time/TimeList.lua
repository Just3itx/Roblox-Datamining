-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T07:41:07Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local DateTimeCalendarViewUtilities = require(script.Parent.Parent.Utilities.DateTimeCalendarViewUtilities)
local DateTimeLayoutUtilities = require(script.Parent.Parent.Utilities.DateTimeLayoutUtilities)
local DateTimeUtilities = require(script.Parent.Parent.DateTimeUtilities)

local ScrollView = require(Foundation.Components.ScrollView)
local StateLayerMode = require(Foundation.Enums.StateLayerMode)
local Text = require(Foundation.Components.Text)
local useTokens = require(Foundation.Providers.Style.useTokens)
local withDefaults = require(Foundation.Utility.withDefaults)

local tbl1 = { testId = "--foundation-time-list" }

local function TimeList(tbl2)
    local var1 = withDefaults(tbl2, tbl1)
    local var2 = useTokens()
    local size900 = var2.Size.Size_900
    local var3 = var1.width or UDim.new(0, DateTimeLayoutUtilities.TIME_LIST_WIDTH)
    local scrollingFrameRef = React.useRef(nil)

    local var5 = React.useRef(false)
    local var6 = React.useRef(true)
    local var7 = React.useRef(nil)

    local var8, var9 = React.useMemo(function()
        local var8 = var1.dateTime or var1.dayAnchor or DateTime.now()
        return DateTimeCalendarViewUtilities.getTimeSlotsForDay(var8)
    end, { var1.dateTime, var1.dayAnchor })

    if not var1.dateTime then
        var9 = nil
    end
    local function getTimeKey(unixTimestamp: number?) -- Luacid: Inlined by compiler; 1 call site recovered
        if unixTimestamp == nil then
            return nil
        end
        local var10 = DateTimeUtilities.toLocalTime(DateTime.fromUnixTimestamp(unixTimestamp))
        return string.format("%02d:%02d", var10.Hour, var10.Minute)
    end

    React.useEffect(function()
        local timeKey = getTimeKey(var9)

        if var5.current then
            var5.current = false
            var7.current = timeKey
            var6.current = false
            return
        end

        local current = scrollingFrameRef.current
        if not current then
            return
        end

        local current2 = var6.current
        var6.current = false

        if timeKey == nil then
            var7.current = nil
            return
        end

        if timeKey == var7.current then
            return
        end

        if not current2 and var7.current == nil then
            var7.current = timeKey
            return
        end

        var7.current = timeKey

        local timeSlotIndex = DateTimeCalendarViewUtilities.getTimeSlotIndex(var8, var9)
        if not timeSlotIndex then
            return
        end
        local var10 = (timeSlotIndex - 1) * size900 - var1.height / 2 + size900 / 2
        current.CanvasPosition = Vector2.new(0, math.max(0, var10))
    end, {
        var9,
        var8,
        size900,
        var1.height
    })
    local tbl3 = ({})
    for layoutOrder, value2 in var8 do
        local bool1 = value2.id == var9
        local str1 = `slot-{value2.id}`
        local createElement = React.createElement
        local var10 = Text
        local tbl4 = {
            LayoutOrder = layoutOrder,
            Size = UDim2.new(1, 0, 0, size900),
            Text = value2.text,
            textStyle = if bool1 then var2.Inverse.Content.Emphasis else nil,
            backgroundStyle = if bool1 then var2.Color.System.Contrast else nil,
            stateLayer = {
                mode = if bool1 then StateLayerMode.Inverse else StateLayerMode.Default
            },
            onActivated = 0,
            tag = "size-full-0 auto-y padding-x-medium text-body-medium text-align-x-left text-align-y-center radius-medium",
            testId = 0
        }
        function tbl4.onActivated()
            var5.current = true
            var1.onItemChanged(value2.id)
        end

        tbl4.testId = `{var1.testId}--slot-{layoutOrder}`
        tbl3[str1] = createElement(var10, tbl4)
    end

    return React.createElement(ScrollView, {
        LayoutOrder = var1.LayoutOrder,
        Size = UDim2.new(var3.Scale, var3.Offset, 0, var1.height),
        layout = {
            FillDirection = Enum.FillDirection.Vertical,
            SortOrder = Enum.SortOrder.LayoutOrder
        },
        scroll = {
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            CanvasSize = UDim2.fromOffset(0, 0),
            ScrollingDirection = Enum.ScrollingDirection.Y
        },
        scrollingFrameRef = scrollingFrameRef,
        testId = var1.testId
    }, tbl3)
end

return TimeList
