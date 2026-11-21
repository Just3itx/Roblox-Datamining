-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:41:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceProfilePictureEditor = script:FindFirstAncestor("AvatarExperienceProfilePictureEditor")
local AvatarExperienceProfilePictureEditorParent = AvatarExperienceProfilePictureEditor.Parent
local React = require(AvatarExperienceProfilePictureEditorParent.React)
local Cryo = require(AvatarExperienceProfilePictureEditorParent.Cryo)

local EditProfileImageAnalytics = require(AvatarExperienceProfilePictureEditor.Analytics.EditProfileImageAnalytics)

local AvatarEditorService = game:GetService("AvatarEditorService")

local function getEmoteLabel(tbl1): string -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = tbl1.Name or tbl1.name
    return if typeof(var1) == "string" and var1 ~= "" then var1 else ""
end

local function getCurrentPageItems(tbl1)
    local currentPageItems = {}
    for _, value in tbl1:GetCurrentPage() do
        table.insert(currentPageItems, { id = tostring(value.AssetId), label = getEmoteLabel(value) })
    end

    return currentPageItems
end

local function useOwnedEmotes()
    local emoteItems, var2 = React.useState({})
    local isLoading, var4 = React.useState(true)
    local hasError, var6 = React.useState(false)
    local hasMoreEmotes, var8 = React.useState(false)
    local isLoadingMoreEmotes, var10 = React.useState(false)
    local hasLoadMoreError, var12 = React.useState(false)
    local var13, var14 = React.useState(0)
    local var15 = React.useRef(nil)
    local var16 = React.useRef(false)

    local markEmoteOwned = React.useCallback(function(id: string, label: string?)
        var2(function(arg1)
            for _, value in arg1 do
                if value.id == id then
                    return arg1
                end
            end

            return Cryo.List.join({{ id = id, label = label or "" }}, arg1)
        end)
    end, {})

    local refetch = React.useCallback(function()
        var15.current = nil
        var16.current = false
        var4(true)
        var6(false)
        var8(false)
        var10(false)
        var12(false)
        var14(function(arg1): number
            return arg1 + 1
        end)
    end, {})

    local onMoreEmotes = React.useCallback(function()
        local current = var15.current
        if current == nil or current.IsFinished or var16.current then
            return
        end

        var16.current = true
        var10(true)
        var12(false)
        task.spawn(function()
            local success, result = pcall(function()
                current:AdvanceToNextPageAsync()
                return (getCurrentPageItems(current))
            end)

            var16.current = false
            var10(false)
            if not success then
                var12(true)

                return
            end

            var2(function(arg1)
                return Cryo.List.join(arg1, result)
            end)
            var8(not current.IsFinished)
        end)
    end, {})

    React.useEffect(function()
        local bool1 = false
        var15.current = nil
        var16.current = false
        var10(false)
        var12(false)

        task.spawn(function()
            local success, result = pcall(function()
                local inventoryPages = AvatarEditorService:GetInventoryAsync({ Enum.AvatarAssetType.EmoteAnimation })
                return {
                    items = getCurrentPageItems(inventoryPages),
                    pageObject = inventoryPages
                }
            end)

            if bool1 then
                return
            end

            if success then
                var15.current = result.pageObject
                var2(result.items)
                var8(not result.pageObject.IsFinished)
            else
                EditProfileImageAnalytics.logFetchFailure({ assetType = "emotes" })

                var6(true)
                var8(false)
            end
            var4(false)
        end)

        return function()
            bool1 = true
        end
    end, { var13 })

    return {
        emoteItems = emoteItems,
        isLoading = isLoading,
        hasError = hasError,
        refetch = refetch,
        onMoreEmotes = onMoreEmotes,
        hasMoreEmotes = hasMoreEmotes,
        isLoadingMoreEmotes = isLoadingMoreEmotes,
        hasLoadMoreError = hasLoadMoreError,
        markEmoteOwned = markEmoteOwned
    }
end

return useOwnedEmotes
