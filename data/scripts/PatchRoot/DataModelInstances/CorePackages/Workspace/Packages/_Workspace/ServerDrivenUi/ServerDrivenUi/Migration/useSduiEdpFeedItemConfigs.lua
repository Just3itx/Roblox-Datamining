-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:40:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUi = script:FindFirstAncestor("ServerDrivenUi")
local ServerDrivenUiParent = ServerDrivenUi.Parent
local React = require(ServerDrivenUiParent.React)

local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local SduiComponent = SduiCoreSystem.SduiComponent
local SduiErrors = SduiCoreSystem.SduiErrors
local _Signals = require(ServerDrivenUiParent.Signals)
local SignalsReact = require(ServerDrivenUiParent.SignalsReact)
local getSduiFeedStore = require(ServerDrivenUi.DataStore.getSduiFeedStore)

local _SduiFeedStoreTypes = require(ServerDrivenUi.DataStore.SduiFeedStoreTypes)

local function getLayoutOrder(layoutOrder: number?, num1: number, tbl1, itemKey: string, callback: (...any) -> (...any)): number -- Luacid: Inlined by compiler; 2 call sites recovered
    if not (layoutOrder and tbl1[layoutOrder]) then
        return layoutOrder or num1
    end

    callback({ layoutOrder = layoutOrder, itemKey = itemKey, existingComponent = tbl1[layoutOrder] })

    return num1
end

local function useSduiEdpFeedItemConfigs(tbl1)
    local var1 = React.useMemo(function()
        return function(arg1)
            if not tbl1.shouldInterleaveSdui then
                return {}
            end

            local sduiFeedStore = getSduiFeedStore(tbl1.storeKey)

            local result = ({})

            for _, value in not sduiFeedStore.getItemCollectionKeys and {} or sduiFeedStore.getItemCollectionKeys(arg1) do
                local itemCollection = sduiFeedStore.getItemCollection(value)
                if itemCollection then
                    result[value] = itemCollection(arg1)
                end
            end
            return result
        end
    end, { tbl1.storeKey, tbl1.shouldInterleaveSdui })
    local var2 = SignalsReact.useSignalState(var1)

    local var3 = React.useMemo(function()
        local result = ({})
        if not tbl1.shouldInterleaveSdui then
            return result
        end
        for value, value2 in tbl1.portraitLayoutConfig do
            result[value2] = value
        end
        return result
    end, { tbl1.portraitLayoutConfig, tbl1.shouldInterleaveSdui })

    local var4 = React.useMemo(function()
        local result = ({})
        if not tbl1.shouldInterleaveSdui then
            return result
        end
        for value, value2 in tbl1.landscapeLayoutConfig do
            result[value2] = value
        end
        return result
    end, { tbl1.landscapeLayoutConfig, tbl1.shouldInterleaveSdui })

    local var5 = React.useCallback(function(arg1, itemKey: string, num1: number)
        if not tbl1.shouldInterleaveSdui then
            return {}
        end
        local layoutOrder = arg1.sduiConfig and arg1.sduiConfig.props and arg1.sduiConfig.props.LayoutOrder

        local var5 = tbl1.defaultLayoutOrder + num1

        return {
            portrait = getLayoutOrder(layoutOrder, var5, var3, itemKey, tbl1.logLayoutConflictFn),
            landscape = getLayoutOrder(layoutOrder, var5, var4, itemKey, tbl1.logLayoutConflictFn)
        }
    end, {
        var4,
        var3,
        tbl1.defaultLayoutOrder,
        tbl1.logLayoutConflictFn,
        tbl1.shouldInterleaveSdui
    })

    return React.useMemo(function()
        if not tbl1.shouldInterleaveSdui then
            return {}
        end

        local result = ({})
        local num1 = 0
        for value, value2 in var2 do
            local var6 = var5(value2, value, num1)
            num1 += 1

            local sduiConfig = value2 and value2.sduiConfig or nil
            local str1 = `SduiEdpFeedItem-{tbl1.storeKey}-{value}`

            if sduiConfig == nil then
                tbl1.sduiContext.dependencies.logger.reportError(
                    SduiErrors.SduiErrorType.NilComponentConfig,
                    {
                        name = str1,
                        message = `Unable to render edp feed item for sdui. Feed store key: {tbl1.storeKey}, Collection key: {value}`
                    },
                    tbl1.sduiContext.appPage
                )
            else
                local tbl2 = {
                    portraitLayoutOrder = var6.portrait,
                    landscapeLayoutOrder = var6.landscape,
                    renderComponent = 0
                }

                function tbl2.renderComponent()
                    return React.createElement(SduiComponent, { debugName = str1, componentConfig = sduiConfig, sduiContext = tbl1.sduiContext })
                end

                result[value] = tbl2
            end
        end

        return result
    end, {
        var2,
        tbl1.storeKey,
        tbl1.sduiContext,
        var5,
        tbl1.shouldInterleaveSdui
    })
end

return useSduiEdpFeedItemConfigs
