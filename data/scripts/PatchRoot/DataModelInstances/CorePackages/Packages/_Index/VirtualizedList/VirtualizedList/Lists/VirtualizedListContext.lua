-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:51:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)
local SafeFlags = require(scriptParentParentParent.SafeFlags)
local Object = LuauPolyfill.Object

local var1 = SafeFlags.createGetFFlag("MemoizeVirtualizedListContext")()

local React = require(scriptParentParentParent.React)
local useMemo = React.useMemo
local useContext = React.useContext

local module = {}

local VirtualizedListContext = React.createContext(nil)
module.VirtualizedListContext = VirtualizedListContext

if _G.__DEV__ then
    VirtualizedListContext.displayName = "VirtualizedListContext"
end

function module.VirtualizedListContextResetter(tbl1)
    local children = tbl1.children
    return React.createElement(VirtualizedListContext.Provider, { value = nil }, children)
end

function module.VirtualizedListContextProvider(tbl1)
    local children = tbl1.children
    local value = tbl1.value

    local var2 = useMemo(function()
        return {
            cellKey = nil,
            getScrollMetrics = value.getScrollMetrics,
            horizontal = value.horizontal,
            getOutermostParentListRef = value.getOutermostParentListRef,
            getNestedChildState = value.getNestedChildState,
            registerAsNestedChild = value.registerAsNestedChild,
            unregisterAsNestedChild = value.unregisterAsNestedChild,
            debugInfo = {
                cellKey = value.debugInfo.cellKey,
                horizontal = value.debugInfo.horizontal,
                listKey = value.debugInfo.listKey,
                parent = value.debugInfo.parent
            }
        }
    end, {
        value.getScrollMetrics,
        value.horizontal,
        value.getOutermostParentListRef,
        value.getNestedChildState,
        value.registerAsNestedChild,
        value.unregisterAsNestedChild,
        value.debugInfo.cellKey,
        value.debugInfo.horizontal,
        value.debugInfo.listKey,
        value.debugInfo.parent
    })

    return React.createElement(VirtualizedListContext.Provider, { value = var2 }, children)
end

function module.VirtualizedListCellContextProvider(tbl1)
    local cellKey = tbl1.cellKey
    local children = tbl1.children
    local var2 = useContext(VirtualizedListContext)

    local var3 = if var1 then useMemo(function()
        if var2 == nil then
            return nil
        end

        return (Object.assign(table.clone(var2), { cellKey = cellKey }))
    end, { var2, cellKey }) else nil

    local createElement = React.createElement
    local provider = VirtualizedListContext.Provider
    local tbl2 = { value = 0 }
    if not var1 then
        if var2 == nil then
            var3 = nil
        else
            var3 = Object.assign(table.clone(var2), { cellKey = cellKey })
        end
    end

    tbl2.value = var3
    return createElement(provider, tbl2, children)
end
return module
