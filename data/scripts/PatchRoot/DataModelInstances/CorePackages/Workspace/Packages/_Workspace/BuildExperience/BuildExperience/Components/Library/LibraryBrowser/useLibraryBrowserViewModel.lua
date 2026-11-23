-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:50:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local React = require(BuildExperienceParent.React)
local SignalsReact = require(BuildExperienceParent.SignalsReact)

local _createBuildLibraryStore = require(BuildExperience.Stores.BuildLibrary.createBuildLibraryStore)
local LibraryCategories = require(script.Parent.Parent.LibraryCategories)
local _LibraryBrowserView = require(script.Parent.LibraryBrowserView)
local _LibraryTypes = require(script.Parent.Parent.LibraryTypes)
local useLibraryStrings = require(script.Parent.Parent.useLibraryStrings)
local useLibraryItems = require(script.Parent.Parent.useLibraryItems)
local getFolderPreview = require(script.Parent.Parent.getFolderPreview)
local _LibraryWorldCutoutView = require(script.Parent.Parent.LibraryWorldCutout.LibraryWorldCutoutView)

local function useCarousel(library, tbl1, str1: string, query: string)
    local items, hasMore, var3 = useLibraryItems(library, tbl1, str1, query, 6)
    return {
        items = items,
        hasMore = hasMore,
        onScrollChanged = React.useCallback(function(arg1)
            if arg1.AbsoluteWindowSize.X > 0
                and arg1.AbsoluteCanvasSize.X > 0
                and arg1.CanvasPosition.X + arg1.AbsoluteWindowSize.X >= arg1.AbsoluteCanvasSize.X - 192
            then
                var3()
            end
        end, { var3 })
    }
end

local function useLibraryBrowserViewModel(tbl1)
    local strings = useLibraryStrings()
    local var2 = SignalsReact.useSignalState(tbl1.library.getItems)
    local query = tbl1.query
    local tbl2 = {
        Model = useCarousel(tbl1.library, var2, "Model", query),
        Image = useCarousel(tbl1.library, var2, "Image", query),
        Sound = useCarousel(tbl1.library, var2, "Sound", query)
    }
    local tbl3 = {}
    for _, value in tbl2 do
        for _, item in value.items do
            table.insert(tbl3, item)
        end
    end
    local status = if tbl1.isReady then "Ready" else "Loading"
    local categories = {}
    for _, value in LibraryCategories.fromItems(tbl3, strings) do
        local var3 = tbl2[value.itemKind]
        local items = {}
        for _, item in var3.items do
            table.insert(items, {
                tileKey = `library-item-{item.id}`,
                itemId = item.id,
                itemKind = item.kind,
                isFolder = item.className == "Folder",
                folderPreview = getFolderPreview(item, var2),
                displayName = item.displayName,
                unavailableText = strings.modelUnavailable,
                thumbnail = item.image,
                model = item.model,
                onActivated = (tbl1.onOpenItem ~= nil or tbl1.onOpenCategory ~= nil) and function()
                    if item.className == "Folder" then
                        if tbl1.onOpenCategory ~= nil then
                            tbl1.onOpenCategory(item.kind, item.id, item.displayName, item.id)
                        end
                    elseif tbl1.onOpenItem ~= nil then
                        tbl1.onOpenItem(item.id, item.kind)
                    end
                end or nil
            })
        end

        local onOpenCategory = tbl1.onOpenCategory ~= nil and function()
            tbl1.onOpenCategory(value.itemKind, value.key, value.title)
        end or nil

        table.insert(categories, {
            categoryKey = value.key,
            itemKind = value.itemKind,
            title = value.title,
            items = items,
            status = status,
            hasMore = var3.hasMore,
            onScrollChanged = var3.onScrollChanged,
            onOpenCategory = onOpenCategory
        })
    end
    return {
        categories = categories,
        status = status,
        strings = strings,
        worldCutout = tbl1.worldCutout
    }
end

return useLibraryBrowserViewModel
