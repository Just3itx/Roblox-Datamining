-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T06:05:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DrawerParent = script:FindFirstAncestor("Drawer").Parent
local Signals = require(DrawerParent.Signals)
local SignalsReact = require(DrawerParent.SignalsReact)

local FFlagEnableDrawerAnimatingHook = require(DrawerParent.SharedFlags).FFlagEnableDrawerAnimatingHook

local function createDrawerVisibleStore()
    local getDrawerVisible, var2 = Signals.createSignal(false)
    local var3, setDrawerShouldMount = Signals.createSignal(false)

    local function useDrawerVisible()
        return SignalsReact.useSignalState(getDrawerVisible)
    end

    local function useDrawerShouldMount()
        return SignalsReact.useSignalState(var3)
    end

    local function setDrawerVisible(bool1: boolean)
        var2(bool1)
        if bool1 then
            setDrawerShouldMount(true)
        end
    end

    local var5 = nil
    local var6, func2

    if FFlagEnableDrawerAnimatingHook then
        local var7
        var7, var6 = Signals.createSignal(false)
        var5 = var7
        func2 = function()
            return SignalsReact.useSignalState(var5)
        end
    else
        var6 = nil
        func2 = nil
    end

    return {
        getDrawerVisible = getDrawerVisible,
        getDrawerAnimating = var5,
        setDrawerVisible = setDrawerVisible,
        setDrawerShouldMount = setDrawerShouldMount,
        setDrawerAnimating = var6,
        useDrawerVisible = useDrawerVisible,
        useDrawerShouldMount = useDrawerShouldMount,
        useDrawerAnimating = func2
    }
end

return createDrawerVisibleStore
