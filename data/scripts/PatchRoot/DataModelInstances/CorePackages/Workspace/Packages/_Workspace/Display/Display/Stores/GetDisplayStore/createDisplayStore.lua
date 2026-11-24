-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T06:01:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")

local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local Signals = require(scriptParentParentParentParent.Signals)
local AppCommonLib = require(scriptParentParentParentParent.AppCommonLib)
local VRConstants = require(scriptParentParentParentParent.VrCompatibility.VRConstants)

local getGlobalGuiInset = require(scriptParentParentParent.getGlobalGuiInset)

local FIntLuaAppSmallScreenDesignWidth = require(scriptParentParentParent.Flags.FIntLuaAppSmallScreenDesignWidth)
local FFlagDisableLuaAppConsoleScale = require(scriptParentParentParent.Flags.FFlagDisableLuaAppConsoleScale)
local engineFeature = game:GetEngineFeature("EnableDisplaySize")
local bool1 = game:DefineFastFlag("FFlagLuaAppEnableWindowsHandheldScale", false)
local bool2 = game:DefineFastFlag("DebugLuaAppEnableScale", false)

local bool3 = bool2 or bool1 and engineFeature

local FFlagDebugForceConsoleSafeInsets = require(scriptParentParentParentParent.SharedFlags).FFlagDebugForceConsoleSafeInsets

local num1 = if FFlagDisableLuaAppConsoleScale then 1 else 1.5
local var1 = AppCommonLib.isTenFootInterface()

local function forceConsoleSafeInsets(vector2: Vector2)
    local messageBus = require(scriptParentParentParentParent.MessageBus).MessageBus
    local t = require(scriptParentParentParentParent.t)

    local tbl1 = {
        mid = messageBus.getMessageId("Screen", "safeAreaInsets"),
        validateParams = t.strictInterface({ left = t.number, top = t.number, right = t.number, bottom = t.number })
    }

    local tbl2 = {
        left = vector2.X * 0.05 / num1,
        top = vector2.Y * 0.05 / num1,
        right = vector2.X * 0.05 / num1,
        bottom = vector2.Y * 0.05 / num1
    }
    messageBus.publish(tbl1, tbl2)
end

return function()
    local var2, var3 = Signals.createSignal(workspace.CurrentCamera)
    local connection = workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
        var3(workspace.CurrentCamera)
    end)

    local getIsSpatial, var5 = Signals.createSignal(AppCommonLib.isSpatial())
    local var6 = AppCommonLib.connectToIsSpatialChanged(function(bool4: boolean)
        var5(bool4)
    end)

    local function calculateDeviceSafePadding()
        local rect = GuiService:GetInsetArea(Enum.ScreenInsets.None)
        local rect2 = GuiService:GetInsetArea(Enum.ScreenInsets.DeviceSafeInsets)
        return {
            left = rect2.Min.X - rect.Min.X,
            top = rect2.Min.Y - rect.Min.Y,
            right = rect.Max.X - rect2.Max.X,
            bottom = rect.Max.Y - rect2.Max.Y
        }
    end
    local getDeviceSafePadding, var8 = Signals.createSignal((calculateDeviceSafePadding()))

    local vector2 = Vector2.new(1, 1)
    local var9 = var2(false)
    if var9 then
        vector2 = var9.ViewportSize
    end
    local getViewportSize, var11 = Signals.createSignal(vector2)
    local connection2 = nil
    local effect = Signals.createEffect(function(arg1)
        local var12 = var2(arg1)
        if not var12 then
            return
        end

        if connection2 then
            connection2:Disconnect()
            connection2 = nil
        end
        if getIsSpatial(arg1) then
            var11(VRConstants.MainScreenResolution)
            return
        end
        connection2 = var12:GetPropertyChangedSignal("ViewportSize"):Connect(function()
            var11(var12.ViewportSize)
            var8((calculateDeviceSafePadding()))
            if FFlagDebugForceConsoleSafeInsets then
                forceConsoleSafeInsets(getViewportSize(arg1))
            end
        end)
    end)

    local viewportDisplaySize = if engineFeature then GuiService.ViewportDisplaySize else nil
    local getDisplaySize, var13 = Signals.createSignal(viewportDisplaySize)
    local connection3 = if engineFeature then GuiService:GetPropertyChangedSignal("ViewportDisplaySize"):Connect(function()
        var13(GuiService.ViewportDisplaySize)
    end) else nil

    local globalGuiInset = getGlobalGuiInset()
    local getGuiInset, setGuiInset = Signals.createSignal(globalGuiInset)
    local getTopBarHeight, setTopBarHeight = Signals.createSignal(globalGuiInset.top)

    local getUiScale = Signals.createComputed(function(arg1)
        local var18 = getDisplaySize(arg1)
        local var19 = getViewportSize(arg1)

        if var18 == nil or var19.X == 0 then
            return 1
        end

        local bool4 = var18 == Enum.DisplaySize.Small or bool2
        local x = var19.X
        local bool5 = FIntLuaAppSmallScreenDesignWidth < x

        return if bool3 and bool4 and bool5 then var19.X / FIntLuaAppSmallScreenDesignWidth else 1
    end)

    local getPlatformScale = Signals.createComputed(function(arg1)
        if var1 then
            return num1
        end
        return getUiScale(arg1)
    end)

    return {
        getViewportSize = getViewportSize,
        getDisplaySize = getDisplaySize,
        getGuiInset = getGuiInset,
        getTopBarHeight = getTopBarHeight,
        getUIScale = getUiScale,
        getPlatformScale = getPlatformScale,
        getDesignSpaceViewportWidth = Signals.createComputed(function(arg1)
            local var18 = getViewportSize(arg1)
            local var19 = getPlatformScale(arg1)
            return var18.X / (var19 and var19 ~= 0 and var19 or 1)
        end),
        getIsSpatial = getIsSpatial,
        setGuiInset = setGuiInset,
        setTopBarHeight = setTopBarHeight,
        getDeviceSafePadding = getDeviceSafePadding,
        cleanUp = function()
            if connection3 then
                connection3:Disconnect()
                connection3 = nil
            end
            if connection2 then
                connection2:Disconnect()
                connection2 = nil
            end
            if connection then
                connection:Disconnect()
                connection = nil
            end
            if var6 then
                var6:Disconnect()
                var6 = nil
            end
            if effect then
                effect()
            end
        end,
        forceConsoleSafeInsets = FFlagDebugForceConsoleSafeInsets and function()
            forceConsoleSafeInsets(getViewportSize())
        end or nil
    }
end
