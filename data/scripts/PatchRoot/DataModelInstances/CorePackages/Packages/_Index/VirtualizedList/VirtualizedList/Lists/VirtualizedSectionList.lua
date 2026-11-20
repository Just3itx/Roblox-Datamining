-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:51:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Boolean = LuauPolyfill.Boolean
local Object = LuauPolyfill.Object

local invariant = require(scriptParentParent.jsUtils.invariant)
local _ViewabilityHelper = require(script.Parent.ViewabilityHelper)

local keyExtractor = require(script.Parent.VirtualizeUtils).keyExtractor

local View = require(scriptParentParent.Components.View.View)
local VirtualizedList = require(script.Parent.VirtualizedList)

local React = require(scriptParentParentParent.React)

local ItemWithSeparator = nil

local var1 = React.PureComponent:extend("VirtualizedSectionList")

function var1.init(arg1)
    arg1._updateHighlightMap = {}
    arg1._updatePropsMap = {}
    arg1._listRef = nil
    function arg1._captureRef(_listRef)
        arg1._listRef = _listRef
    end

    function arg1._keyExtractor(_, num1: number)
        local var2 = arg1:_subExtractor(num1)
        if var2 then
            return var2.key
        end

        return tostring(num1)
    end

    function arg1._convertViewable(arg2)
        invariant(arg2.index ~= nil, "Received a broken ViewToken")
        local var2 = arg1:_subExtractor(arg2.index)
        if not var2 then
            return nil
        end
        local keyExtractor2 = var2.section.keyExtractor
        local var3 = if arg1.props.keyExtractor then arg1.props.keyExtractor else keyExtractor
        local key = if keyExtractor2 ~= nil then keyExtractor2(arg2.item, var2.index) else var3(arg2.item, if var2.index == nil then 1 else var2.index)
        return Object.assign({}, arg2, { index = var2.index, key = key, section = var2.section })
    end

    function arg1._onViewableItemsChanged(tbl1)
        local viewableItems = tbl1.viewableItems
        local changed = tbl1.changed
        local onViewableItemsChanged = arg1.props.onViewableItemsChanged
        if onViewableItemsChanged ~= nil then
            onViewableItemsChanged({
                viewableItems = Array.filter(Array.map(viewableItems, arg1._convertViewable, arg1), Boolean.toJSBoolean),
                changed = Array.filter(Array.map(changed, arg1._convertViewable, arg1), Boolean.toJSBoolean)
            })
        end
    end

    function arg1._renderItem(num1: number)
        return function(tbl1)
            local item = tbl1.item
            local index = tbl1.index
            local var2 = arg1:_subExtractor(index)
            if not var2 then
                return nil
            end
            local index2 = var2.index
            if index2 == nil then
                local section = var2.section
                if var2.header == true then
                    local renderSectionHeader = arg1.props.renderSectionHeader
                    if Boolean.toJSBoolean(renderSectionHeader) then
                        return (renderSectionHeader({ section = section }))
                    end

                    return nil
                end
                local renderSectionFooter = arg1.props.renderSectionFooter
                if Boolean.toJSBoolean(renderSectionFooter) then
                    return (renderSectionFooter({ section = section }))
                end

                return nil
            end

            local renderItem = var2.section.renderItem or arg1.props.renderItem
            local separatorComponent = arg1:_getSeparatorComponent(index, var2, num1)
            invariant(renderItem, "no renderItem!")
            return React.createElement(ItemWithSeparator, {
                SeparatorComponent = separatorComponent,
                LeadingSeparatorComponent = if index2 == 1 then arg1.props.SectionSeparatorComponent else nil,
                cellKey = var2.key,
                index = index2,
                item = item,
                leadingItem = var2.leadingItem,
                leadingSection = var2.leadingSection,
                prevCellKey = (arg1:_subExtractor(index - 1) or {}).key,
                setSelfHighlightCallback = arg1._setUpdateHighlightFor,
                setSelfUpdatePropsCallback = arg1._setUpdatePropsFor,
                updateHighlightFor = arg1._updateHighlightFor,
                updatePropsFor = arg1._updatePropsFor,
                renderItem = renderItem,
                section = var2.section,
                trailingItem = var2.trailingItem,
                trailingSection = var2.trailingSection,
                inverted = Boolean.toJSBoolean(arg1.props.inverted),
                horizontal = arg1.props.horizontal
            })
        end
    end

    function arg1._updatePropsFor(str1: string, arg2)
        local _updateProp = arg1._updatePropsMap[str1]
        if _updateProp ~= nil then
            _updateProp(arg2)
        end
    end

    function arg1._updateHighlightFor(str1: string, bool1: boolean)
        local var2 = arg1._updateHighlightMap[str1]
        if var2 ~= nil then
            var2(bool1)
        end
    end

    function arg1._setUpdateHighlightFor(str1: string, func1: ((...any) -> (...any))?)
        if func1 ~= nil then
            arg1._updateHighlightMap[str1] = func1
            return
        end
        arg1._updateHighlightMap[str1] = nil
    end

    function arg1._setUpdatePropsFor(str1: string, func1: ((...any) -> (...any))?)
        if func1 ~= nil then
            arg1._updatePropsMap[str1] = func1
            return
        end
        arg1._updatePropsMap[str1] = nil
    end
end

function var1.scrollToLocation(tbl1, tbl2)
    local itemIndex = tbl2.itemIndex
    local num1 = 1

    while num1 < tbl2.sectionIndex do
        itemIndex += tbl1.props.getItemCount(tbl1.props.sections[num1].data) + 2
        num1 += 1
    end
    local viewOffset = tbl2.viewOffset or 0
    if tbl1._listRef == nil then
        return
    end

    if tbl2.itemIndex > 1 and tbl1.props.stickySectionHeadersEnabled then
        viewOffset += tbl1._listRef.__getFrameMetricsApprox(itemIndex - tbl2.itemIndex).length
    end
    local var2 = Object.assign({}, tbl2, { viewOffset = viewOffset, index = itemIndex })
    tbl1._listRef:scrollToIndex(var2)
end

function var1.getListRef(arg1)
    return arg1._listRef
end

function var1.render(arg1)
    local _renderItem = arg1.props.renderItem
    local _sections = arg1.props.sections
    local var2 = Object.assign({}, arg1.props, {
        ItemSeparatorComponent = Object.None,
        SectionSeparatorComponent = Object.None,
        renderItem = Object.None,
        renderSectionFooter = Object.None,
        renderSectionHeader = Object.None,
        sections = Object.None,
        stickySectionHeadersEnabled = Object.None
    })

    local num1 = if arg1.props.ListHeaderComponent then 1 else 0

    local stickyHeaderIndices = arg1.props.stickySectionHeadersEnabled and {} or nil

    local getItemCount = 0
    for _, section in ipairs(arg1.props.sections) do
        if stickyHeaderIndices ~= nil then
            table.insert(stickyHeaderIndices, getItemCount + num1)
        end

        getItemCount = getItemCount + 2 + arg1.props.getItemCount(section.data)
    end
    local renderItem = arg1._renderItem(getItemCount)

    local createElement = React.createElement
    local var5 = VirtualizedList

    return createElement(
        var5,
        Object.assign({}, var2, {
            keyExtractor = arg1._keyExtractor,
            stickyHeaderIndices = stickyHeaderIndices,
            renderItem = renderItem,
            data = arg1.props.sections,
            getItem = function(arg2, arg3)
                return arg1:_getItem(arg1.props, arg2, arg3)
            end,
            getItemCount = function()
                return getItemCount
            end,
            onViewableItemsChanged = if arg1.props.onViewableItemsChanged then arg1._onViewableItemsChanged else nil,
            ref = arg1._captureRef
        })
    )
end

function var1._getItem(_, arg1, arg2, num1: number)
    if not arg2 then
        return nil
    end
    local num2 = num1 - 1
    local num3 = 1

    while num3 <= #arg2 do
        local var2 = arg2[num3]
        local data = var2.data
        local itemCount = arg1.getItemCount(data)
        if num2 == 0 or num2 == itemCount + 1 then
            return var2
        end

        if num2 <= itemCount then
            return arg1.getItem(data, num2)
        end
        num2 -= itemCount + 2

        num3 += 1
    end
    return nil
end

function var1._subExtractor(tbl1, num1: number)
    local props = tbl1.props
    local getItem = props.getItem
    local getItemCount = props.getItemCount
    local keyExtractor2 = props.keyExtractor
    local sections = props.sections
    local num2 = 1

    while num2 <= #sections do
        local section = sections[num2]
        local data = section.data
        local var2 = if Boolean.toJSBoolean(section.key) then tostring(section.key) else tostring(num2)
        local index = num1 - 1
        if not (getItemCount(data) + 1 < index) then
            if index == 0 then
                return {
                    section = section,
                    key = var2 .. ":header",
                    index = nil,
                    header = true,
                    trailingSection = sections[num2 + 1]
                }
            end

            if index == getItemCount(data) + 1 then
                return {
                    section = section,
                    key = var2 .. ":footer",
                    index = nil,
                    header = false,
                    trailingSection = sections[num2 + 1]
                }
            end
            return {
                section = section,
                key = var2 .. ":" .. tostring((section.keyExtractor or keyExtractor2 or keyExtractor)(getItem(data, index), index)),
                index = index,
                leadingItem = getItem(data, index - 1),
                leadingSection = sections[num2 - 1],
                trailingItem = getItem(data, index + 1),
                trailingSection = sections[num2 + 1]
            }
        end

        num1 = index - (getItemCount(data) + 1)

        num2 += 1
    end
    return nil
end

function var1._getSeparatorComponent(tbl1, num1: number, arg1, num2: number)
    arg1 = arg1 or tbl1:_subExtractor(num1)
    if not arg1 then
        return nil
    end

    local itemSeparatorComponent = Boolean.toJSBoolean(arg1.section.ItemSeparatorComponent) and arg1.section.ItemSeparatorComponent
        or tbl1.props.ItemSeparatorComponent
    local sectionSeparatorComponent = tbl1.props.SectionSeparatorComponent
    local bool1 = num1 == num2
    local bool2 = arg1.index == tbl1.props.getItemCount(arg1.section.data)

    if sectionSeparatorComponent and bool2 then
        return sectionSeparatorComponent
    end

    if itemSeparatorComponent and not (bool2 or bool1) then
        return itemSeparatorComponent
    end

    return nil
end

ItemWithSeparator = function(arg1)
    local leadingSeparatorComponent = arg1.LeadingSeparatorComponent
    local separatorComponent = arg1.SeparatorComponent
    local cellKey = arg1.cellKey
    local prevCellKey = arg1.prevCellKey
    local setSelfHighlightCallback = arg1.setSelfHighlightCallback
    local updateHighlightFor = arg1.updateHighlightFor
    local setSelfUpdatePropsCallback = arg1.setSelfUpdatePropsCallback
    local updatePropsFor = arg1.updatePropsFor
    local item = arg1.item
    local index = arg1.index
    local section = arg1.section
    local inverted = arg1.inverted

    local highlighted, var3 = React.useState(false)

    local var2, var5 = React.useState(false)

    local var6, var7 = React.useState({
        leadingItem = arg1.leadingItem,
        leadingSection = arg1.leadingSection,
        section = arg1.section,
        trailingItem = arg1.item,
        trailingSection = arg1.trailingSection,
        LayoutOrder = -1
    })

    local var8, var9 = React.useState({
        leadingItem = arg1.item,
        leadingSection = arg1.leadingSection,
        section = arg1.section,
        trailingItem = arg1.trailingItem,
        trailingSection = arg1.trailingSection,
        LayoutOrder = 1
    })

    React.useEffect(function()
        setSelfHighlightCallback(cellKey, var5)
        setSelfUpdatePropsCallback(cellKey, var9)
        return function()
            setSelfUpdatePropsCallback(cellKey, nil)
            setSelfHighlightCallback(cellKey, nil)
        end
    end, {
        cellKey,
        setSelfHighlightCallback,
        var9,
        setSelfUpdatePropsCallback
    })
    local var10 = arg1.renderItem({
        item = item,
        index = index,
        section = section,
        separators = {
            highlight = function()
                var3(true)
                var5(true)
                if prevCellKey ~= nil then
                    updateHighlightFor(prevCellKey, true)
                end
            end,
            unhighlight = function()
                var3(false)
                var5(false)
                if prevCellKey ~= nil then
                    updateHighlightFor(prevCellKey, false)
                end
            end,
            updateProps = function(str1: string, arg2)
                if str1 ~= "leading" then
                    if str1 == "trailing" and separatorComponent ~= nil then
                        var9(Object.assign({}, var8, arg2))
                    end

                    return
                end

                if leadingSeparatorComponent ~= nil then
                    var7(Object.assign({}, var6, arg2))
                    return
                end

                if prevCellKey ~= nil then
                    updatePropsFor(prevCellKey, Object.assign({}, var6, arg2))
                end
            end
        }
    })

    local element = not (leadingSeparatorComponent == nil)
        and React.createElement(leadingSeparatorComponent, Object.assign({ highlighted = highlighted }, var6))
    local element2 = not (separatorComponent == nil) and React.createElement(separatorComponent, Object.assign({ highlighted = var2 }, var8))

    if not (element or element2) then
        return var10
    end

    local createElement = React.createElement
    local var11 = View
    local tbl1 = {
        Size = if arg1.horizontal then UDim2.new(0, 0, 1, 0) else UDim2.new(1, 0, 0, 0),
        AutomaticSize = if arg1.horizontal then Enum.AutomaticSize.X else Enum.AutomaticSize.Y
    }
    local element3 = React.createElement("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        FillDirection = if arg1.horizontal then Enum.FillDirection.Horizontal else Enum.FillDirection.Vertical
    })
    local var12 = if inverted == false then element else element2

    if inverted == false then
        element = element2
    end

    return (createElement(var11, tbl1, element3, var12, var10, element))
end

return var1
