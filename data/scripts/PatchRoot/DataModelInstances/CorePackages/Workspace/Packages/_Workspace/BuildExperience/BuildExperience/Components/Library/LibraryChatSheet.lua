-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:51:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)
local RoactUtils = require(BuildExperienceParent.RoactUtils)
local Signals = require(BuildExperienceParent.Signals)
local SignalsReact = require(BuildExperienceParent.SignalsReact)
local ChatSheetView = require(BuildExperience.Components.ChatSheet.ChatSheetView)
local _useChatSheetViewModel = require(BuildExperience.Components.ChatSheet.useChatSheetViewModel)
local GetLibraryStore = require(BuildExperience.Stores.GetLibraryStore)
local LibraryChatSheetOverlay = require(script.Parent.LibraryChatSheetOverlay)
local useLibraryChatSheetViewModel = require(script.Parent.useLibraryChatSheetViewModel)

local tokenOverrides = { ["Color.Common.Backdrop"] = "Color.None" }

local function onBoundsChanged(num1: number?, num2: number?)
    local libraryStore = GetLibraryStore()
    libraryStore.setWorldChatTop(num1)
    libraryStore.setWorldChatLeft(num2)
end

local computed = Signals.createComputed(function(arg1)
    local var1 = GetLibraryStore().getWorldViewportRect(arg1)
    return if var1 == nil then nil else var1.Min.Y
end)

local function ViewportTopOverlay(arg1)
    local top = SignalsReact.useSignalState(computed)
    local var2 = table.clone(arg1)
    var2.top = top
    return React.createElement(LibraryChatSheetOverlay, var2)
end

local function LibraryChatSheet(arg1)
    local var1 = RoactUtils.Hooks.useSelectedTheme()
    local var2 = Foundation.Hooks.useOverlay()
    local var3 = if var2 == nil then nil else var2:FindFirstAncestorWhichIsA("ScreenGui")
    local var4 = useLibraryChatSheetViewModel(arg1)
    local createElement = React.createElement
    local foundationProvider = Foundation.FoundationProvider
    local tbl2 = {
        colorMode = if var1 == "light" then Foundation.Enums.ColorMode.Light else Foundation.Enums.ColorMode.Dark,
        overlayGui = {
            DisplayOrder = if var3 == nil then nil else var3.DisplayOrder
        },
        tokenOverrides = tokenOverrides
    }

    return createElement(foundationProvider, tbl2, {
        Overlay = React.createElement(ViewportTopOverlay, {
            isOpen = var4.isOpen,
            snapPoints = var4.snapPoints,
            onBoundsChanged = onBoundsChanged,
            renderSheet = function(snapPoints, onFramesChanged, onSnapPointChanged)
                local var5 = table.clone(var4)
                var5.snapPoints = snapPoints
                var5.onFramesChanged = onFramesChanged
                var5.onSnapPointChanged = onSnapPointChanged
                return React.createElement(ChatSheetView, var5)
            end
        })
    })
end

return LibraryChatSheet
