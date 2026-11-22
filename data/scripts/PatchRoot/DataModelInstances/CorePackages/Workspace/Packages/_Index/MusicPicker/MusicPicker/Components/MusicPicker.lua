-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:50:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MusicPicker = script:FindFirstAncestor("MusicPicker")
local MusicPickerParent = MusicPicker.Parent

local React = require(MusicPickerParent.React)

local MusicPickerContext = require(MusicPicker.Context.MusicPickerContext)
local MusicPickerView = require(MusicPicker.Components.MusicPickerView)
local useMusicPickerViewModel = require(MusicPicker.Hooks.useMusicPickerViewModel)
local useMusicPickerAnalytics = require(MusicPicker.Hooks.useMusicPickerAnalytics)
local _MusicPickerTypes = require(MusicPicker.Types.MusicPickerTypes)

local function MusicPickerBase(tbl1)
    local var1 = useMusicPickerViewModel({
        tabs = tbl1.tabs,
        onQueryChanged = tbl1.onQueryChanged,
        onTabChanged = tbl1.onTabChanged,
        initialQuery = tbl1.initialQuery
    })

    return React.createElement(MusicPickerView, {
        titleText = tbl1.titleText,
        searchPlaceholder = tbl1.searchPlaceholder,
        searchText = var1.searchText,
        mode = var1.mode,
        showTabs = tbl1.showTabs,
        tabs = tbl1.tabs,
        activeTabId = var1.activeTabId,
        searchContent = tbl1.searchContent,
        onSearchChanged = var1.onSearchChanged,
        onSubmitSearch = var1.onSubmitSearch,
        onTabSelected = var1.onTabSelected,
        onClose = tbl1.onClose,
        onSelect = tbl1.onSelect,
        safeAreaInsets = tbl1.safeAreaInsets
    })
end

local function MusicPicker2(tbl1)
    local itemsById = React.useMemo(function()
        local result = {}
        for _, tab in tbl1.tabs do
            for _, item in tab.content.items do
                result[item.id] = item
            end
        end
        for _, item in tbl1.searchContent.items do
            result[item.id] = item
        end
        return result
    end, { tbl1.tabs, tbl1.searchContent })

    local var2 = React.useContext(MusicPickerContext)
    local var3 = useMusicPickerAnalytics(
        {
            source = tbl1.source,
            previewingId = var2.previewingId,
            savedIds = var2.savedIds,
            itemsById = itemsById
        }
    )

    local value = React.useMemo(function()
        return {
            previewingId = var2.previewingId,
            togglePreview = function(previewingId: number)
                if var2.previewingId == previewingId then
                    var3(previewingId)
                end
                var2.togglePreview(previewingId)
            end,
            savedIds = var2.savedIds,
            toggleSaved = var2.toggleSaved,
            showSaveButton = var2.showSaveButton
        }
    end, { var2, var3 })

    return React.createElement(
        MusicPickerContext.Provider,
        { value = value },
        {
            Picker = React.createElement(MusicPickerBase, tbl1)
        }
    )
end
return MusicPicker2
