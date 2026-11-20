-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:51:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local React = require(scriptParentParentParent.React)
local Object = require(scriptParentParentParent.LuauPolyfill).Object

local FlatList = require(script.Parent.FlatList)

local useFocusNavigationScrolling = require(script.Parent.Hooks).useFocusNavigationScrolling

local function AnimatedFlatList(arg1)
    local var1 = React.useRef(nil)
    local onSelectionChanged, var3 = useFocusNavigationScrolling({
        listRef = arg1.listRef or var1,
        onSelectedIndexChanged = arg1.onSelectedIndexChanged,
        initialIndex = arg1.initialScrollIndex,
        cellRendererKey = arg1.cellRendererKey,
        viewOffset = arg1.viewOffset,
        animated = arg1.animated,
        data = arg1.data
    })

    local assign = Object.assign
    local var4 = table.clone(arg1)
    local tbl1 = {
        viewOffset = Object.None,
        animated = Object.None,
        onSelectedIndexChanged = Object.None,
        ref = arg1.listRef or var1,
        onScrollToIndexFailed = 0,
        onSelectionChanged = 0
    }

    if arg1.getItemLayout then
        var3 = nil
    end

    tbl1.onScrollToIndexFailed = var3
    tbl1.onSelectionChanged = onSelectionChanged
    local var5 = assign(var4, tbl1)

    return React.createElement(FlatList, var5)
end

return AnimatedFlatList
