-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:51:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent

local React = require(scriptParentParentParentParent.React)

local _FlatList = require(script.Parent.Parent.FlatList)

local function useFocusNavigationScrolling(tbl1)
    local var1 = if tbl1.cellRendererKey then tbl1.cellRendererKey else "CellRendererView"
    local var2 = if tbl1.initialIndex then tbl1.initialIndex else 1
    local listRef = tbl1.listRef
    local onSelectedIndexChanged = tbl1.onSelectedIndexChanged
    local viewOffset = tbl1.viewOffset
    local animated = tbl1.animated == nil or tbl1.animated
    local var4 = React.useRef(var2)
    local data = tbl1.data

    local var5 = React.useCallback(function(tbl2)
        local offset = tbl2.index * tbl2.averageItemLength
        if listRef and listRef.current then
            listRef.current:scrollToOffset({ offset = offset })
            return
        end

        warn(
            "Animated scrolling failed, the ref to the ScrollView is nil.This could indicate that you are selecting focus before the ScrollView has mounted."
        )
    end, { listRef })

    return React.useCallback(function(arg1, _, _, arg2)
        if arg2 and arg2:IsDescendantOf(arg1) then
            local var6 = arg2:FindFirstAncestor(var1)
            if not (var6 and var6.LayoutOrder) then
                return nil
            end

            if var6.LayoutOrder == var4.current or var6.LayoutOrder > #data or var6.LayoutOrder < 1 then
                return nil
            end

            var4.current = var6.LayoutOrder

            if onSelectedIndexChanged then
                onSelectedIndexChanged(var4.current)
            end

            if not (listRef and listRef.current) then
                return nil
            end

            listRef.current:scrollToIndex({ index = var4.current, animated = animated, viewOffset = viewOffset })
        end

        return nil
    end, {
        listRef,
        var4,
        var1,
        onSelectedIndexChanged,
        animated,
        viewOffset,
        data
    }), var5
end

return useFocusNavigationScrolling
