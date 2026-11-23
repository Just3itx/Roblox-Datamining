-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:51:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)
local Motion = require(BuildExperienceParent.Motion)

local Button = Foundation.Button
local IconButton = Foundation.IconButton
local SegmentedControl = Foundation.SegmentedControl
local FoundationText = Foundation.Text
local View = Foundation.View

local ButtonVariant = Foundation.Enums.ButtonVariant
local IconName = Foundation.Enums.IconName
local InputSize = Foundation.Enums.InputSize
local SearchBarContainer = require(BuildExperience.Components.SearchBar.SearchBarContainer)
local LibraryWorldBackdropView = require(script.Parent.LibraryWorldCutout.LibraryWorldBackdropView)
local _useLibraryWorldCutoutViewModel = require(script.Parent.LibraryWorldCutout.useLibraryWorldCutoutViewModel)
local releaseFocusWithin = require(BuildExperience.utils.releaseFocusWithin)
local useTypedQueryBinding = require(script.Parent.useTypedQueryBinding)
local useHardwareInsets = require(BuildExperience.Components.ChatSheet.useHardwareInsets)
local FFlagBuildExperienceLibrary = require(BuildExperienceParent.SharedFlags).FFlagBuildExperienceLibrary

local tbl1 = {
    Top = { UDim2.fromOffset(-10000, -10000), UDim2.new(1, 20000, 0, 10000) },
    Bottom = { UDim2.new(0, -10000, 1, 0), UDim2.new(1, 20000, 0, 10000) },
    Left = { UDim2.fromOffset(-10000, 0), UDim2.new(0, 10000, 1, 0) },
    Right = { UDim2.fromScale(1, 0), UDim2.new(0, 10000, 1, 0) }
}

local function LibraryExperienceView(tbl2)
    local var1 = Foundation.Hooks.useTokens()
    local reducedMotion = Foundation.Hooks.usePreferences().reducedMotion
    local bottom = useHardwareInsets().bottom
    local var2, var3 = React.useState(tbl2.isOpen)
    local var4, var5 = Motion.useMotion({ transparency = if tbl2.isOpen then 0 else 1 })
    React.useEffect(function()
        local bool1 = false
        if tbl2.isOpen then
            var3(true)
        end
        var5(
            Motion.createState({
                transparency = if tbl2.isOpen then 0 else 1
            }, {
                default = Motion.transition(
                    {
                        duration = if reducedMotion or not tbl2.showModeControl then 0 else 0.15,
                        easingStyle = Enum.EasingStyle.Quad
                    }
                )
            }),
            {
                onAnimationComplete = function(arg1)
                    if arg1 and not (bool1 or tbl2.isOpen) then
                        var3(false)
                    end
                end
            }
        )
        return function()
            bool1 = true
        end
    end, {
        tbl2.isOpen,
        tbl2.showModeControl,
        reducedMotion,
        var5
    })

    local ref = React.useRef(nil)
    React.useEffect(function()
        local current = ref.current
        if current == nil or tbl2.isWorldAvailable ~= false then
            return nil
        end
        local tbl3 = {
            [current] = current.Selectable
        }
        local tbl4 = ({})
        for _, descendant in current:GetDescendants() do
            if descendant:IsA("GuiButton") then
                tbl3[descendant] = descendant.Selectable
            elseif descendant:IsA("TextLabel") then
                tbl4[descendant] = descendant.TextTransparency
            end
        end
        for value in tbl3 do
            value.Selectable = false
        end
        for value, value2 in tbl4 do
            value.TextTransparency = 1 - (1 - value2) * 0.5
        end
        return function()
            for value, selectable in tbl3 do
                value.Selectable = selectable
            end
            for value, textTransparency in tbl4 do
                value.TextTransparency = textTransparency
            end
        end
    end, { tbl2.isWorldAvailable, tbl2.showModeControl })
    local worldCutout = tbl2.worldCutout
    local isTransitioning = not (worldCutout == nil) and worldCutout.isTransitioning
    local groupTransparency = if worldCutout ~= nil and isTransitioning then worldCutout.progress else var4.transparency
    local var8 = tbl2.isOpen or var2 or isTransitioning
    local backgroundStyle = groupTransparency:map(function(transparency: number)
        return {
            Color3 = var1.Color.Surface.Surface_0.Color3,
            Transparency = transparency
        }
    end)

    local var10, var11 = React.useState(nil)
    local isOpen = tbl2.isOpen

    if isOpen then
        if tbl2.onQueryChanged == nil then
            isOpen = false
        else
            isOpen = tbl2.query ~= nil
        end
    end

    local onBack = tbl2.onBack
    local key = tbl2.title or tbl2.assetLabel
    local shouldFocus = var10 == key
    local var13 = isOpen and (shouldFocus or tbl2.query ~= "")

    React.useEffect(function()
        var11(nil)
    end, { tbl2.title, tbl2.isOpen })
    local var6 = React.useRef(nil)
    local var7 = React.useRef(nil)

    local function func1(arg1): boolean
        local current = var7.current
        if arg1 == nil or current == nil then
            return false
        end
        local var16 = Vector2.new(arg1.Position.X, arg1.Position.Y) - current.AbsolutePosition

        return var16.X >= 0 and var16.Y >= 0 and var16.X <= current.AbsoluteSize.X and var16.Y <= current.AbsoluteSize.Y
    end
    local function func2() -- Luacid: Inlined by compiler; 4 call sites recovered
        releaseFocusWithin(var6.current)
    end
    local query, var17 = useTypedQueryBinding(tbl2.query)
    local function func3() -- Luacid: Inlined by compiler; 2 call sites recovered
        var17("")
        if tbl2.onSearchReset ~= nil then
            tbl2.onSearchReset()
            return
        end
        tbl2.onQueryChanged("")
    end

    local tbl3 = ({})
    for value, value2 in tbl1 do
        local createElement = React.createElement
        local var18 = View
        local tbl4 = {
            Position = value2[1],
            Size = value2[2],
            backgroundStyle = backgroundStyle,
            testId = `Library.Experience.SafeAreaFill.{value}`
        }
        tbl3[value] = createElement(var18, tbl4)
    end

    local createElement = React.createElement
    local var18 = View
    local tbl4 = {
        Size = UDim2.new(1, 0, 1, bottom),
        tag = "col",
        backgroundStyle = { Transparency = 1 },
        testId = "Library.Experience"
    }
    local tbl5 = {
        SafeAreaFill = React.createElement("Folder", nil, tbl3),
        Header = 0,
        ModeRow = 0,
        Content = 0
    }
    local createElement2 = React.createElement
    local var19 = View
    local tbl6 = {
        LayoutOrder = 1,
        backgroundStyle = backgroundStyle,
        onActivated = function() end,
        selection = { Selectable = false },
        stateLayer = {
            affordance = Foundation.Enums.StateLayerAffordance.None
        },
        tag = {
            ["row align-y-center gap-small size-full-0 auto-y padding-x-medium padding-top-xxlarge"] = true,
            ["padding-bottom-small"] = tbl2.showModeControl == true,
            ["padding-bottom-medium"] = tbl2.showModeControl ~= true
        },
        ref = var6,
        testId = "Library.Experience.Header"
    }
    local tbl7 = { Leading = 0, Title = 0, Search = 0, SelectAll = 0 }

    local createElement3 = React.createElement
    local var20 = View
    local tbl8 = {
        LayoutOrder = 1,
        backgroundStyle = if tbl2.isOpen then nil else var1.Color.OverMedia.OverMedia_0,
        tag = "auto-xy radius-circle",
        testId = "Library.Experience.LeadingChip"
    }

    local tbl9 = { Button = 0 }
    local createElement4 = React.createElement
    local var21 = IconButton
    local tbl10 = {
        icon = if onBack ~= nil or FFlagBuildExperienceLibrary then IconName.ChevronLargeLeft else IconName.X,
        isCircular = true,
        ref = var7,
        onActivated = 0,
        size = 0,
        variant = 0,
        testId = 0
    }

    function tbl10.onActivated()
        local var22 = onBack or tbl2.onLeave
        func2()
        var11(nil)
        if var13 and onBack == nil then
            func3()
            return
        end

        var22()
    end

    tbl10.size = InputSize.Large
    tbl10.variant = ButtonVariant.Utility
    tbl10.testId = if onBack == nil then "Library.Experience.Leave" else "Library.Experience.Back"
    tbl9.Button = createElement4(var21, tbl10)
    tbl7.Leading = createElement3(var20, tbl8, tbl9)
    local element

    if not var13 then
        element = React.createElement(FoundationText, {
            LayoutOrder = 2,
            Text = key,
            tag = "fill text-heading-small text-align-x-left text-truncate-end content-emphasis",
            testId = "Library.Experience.Title"
        })
    else
        element = React.createElement(View, {
            LayoutOrder = 2,
            tag = "grow auto-y",
            testId = "Library.Experience.Search"
        }, {
            Input = React.createElement(SearchBarContainer, {
                key = key,
                query = query,
                placeholder = tbl2.searchPlaceholder,
                setQuery = function(str1: string)
                    var17(str1)
                    tbl2.onQueryChanged(str1)
                end,
                clear = function()
                    func2()
                    func3()
                end,
                onDismiss = function()
                    func2()
                    var11(nil)
                end,
                onFocusLost = function(arg1)
                    if query:getValue() == "" and not func1(arg1) then
                        var11(nil)
                    end
                end,
                shouldFocus = shouldFocus
            })
        })
    end

    tbl7.Title = element

    tbl7.Search = if isOpen and not var13 then React.createElement(IconButton, {
        LayoutOrder = 3,
        icon = IconName.MagnifyingGlass,
        onActivated = function()
            var11(key)
        end,
        size = InputSize.Large,
        variant = ButtonVariant.Utility,
        testId = "Library.Experience.Search.Action"
    }) else nil

    tbl7.SelectAll = if tbl2.isOpen and tbl2.onSelectAll ~= nil and tbl2.selectAllLabel ~= nil then React.createElement(
        Button,
        {
            LayoutOrder = 4,
            text = tbl2.selectAllLabel,
            onActivated = function()
                func2()
                tbl2.onSelectAll()
            end,
            size = InputSize.Medium,
            variant = ButtonVariant.Utility,
            testId = "Library.Experience.SelectAll"
        }
    ) else nil

    tbl5.Header = createElement2(var19, tbl6, tbl7)
    local element2

    if tbl2.showModeControl then
        element2 = React.createElement(View, {
            LayoutOrder = 2,
            backgroundStyle = backgroundStyle,
            tag = "row align-x-center size-full-0 auto-y padding-x-medium padding-bottom-medium",
            testId = "Library.Experience.ModeRow"
        }, {
            Control = React.createElement(SegmentedControl, {
                isCircular = true,
                segments = {
                    {
                        id = "Library",
                        text = tbl2.assetLabel
                    },
                    {
                        id = "World",
                        text = tbl2.worldLabel,
                        ref = ref
                    }
                },
                value = if tbl2.isOpen then "Library" else "World",
                onActivated = function(arg1)
                    if arg1 == "Library" then
                        tbl2.onShowLibrary()
                    elseif arg1 == "World" then
                        tbl2.onShowWorld()
                    end
                end,
                size = InputSize.Medium,
                testId = "Library.Experience.Mode"
            })
        })
    else
        element2 = nil
    end

    tbl5.ModeRow = element2

    local createElement5 = React.createElement
    local var22 = View
    local tbl11 = {
        LayoutOrder = 3,
        ref = if worldCutout == nil then nil else worldCutout.onContentRectChanged,
        onAbsolutePositionChanged = if worldCutout == nil then nil else worldCutout.onContentRectChanged,
        onAbsoluteSizeChanged = if worldCutout == nil then nil else worldCutout.onContentRectChanged,
        tag = "fill size-full-0 clip",
        testId = "Library.Experience.Content"
    }

    local tbl12 = { Backdrop = 0, Body = 0, WorldViewport = 0 }
    local var23

    if worldCutout == nil then
        var23 = nil
    else
        local createElement6 = React.createElement
        local var24 = LibraryWorldBackdropView

        local tbl13 = {
            hole = if worldCutout.showHole then worldCutout.hole else nil,
            progress = worldCutout.progress,
            cornerRadius = var1.Radius.Medium,
            color = var1.Color.Surface.Surface_0.Color3,
            transparency = if isTransitioning then worldCutout.progress:map(function(): number
                return 0
            end) else var4.transparency,
            Visible = var8,
            ZIndex = 1
        }

        var23 = createElement6(var24, tbl13)
    end

    tbl12.Backdrop = var23

    tbl12.Body = React.createElement(View, {
        Visible = var8,
        GroupTransparency = groupTransparency,
        ZIndex = 2,
        backgroundStyle = worldCutout ~= nil and { Transparency = 1 } or nil,
        tag = {
            ["size-full clip"] = true,
            ["bg-surface-0"] = worldCutout == nil
        },
        testId = "Library.Experience.Body"
    }, tbl2.children)
    tbl12.WorldViewport = if tbl2.isOpen or isTransitioning or tbl2.onWorldViewportChanged == nil then nil else React.createElement(
        View,
        {
            ZIndex = 3,
            tag = "size-full",
            ref = tbl2.onWorldViewportChanged,
            onAbsolutePositionChanged = tbl2.onWorldViewportChanged,
            onAbsoluteSizeChanged = tbl2.onWorldViewportChanged,
            backgroundStyle = { Transparency = 1 },
            testId = "Library.Experience.WorldViewport"
        }
    )
    tbl5.Content = createElement5(var22, tbl11, tbl12)
    return createElement(var18, tbl4, tbl5)
end

return LibraryExperienceView
