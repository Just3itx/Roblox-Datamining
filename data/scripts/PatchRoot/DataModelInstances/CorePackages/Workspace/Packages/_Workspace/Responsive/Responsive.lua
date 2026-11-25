-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:11:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Responsive = require(script.Responsive)
local React = require(script.Parent.React)
local StandardBreakpoints = require(script.CommonConfigs.StandardBreakpoints)
local ContainerRef = require(script.Context.ContainerRef)
local FindFirstAncestorWithTag = require(script.FindFirstAncestorWithTag)
local useResponsiveImpl = require(script.Hooks.useResponsiveImpl)
local InputMode = require(script.InputMode)
local UIScaleOptions = require(script.UIScaleOptions)
local HardwareSafeAreaInsets = require(script.HardwareSafeAreaInsets)
local useDeviceInsets = require(script.Hooks.useDeviceInsets)
local GetInputModeStore = require(script.Stores.GetInputModeStore)

local useIsInFullScreen = require(script.Hooks.useIsInFullScreen)
local useIsSpatial = require(script.Hooks.useIsSpatial)
local useLastInput = require(script.Hooks.useLastInput)
local usePreferredInput = require(script.Hooks.usePreferredInput)

local getVirtualResolutionScale = require(script.getVirtualResolutionScale)
local getIsCompactTouch = require(script.getIsCompactTouch)

function breakpointCompare(defaultKey, defaultKey2): boolean
    local keyIndex = StandardBreakpoints.keyIndex
    return not (defaultKey == Responsive.DefaultKey
        or defaultKey2 == Responsive.DefaultKey
        or keyIndex[defaultKey] == nil
        or keyIndex[defaultKey2] == nil)
        and keyIndex[defaultKey] >= keyIndex[defaultKey2]
end

function ResponsiveProvider(arg1)
    local value = React.useRef(nil)
    return React.createElement(ContainerRef.Provider, { value = value }, arg1.children)
end

local module = {
    UIScaleOptions = UIScaleOptions,
    HardwareSafeAreaInsets = HardwareSafeAreaInsets,
    useDeviceInsets = useDeviceInsets,
    Keys = StandardBreakpoints.Enum,
    Input = InputMode.Enum,
    BreakpointConfig = StandardBreakpoints,
    DefaultKey = Responsive.DefaultKey,
    ContainerRef = ContainerRef,
    ResponsiveProvider = ResponsiveProvider
}

function module.ResponsiveContainerFrame(arg1)
    local ref = React.useContext(ContainerRef)
    return React.createElement("Frame", {
        ZIndex = if arg1 and arg1.ZIndex then arg1.ZIndex else -100,
        Size = if arg1 and arg1.Size then arg1.Size else UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Visible = false,
        ref = ref
    })
end

module.FindFirstAncestorWithTag = FindFirstAncestorWithTag
module.useBreakpointX = useResponsiveImpl
function module.useBreakpointXOrLarger(arg1)
    return useResponsiveImpl(function(arg2)
        return breakpointCompare(arg2, arg1)
    end, nil)
end

function module.useBreakpointXOrSmaller(arg1)
    return useResponsiveImpl(function(arg2)
        return breakpointCompare(arg1, arg2)
    end, nil)
end

function module.useBreakpointY()
    return useResponsiveImpl(nil, nil, "Y")
end

function module.useBreakpointYOrLarger(arg1)
    return useResponsiveImpl(function(arg2)
        return breakpointCompare(arg2, arg1)
    end, nil, "Y")
end

function module.useBreakpointYOrSmaller(arg1)
    return useResponsiveImpl(function(arg2)
        return breakpointCompare(arg1, arg2)
    end, nil, "Y")
end

function module.useOrientation()
    return useResponsiveImpl(nil, nil, "Orientation")
end

function module.useResponsive(arg1)
    return useResponsiveImpl(nil, arg1)
end
module.usePreferredInput = usePreferredInput
module.useLastInput = useLastInput
module.useIsInFullScreen = useIsInFullScreen
module.useIsSpatial = useIsSpatial
module.bindContainer = Responsive.bindContainer
module["jest.config"] = script["jest.config"]
module.getVirtualResolutionScale = getVirtualResolutionScale
module.GetInputModeStore = GetInputModeStore
module.getIsCompactTouch = getIsCompactTouch
return module
