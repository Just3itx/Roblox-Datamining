-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:51:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array

local Object = LuauPolyfill.Object

local tbl1 = { OS = "roblox" }
local deepDiffer = require(scriptParentParent.Utilities.differ.deepDiffer)
local React = require(scriptParentParentParent.React)

local VirtualizedList = require(scriptParentParent.Lists.VirtualizedList)

local View = require(scriptParentParent.Components.View.View)

local StyleSheet = require(scriptParentParent.StyleSheet.StyleSheet)
local invariant = require(scriptParentParent.jsUtils.invariant)

local ScrollView = scriptParentParent.Components.ScrollView

local _ScrollView = require(ScrollView.ScrollView)

local _ScrollViewNativeComponent = require(ScrollView.ScrollViewNativeComponent)

local _ViewabilityHelper = require(scriptParentParent.Lists.ViewabilityHelper)

local _VirtualizedList = require(scriptParentParent.Lists.VirtualizedList)

local keyExtractor = require(script.Parent.VirtualizeUtils).keyExtractor

local function removeClippedSubviewsOrDefault(bool1: boolean?): boolean? -- Luacid: unused: defined but never referenced
    return not (bool1 == nil) and bool1
end

local function numColumnsOrDefault(numColumns: number?): number -- Luacid: Inlined by compiler; 7 call sites recovered
    return if numColumns == nil then 1 else numColumns
end

local var1 = React.PureComponent:extend("FlatList")

function var1.init(arg1, _)
    arg1._virtualizedListPairs = {}
    function arg1._captureRef(_listRef)
        arg1._listRef = _listRef
    end

    function arg1._getItem(arg2, num1: number)
        local num2 = numColumnsOrDefault(arg1.props.numColumns)
        if not (num2 > 1) then
            return arg2[num1]
        end

        local result = {}
        for i = 1, num2 do
            local var2 = arg2[(num1 - 1) * num2 + i]
            if var2 ~= nil then
                table.insert(result, var2)
            end
        end
        return result
    end

    function arg1._getItemCount(arg2): number
        if arg2 == nil then
            return 0
        end

        local num1 = numColumnsOrDefault(arg1.props.numColumns)

        if not (num1 > 1) then
            return #arg2
        end

        return math.ceil(#arg2 / num1)
    end

    function arg1._keyExtractor(arg2, num1: number)
        local num2 = numColumnsOrDefault(arg1.props.numColumns)
        local var2 = if arg1.props.keyExtractor ~= nil then arg1.props.keyExtractor else keyExtractor

        if not (num2 > 1) then
            return var2(arg2, num1)
        end

        if Array.isArray(arg2) then
            return Array.join(Array.map(arg2, function(arg3, arg4)
                return var2(arg3, (num1 - 1) * num2 + arg4)
            end), ":")
        end

        invariant(
            Array.isArray(arg2),
            "FlatList: Encountered internal consistency error, expected each item to consist of an array with 1-%s columns; instead, received a single item.",
            num2
        )

        return nil
    end

    function arg1._renderer()
        local listItemComponent = arg1.props.ListItemComponent
        local renderItem = arg1.props.renderItem
        local columnWrapperStyle = arg1.props.columnWrapperStyle

        local num1 = numColumnsOrDefault(arg1.props.numColumns)

        local function renderer(arg2) -- Luacid: Inlined by compiler; 1 call site recovered
            if listItemComponent then
                return React.createElement(listItemComponent, arg2)
            elseif renderItem then
                return renderItem(arg2)
            end
            return nil
        end

        return {
            [if listItemComponent then "ListItemComponent" else "renderItem"] = function(arg2)
                if not (num1 > 1) then
                    return renderer(arg2)
                end

                local element = React.createElement("UIListLayout", {
                    key = if arg1.props.horizontal then "UIListVerticalLayout" else "UIListHorizontalLayout",
                    Name = if arg1.props.horizontal then "UIListVerticalLayout" else "UIListHorizontalLayout",
                    FillDirection = if arg1.props.horizontal then Enum.FillDirection.Vertical else Enum.FillDirection.Horizontal,
                    SortOrder = Enum.SortOrder.LayoutOrder
                })

                local item = arg2.item
                local index = arg2.index

                invariant(Array.isArray(item), "Expected array of items with numColumns > 1")
                return React.createElement(
                    View,
                    {
                        style = StyleSheet.compose(columnWrapperStyle)
                    },
                    Array.concat({ element }, Array.map(item, function(arg3, arg4)
                        local var2 = renderer({
                            item = Object.assign({}, arg3, { LayoutOrder = arg4 }),
                            index = (index - 1) * num1 + arg4,
                            separators = arg2.separators
                        })
                        if var2 ~= nil then
                            return (React.createElement(React.Fragment, { key = arg4 }, var2))
                        end

                        return nil
                    end))
                )
            end
        }
    end

    arg1:_checkProps(arg1.props)
    if arg1.props.viewabilityConfigCallbackPairs then
        arg1._virtualizedListPairs = Array.map(arg1.props.viewabilityConfigCallbackPairs, function(arg2)
            return {
                viewabilityConfig = arg2.viewabilityConfig,
                onViewableItemsChanged = arg1:_createOnViewableItemsChanged(arg2.onViewableItemsChanged)
            }
        end)

        return
    end

    if arg1.props.onViewableItemsChanged then
        table.insert(arg1._virtualizedListPairs, {
            viewabilityConfig = arg1.props.viewabilityConfig,
            onViewableItemsChanged = arg1:_createOnViewableItemsChanged(arg1.props.onViewableItemsChanged)
        })
    end
end

function var1.scrollToEnd(tbl2, tbl3)
    if tbl2._listRef then
        tbl2._listRef:scrollToEnd(tbl3)
    end
end

function var1.scrollToIndex(tbl2, tbl3)
    if tbl2._listRef then
        tbl2._listRef:scrollToIndex(tbl3)
    end
end

function var1.scrollToItem(tbl2, tbl3)
    if tbl2._listRef then
        tbl2._listRef:scrollToItem(tbl3)
    end
end

function var1.scrollToOffset(tbl2, tbl3)
    if tbl2._listRef then
        tbl2._listRef:scrollToOffset(tbl3)
    end
end

function var1.recordInteraction(arg1)
    if arg1._listRef then
        arg1._listRef:recordInteraction()
    end
end

function var1.flashScrollIndicators(arg1)
    if arg1._listRef then
        arg1._listRef:flashScrollIndicators()
    end
end

function var1.getScrollResponder(arg1)
    if arg1._listRef then
        return arg1._listRef:getScrollResponder()
    end
end

function var1.getNativeScrollRef(arg1)
    if arg1._listRef then
        return arg1._listRef:getScrollRef()
    end
end

function var1.getScrollableNode(arg1)
    if arg1._listRef then
        return arg1._listRef:getScrollableNode()
    end
end

function var1.setNativeProps(tbl2, tbl3)
    if tbl2._listRef then
        tbl2._listRef:setNativeProps(tbl3)
    end
end

function var1.componentDidUpdate(arg1, arg2)
    invariant(
        arg2.numColumns == arg1.props.numColumns,
        "Changing numColumns on the fly is not supported. Change the key prop on FlatList when changing the number of columns to force a fresh render of the component."
    )

    invariant(
        arg2.onViewableItemsChanged == arg1.props.onViewableItemsChanged,
        "Changing onViewableItemsChanged on the fly is not supported"
    )
    invariant(
        not deepDiffer(arg2.viewabilityConfig, arg1.props.viewabilityConfig),
        "Changing viewabilityConfig on the fly is not supported"
    )

    invariant(
        arg2.viewabilityConfigCallbackPairs == arg1.props.viewabilityConfigCallbackPairs,
        "Changing viewabilityConfigCallbackPairs on the fly is not supported"
    )

    arg1:_checkProps(arg1.props)
end

function var1._checkProps(arg1, arg2)
    local getItem = arg2.getItem
    local getItemCount = arg2.getItemCount
    local horizontal = arg2.horizontal
    local columnWrapperStyle = arg2.columnWrapperStyle
    local onViewableItemsChanged = arg2.onViewableItemsChanged
    local viewabilityConfigCallbackPairs = arg2.viewabilityConfigCallbackPairs
    local num1 = numColumnsOrDefault(arg1.props.numColumns)
    invariant(not (getItem or getItemCount), "FlatList does not support custom data formats.")
    if num1 > 1 then
        invariant(not horizontal, "numColumns does not support horizontal.")
    else
        invariant(not columnWrapperStyle, "columnWrapperStyle not supported for single column lists")
    end
    invariant(
        not (onViewableItemsChanged and viewabilityConfigCallbackPairs),
        "FlatList does not support setting both onViewableItemsChanged and viewabilityConfigCallbackPairs."
    )
end

function var1._pushMultiColumnViewable(arg1, arg2, arg3)
    local num1 = numColumnsOrDefault(arg1.props.numColumns)
    local var2 = if arg1.props.keyExtractor ~= nil then arg1.props.keyExtractor else keyExtractor

    Array.forEach(arg3.item, function(arg4, arg5)
        invariant(arg3.index ~= nil, "Missing index!")
        local index = (arg3.index - 1) * num1 + arg5
        table.insert(arg2, Object.assign({}, arg3, { item = arg4, key = var2(arg4, index), index = index }))
    end)
end

function var1._createOnViewableItemsChanged(tbl2, callback: ((...any) -> (...any))?)
    return function(tbl3)
        local num1 = numColumnsOrDefault(tbl2.props.numColumns)
        if callback == nil then
            return
        end

        if not (num1 > 1) then
            callback(tbl3)
            return
        end

        local changed = {}
        local viewableItems = {}
        Array.forEach(tbl3.viewableItems, function(arg1)
            return tbl2:_pushMultiColumnViewable(viewableItems, arg1)
        end)
        Array.forEach(tbl3.changed, function(arg1)
            return tbl2:_pushMultiColumnViewable(changed, arg1)
        end)

        callback({ viewableItems = viewableItems, changed = changed })
    end
end

function var1.render(arg1)
    local props = arg1.props

    local _numColumns = props.numColumns
    local _columnWrapperStyle = props.columnWrapperStyle
    local removeClippedSubviews = props.removeClippedSubviews
    local var2 = Object.assign(
        {},
        props,
        {
            numColumns = Object.None,
            columnWrapperStyle = Object.None,
            removeClippedSubviews = Object.None
        }
    )
    local createElement = React.createElement
    local var3 = VirtualizedList
    local assign = Object.assign
    local tbl2 = {}
    local tbl3 = {
        getItem = arg1._getItem,
        getItemCount = arg1._getItemCount,
        keyExtractor = arg1._keyExtractor,
        ref = arg1._captureRef,
        viewabilityConfigCallbackPairs = arg1._virtualizedListPairs,
        removeClippedSubviews = 0
    }

    if removeClippedSubviews == nil then
        removeClippedSubviews = tbl1.OS == "android"
    end

    tbl3.removeClippedSubviews = removeClippedSubviews
    return createElement(var3, assign(tbl2, var2, tbl3, arg1._renderer()))
end

return var1
