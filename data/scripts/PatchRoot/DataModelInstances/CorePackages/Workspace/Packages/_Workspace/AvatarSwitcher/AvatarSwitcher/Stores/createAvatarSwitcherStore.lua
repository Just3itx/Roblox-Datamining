-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:31:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarEditorService = game:GetService("AvatarEditorService")
local HttpRbxApiService = game:GetService("HttpRbxApiService")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local AvatarSwitcher = script:FindFirstAncestor("AvatarSwitcher")
local AvatarSwitcherParent = AvatarSwitcher.Parent

local Signals = require(AvatarSwitcherParent.Signals)
local createSignal = Signals.createSignal
local createComputed = Signals.createComputed
local Url = require(AvatarSwitcherParent.Http).Url
local Cryo = require(AvatarSwitcherParent.Cryo)
local InventoryItemAvailability = require(AvatarSwitcherParent.AvatarExperienceSlotBasedEditor).Enums.InventoryItemAvailability
local sendAXCounterV2 = require(AvatarSwitcherParent.AvatarExperienceAnalytics).sendAXCounterV2

local applyOutfit = require(AvatarSwitcher.Utils.applyOutfit)
local ExperienceAvatarSupportType = require(AvatarSwitcher.Enums.ExperienceAvatarSupportType)
local Constants = require(AvatarSwitcher.Constants)

local FFlagAvatarSwitcherUseAvatarInventoryEndpoint = require(AvatarSwitcherParent.AvatarExperienceFlags).FFlagAvatarSwitcherUseAvatarInventoryEndpoint

local FFlagAvatarSwitcherAccurateAvatarWarning = require(AvatarSwitcherParent.AvatarExperienceFlags).FFlagAvatarSwitcherAccurateAvatarWarning
local FFlagAvatarSwitcherCounters = require(AvatarSwitcherParent.AvatarExperienceFlags).FFlagAvatarSwitcherCounters

local FFlagAvatarSwitcherExpiredItemsWarning = require(AvatarSwitcherParent.AvatarExperienceFlags).FFlagAvatarSwitcherExpiredItemsWarning

local FFlagAXInventoryIncludeUnavailableItems = require(AvatarSwitcherParent.AvatarExperienceFlags).FFlagAXInventoryIncludeUnavailableItems
local bool1 = game:DefineFastFlag("AvatarSwitcherPcallApplyOutfit", false)

local _types = require(AvatarSwitcher.types)

local var1 = Url.AVATAR_URL .. "v1/avatar-inventory?"
local apiUrl = Url.AVATAR_URL .. "v2/avatar/experience/get-experience-avatar-support"

local function createAvatarSwitcherStore()
    local getOutfits, var3 = createSignal({})
    local var4, var5 = createSignal({})
    local getLastPageReached, var7 = createSignal(false)
    local getSelectedOutfitId, var9 = createSignal(nil)
    local getRespawnPromptShown, var11 = createSignal(false)
    local getIsSwitching, var13 = createSignal(false)

    local getExperienceAvatarSupportType, var15 = createSignal(nil)
    local getExperienceAvatarType, var17 = createSignal(nil)
    local getPendingAvatarName, var19 = createSignal(nil)

    local getIsEmpty = createComputed(function(arg1)
        return getLastPageReached(arg1) and #getOutfits(arg1) == 0
    end)

    local getSelectedOutfitDetails = createComputed(function(arg1)
        local var20 = getSelectedOutfitId(arg1)
        return if var20 == nil then nil else var4(arg1)[var20]
    end)

    local function toggleRespawnPrompt(bool2: boolean)
        var11(bool2)
    end

    local function fetchOutfitDetails(outfitId: number)
        local success, result = pcall(function()
            return AvatarEditorService:GetOutfitDetailsAsync(outfitId)
        end)
        if not success then
            warn(`Avatar Switcher: failed to fetch outfit details for outfitId {outfitId}.`, result)

            return
        end

        local tbl1

        if FFlagAvatarSwitcherAccurateAvatarWarning then
            tbl1 = {}
            if result.Assets then
                for _, asset in result.Assets do
                    table.insert(tbl1, asset.Id)
                end
            end
        else
            tbl1 = nil
        end

        local tbl2 = {
            id = result.Id,
            name = result.Name,
            rigType = if result.PlayerAvatarType == "R6" then Enum.HumanoidRigType.R6 else Enum.HumanoidRigType.R15,
            assetIds = 0
        }

        if not FFlagAvatarSwitcherAccurateAvatarWarning then
            tbl1 = nil
        end

        tbl2.assetIds = tbl1

        var5(function(arg1)
            return Cryo.Dictionary.join(arg1, { [outfitId] = tbl2 })
        end)
    end
    local function selectOutfit(outfitId: number?)
        var9(outfitId)

        if not FFlagAvatarSwitcherUseAvatarInventoryEndpoint and outfitId ~= nil and getSelectedOutfitDetails(false) == nil then
            fetchOutfitDetails(outfitId)
        end
    end

    local var20 = nil
    local bool2 = false
    local function fetchNextOutfitsPage_DEPRECATED()
        if bool2 or getLastPageReached(false) then
            return
        end
        bool2 = true

        if var20 then
            if var20.IsFinished then
                return
            end
            local success, result = pcall(function()
                var20:AdvanceToNextPageAsync()
            end)
            if not success then
                warn("Avatar Switcher: failed to fetch next page of user outfits.", result)
                var7(true)
            end
        else
            local success, result = pcall(function(): OutfitPages
                return AvatarEditorService:GetOutfitsAsync(Enum.OutfitSource.Created, Enum.OutfitType.Avatar)
            end)
            if success then
                var20 = result
            else
                warn("Avatar Switcher: failed to fetch first page of user outfits.", result)
                var7(true)
            end
        end

        if var20 then
            local currentPage = var20:GetCurrentPage()
            var3(function(arg1)
                local var21 = table.clone(arg1)
                for _, value in currentPage do
                    table.insert(var21, { id = value.Id, name = value.Name })
                end

                return var21
            end)
            if var20.IsFinished then
                var7(true)
            end
        end

        bool2 = false
    end

    local nextPageToken = nil
    local function fetchNextOutfitsPage()
        if bool2 or getLastPageReached(false) then
            return
        end
        bool2 = true

        local apiUrl2 = var1
            .. Url:makeQueryString({
                pageToken = nextPageToken,
                pageLimit = 25,
                sortOption = "recentAdded",
                ["itemCategories[0].itemType"] = "outfit",
                ["itemCategories[0].itemSubType"] = 3,
                includeUnavailableItems = if FFlagAXInventoryIncludeUnavailableItems then true else nil
            })
        local success, result = pcall(function()
            local asyncFullUrl = HttpRbxApiService:GetAsyncFullUrl(apiUrl2)
            return HttpService:JSONDecode(asyncFullUrl)
        end)

        if not success then
            warn("Avatar Switcher: failed to fetch user outfits.", result)
            if FFlagAvatarSwitcherCounters then
                sendAXCounterV2(Constants.Counters.OutfitFetchFailed)
            end
            var7(true)
            bool2 = false
            return
        end

        if result.nextPageToken then
            nextPageToken = result.nextPageToken
        else
            var7(true)
        end

        local var21 = result.avatarInventoryItems or {}
        local tbl1 = {}
        local tbl2 = ({})
        local var22 = getExperienceAvatarType(false)

        for _, value in var21 do
            if value.availabilityStatus == InventoryItemAvailability.PartiallyAvailableWithUnavailableSubitems then
                continue
            end

            local humanoidRigType = if value.outfitDetail and value.outfitDetail.playerAvatarType == "R6" then Enum.HumanoidRigType.R6 else Enum.HumanoidRigType.R15
            local bool3 = var22 == Enum.HumanoidRigType.R6 and humanoidRigType == Enum.HumanoidRigType.R15
            local bool4 = if FFlagAvatarSwitcherExpiredItemsWarning then value.availabilityStatus == InventoryItemAvailability.PartiallyAvailableWithExpiredSubitems else nil
            local tbl3

            if FFlagAvatarSwitcherAccurateAvatarWarning then
                tbl3 = {}
                if value.outfitDetail and value.outfitDetail.assets then
                    for _, asset in value.outfitDetail.assets do
                        table.insert(tbl3, asset.id)
                    end
                end
            else
                tbl3 = nil
            end

            local tbl4 = {
                id = value.itemId,
                name = value.itemName,
                hasWarning = 0
            }

            if FFlagAvatarSwitcherExpiredItemsWarning then
                bool3 = bool3 or bool4
            end

            tbl4.hasWarning = bool3
            table.insert(tbl1, tbl4)

            local itemId = value.itemId
            local tbl5 = {
                id = value.itemId,
                name = value.itemName,
                rigType = humanoidRigType,
                availabilityStatus = if FFlagAvatarSwitcherExpiredItemsWarning then value.availabilityStatus else nil,
                assetIds = 0
            }

            if not FFlagAvatarSwitcherAccurateAvatarWarning then
                tbl3 = nil
            end

            tbl5.assetIds = tbl3
            tbl2[itemId] = tbl5
        end

        var3(function(arg1)
            return Cryo.List.join(arg1, tbl1)
        end)
        var5(function(arg1)
            return Cryo.Dictionary.join(arg1, tbl2)
        end)

        bool2 = false
    end

    local function switchAvatar()
        local var21 = getSelectedOutfitDetails(false)
        if not var21 then
            return
        end

        var13(true)
        if FFlagAvatarSwitcherCounters then
            sendAXCounterV2(Constants.Counters.SwitchAvatar)
        end

        if bool1 then
            local success, result = pcall(function()
                applyOutfit(var21.id, var21.rigType)
            end)
            if not success then
                sendAXCounterV2(Constants.Counters.ApplyOutfitFailed, { errorMessage = tostring(result) })
            end
        else
            applyOutfit(var21.id, var21.rigType)
        end

        var19(var21.name)
        var13(false)
    end

    local function fetchExperienceAvatarSupportType()
        local success, result = pcall(function()
            local asyncFullUrl = HttpRbxApiService:GetAsyncFullUrl(apiUrl)
            return HttpService:JSONDecode(asyncFullUrl)
        end)

        if not success then
            var15(ExperienceAvatarSupportType.UnknownSupport)
            var17(nil)
            if FFlagAvatarSwitcherCounters then
                sendAXCounterV2(Constants.Counters.AvatarSupportTypeFetchFailed)
            end

            return
        end

        local experienceAvatarSupportType = result.experienceAvatarSupportType
        local var21 = if experienceAvatarSupportType == 0 then ExperienceAvatarSupportType.NoSupport elseif experienceAvatarSupportType == 2 then ExperienceAvatarSupportType.FullSupport else ExperienceAvatarSupportType.UnknownSupport
        var15(var21)

        local experienceAvatarType = result.experienceAvatarType
        local var22 = if experienceAvatarType == 1 then Enum.HumanoidRigType.R6 elseif experienceAvatarType == 3 then Enum.HumanoidRigType.R15 else nil
        var17(var22)
        if FFlagAvatarSwitcherCounters then
            sendAXCounterV2(
                Constants.Counters.AvatarSupportTypeFetched,
                {
                    supportType = tostring(experienceAvatarSupportType),
                    avatarType = tostring(experienceAvatarType)
                }
            )
        end
    end
    local function clearPendingAvatarName() -- Luacid: Inlined by compiler; 1 call site recovered
        var19(nil)
    end
    if Players.LocalPlayer then
        Players.LocalPlayer.CharacterAdded:Connect(function()
            clearPendingAvatarName()
        end)
    end

    local tbl1 = {
        getOutfits = getOutfits,
        getLastPageReached = getLastPageReached,
        getSelectedOutfitId = getSelectedOutfitId,
        getSelectedOutfitDetails = getSelectedOutfitDetails,
        getRespawnPromptShown = getRespawnPromptShown,
        getIsSwitching = getIsSwitching,
        getIsEmpty = getIsEmpty,
        getExperienceAvatarSupportType = getExperienceAvatarSupportType,
        getExperienceAvatarType = getExperienceAvatarType,
        getPendingAvatarName = getPendingAvatarName,
        toggleRespawnPrompt = toggleRespawnPrompt,
        selectOutfit = selectOutfit,
        fetchNextOutfitsPage = 0,
        switchAvatar = 0,
        fetchExperienceAvatarSupportType = 0,
        clearPendingAvatarName = 0
    }

    if FFlagAvatarSwitcherUseAvatarInventoryEndpoint then
        fetchNextOutfitsPage_DEPRECATED = fetchNextOutfitsPage
    end

    tbl1.fetchNextOutfitsPage = fetchNextOutfitsPage_DEPRECATED

    tbl1.switchAvatar = switchAvatar
    tbl1.fetchExperienceAvatarSupportType = fetchExperienceAvatarSupportType
    tbl1.clearPendingAvatarName = clearPendingAvatarName
    return tbl1
end

return createAvatarSwitcherStore
