-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:51:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local SignalsReact = require(BuildExperienceParent.SignalsReact)

local _LibraryCategories = require(script.Parent.Parent.LibraryCategories)
local _LibraryCategoryView = require(script.Parent.LibraryCategoryView)
local _createBuildLibraryStore = require(BuildExperience.Stores.BuildLibrary.createBuildLibraryStore)
local _LibraryTypes = require(script.Parent.Parent.LibraryTypes)
local useLibraryStrings = require(script.Parent.Parent.useLibraryStrings)
local useLibraryItems = require(script.Parent.Parent.useLibraryItems)
local getFolderPreview = require(script.Parent.Parent.getFolderPreview)

local function useLibraryCategoryViewModel(tbl1)
    local var1 = useLibraryStrings()
    local var2 = SignalsReact.useSignalState(tbl1.library.getItems)
    local var3, var4, onLoadMore = useLibraryItems(tbl1.library, var2, tbl1.itemKind, tbl1.query, 24, tbl1.categoryKey, tbl1.folderId)

    local items = {}
    for _, value in var3 do
        local tbl3 = {
            tileKey = `library-item-{value.id}`,
            itemId = value.id,
            itemKind = value.kind,
            isFolder = value.className == "Folder",
            folderPreview = getFolderPreview(value, var2),
            displayName = value.displayName,
            unavailableText = var1.modelUnavailable,
            thumbnail = value.image,
            model = value.model,
            onActivated = 0
        }

        function tbl3.onActivated()
            if value.className == "Folder" then
                if tbl1.onOpenCategory ~= nil then
                    tbl1.onOpenCategory(value.kind, value.id, value.displayName, value.id)
                end
            else
                tbl1.onOpenItem(value.id, value.kind)
            end
        end

        table.insert(items, tbl3)
    end

    return {
        items = items,
        status = if tbl1.isReady then "Ready" else "Loading",
        hasMore = tbl1.isReady and var4,
        strings = {
            empty = if tbl1.query ~= "" then var1.searchEmpty else var1.empty
        },
        onLoadMore = onLoadMore
    }
end

return useLibraryCategoryViewModel
