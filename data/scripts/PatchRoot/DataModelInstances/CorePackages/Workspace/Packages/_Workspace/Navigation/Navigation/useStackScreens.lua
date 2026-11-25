-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:11:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local React = require(scriptParentParent.React)
local LuauPolyfill = require(scriptParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Object = LuauPolyfill.Object
local StackActions = require(scriptParentParent.RoactNavigation).StackActions

local FFlagLuaAppDerivedStackAndSwitchState = require(scriptParentParent.SharedFlags).FFlagLuaAppDerivedStackAndSwitchState

local ViewState = require(script.Parent.ViewState)

local _types = require(script.Parent.types)

local function RouteViewStatesReducer(tbl1, tbl2)
    local index = Array.findIndex(tbl1, function(arg1): boolean
        return arg1.descriptor.key == tbl2.key
    end)

    if tbl2.type == "SetCurrent" then
        for _, value in tbl2.navigationState.routes do
            tbl1 = RouteViewStatesReducer(tbl1, { type = "SetOpening", key = value.key, descriptor = tbl2.descriptors[value.key] })
        end

        for _, value in tbl1 do
            if tbl2.descriptors[value.descriptor.key] == nil then
                tbl1 = RouteViewStatesReducer(tbl1, { type = "SetClosing", key = value.descriptor.key })
            end
        end

        return tbl1
    end

    if tbl2.type == "SetOpening" then
        if index == -1 then
            tbl1 = table.clone(tbl1)
            table.insert(tbl1, { viewState = ViewState.Opening, descriptor = tbl2.descriptor })
            return tbl1
        end

        if tbl1[index].viewState == ViewState.Closing then
            tbl1 = table.clone(tbl1)
            tbl1[index] = Object.assign({}, tbl1[index], { viewState = ViewState.Opening, descriptor = tbl2.descriptor })
            return tbl1
        end

        if tbl1[index].descriptor ~= tbl2.descriptor then
            tbl1 = table.clone(tbl1)
            tbl1[index] = Object.assign({}, tbl1[index], { descriptor = tbl2.descriptor })
            return tbl1
        end
    elseif tbl2.type == "SetOpened" then
        if index ~= -1 and tbl1[index].viewState == ViewState.Opening then
            tbl1 = table.clone(tbl1)
            tbl1[index] = Object.assign({}, tbl1[index], { viewState = ViewState.Opened })
            return tbl1
        end
    elseif tbl2.type == "SetClosing" then
        if index ~= -1 and tbl1[index].viewState ~= ViewState.Closing then
            tbl1 = table.clone(tbl1)
            tbl1[index] = Object.assign({}, tbl1[index], { viewState = ViewState.Closing })
            return tbl1
        end
    elseif tbl2.type == "SetClosed" and index ~= -1 and tbl1[index].viewState == ViewState.Closing then
        tbl1 = table.clone(tbl1)
        table.remove(tbl1, index)
    end

    return tbl1
end

local function useStackScreens(tbl1)
    local navigation = tbl1.navigation
    local state = navigation.state
    local descriptors = tbl1.descriptors

    local var1, var2 = React.useReducer(RouteViewStatesReducer, {})

    if FFlagLuaAppDerivedStackAndSwitchState then
        React.useMemo(function()
            var2({ type = "SetCurrent", navigationState = state, descriptors = descriptors })
        end, { state, descriptors })
    else
        React.useLayoutEffect(function()
            var2({ type = "SetCurrent", navigationState = state, descriptors = descriptors })
        end, { state, descriptors })
    end

    local var3 = React.useCallback(function(toChildKey: string)
        if navigation.state.isTransitioning then
            navigation.dispatch(StackActions.completeTransition({ key = navigation.state.key, toChildKey = toChildKey }))
        end
    end, { navigation })

    local var4 = React.useCallback(function(tbl2)
        var2({ type = "SetOpened", key = tbl2.descriptor.key })

        var3(tbl2.descriptor.key)
    end, { var3 })

    local var5 = React.useCallback(function(tbl2)
        var2({ type = "SetClosed", key = tbl2.descriptor.key })
    end, {})

    return (React.useMemo(function()
        return Array.map(var1, function(tbl2)
            return Object.assign({}, tbl2, {
                setOpened = function()
                    var4(tbl2)
                end,
                setClosed = function()
                    var5(tbl2)
                end
            })
        end)
    end, { var1, var4, var5 }))
end

return useStackScreens
