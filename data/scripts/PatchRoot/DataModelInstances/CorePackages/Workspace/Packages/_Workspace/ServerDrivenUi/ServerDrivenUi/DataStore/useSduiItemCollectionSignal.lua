-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:31:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUi = script:FindFirstAncestor("ServerDrivenUi")
local ServerDrivenUiParent = ServerDrivenUi.Parent
local _RobloxAppEnums = require(ServerDrivenUiParent.RobloxAppEnums)
local _Signals = require(ServerDrivenUiParent.Signals)
local SignalsReact = require(ServerDrivenUiParent.SignalsReact)
local React = require(ServerDrivenUiParent.React)
local getSduiFeedStore = require(ServerDrivenUi.DataStore.getSduiFeedStore)
local getItemCollectionKey = require(ServerDrivenUi.DataStore.getItemCollectionKey)
local _SduiFeedStoreTypes = require(ServerDrivenUi.DataStore.SduiFeedStoreTypes)

local FFlagLuaAppFixInlineSignalsReactPattern = require(ServerDrivenUiParent.SharedFlags).FFlagLuaAppFixInlineSignalsReactPattern

local function useSduiItemCollectionSignal(arg1, arg2, num1: number, str1: string?)
    local itemCollectionKey = getItemCollectionKey(arg2, num1)
    local var1 = str1 or arg1

    if not FFlagLuaAppFixInlineSignalsReactPattern then
        return (SignalsReact.useSignalState(function(arg3)
            return getSduiFeedStore(var1).getItemCollection(itemCollectionKey, true)(arg3)
        end))
    end

    local var2 = React.useCallback(function(arg3)
        return getSduiFeedStore(var1).getItemCollection(itemCollectionKey, true)(arg3)
    end, { itemCollectionKey, var1 })

    return (SignalsReact.useSignalState(var2))
end

return useSduiItemCollectionSignal
