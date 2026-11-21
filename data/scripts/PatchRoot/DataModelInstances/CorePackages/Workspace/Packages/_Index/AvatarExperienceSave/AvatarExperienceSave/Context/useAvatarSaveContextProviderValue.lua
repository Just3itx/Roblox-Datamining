-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:30:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceSave = script:FindFirstAncestor("AvatarExperienceSave")

local AvatarExperienceSaveParent = AvatarExperienceSave.Parent

local React = require(AvatarExperienceSaveParent.React)
local AvatarExperienceCommon = require(AvatarExperienceSaveParent.AvatarExperienceCommon)
local Dash = require(AvatarExperienceSaveParent.Dash)
local Cryo = require(AvatarExperienceSaveParent.Cryo)
local Signals = require(AvatarExperienceSaveParent.Signals)
local ToastRodux = require(AvatarExperienceSaveParent.ToastRodux)
local tutils = require(AvatarExperienceSaveParent.tutils)
local Navigation = require(AvatarExperienceSaveParent.Navigation)
local RoactNavigation = require(AvatarExperienceSaveParent.RoactNavigation)
local AvatarExperienceNavigation = require(AvatarExperienceSaveParent.AvatarExperienceNavigation)
local AvatarExperienceFlags = require(AvatarExperienceSaveParent.AvatarExperienceFlags)
local NavigationRodux = require(AvatarExperienceSaveParent.NavigationRodux)
local RobloxAppEnums = require(AvatarExperienceSaveParent.RobloxAppEnums)
local Promise = require(AvatarExperienceSaveParent.Promise)
local LuauPolyfill = require(AvatarExperienceSaveParent.LuauPolyfill)
local setTimeout = LuauPolyfill.setTimeout
local clearTimeout = LuauPolyfill.clearTimeout

local useSelectorSignal = AvatarExperienceCommon.Hooks.useSelectorSignal
local useSignal = AvatarExperienceCommon.Hooks.useSignal
local useComputedSignal = AvatarExperienceCommon.Hooks.useComputedSignal
local useDispatch = require(AvatarExperienceSaveParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useNavigation = Navigation.useNavigation

local _AvatarSaveContext = require(script.Parent.AvatarSaveContext)
local SaveStatusEnum = require(AvatarExperienceSave.Enums.SaveStatusEnum)
local ToastType = ToastRodux.Enums.ToastType
local Actions = RoactNavigation.Actions
local AvatarScreen = AvatarExperienceNavigation.Enums.AvatarScreen
local AppPage = RobloxAppEnums.AppPage
local CustomGetStateForAction = AvatarExperienceNavigation.Enums.CustomGetStateForAction

local saveAvatar = require(AvatarExperienceSave.Requests.saveAvatar)
local saveProfileConfiguration = require(AvatarExperienceSave.Requests.saveProfileConfiguration)

local SetCurrentToastMessage = ToastRodux.Actions.SetCurrentToastMessage

local CharacterHistoryStateChangeButtonActivated = AvatarExperienceCommon.State.Actions.CharacterHistoryStateChangeButtonActivated
local RegisterCustomGetStateForAction = AvatarExperienceNavigation.Actions.RegisterCustomGetStateForAction

local shouldInsertNewHistoryEntry = require(AvatarExperienceSave.Utils.shouldInsertNewHistoryEntry)
local shouldReplaceLastHistoryEntry = require(AvatarExperienceSave.Utils.shouldReplaceLastHistoryEntry)
local getSaveDict = require(AvatarExperienceSave.Utils.getSaveDict)
local checkHasChangesToSave = require(AvatarExperienceSave.Utils.checkHasChangesToSave)
local getInvalidAssetIdsToAssetTypeIdMap = require(AvatarExperienceSave.Utils.getInvalidAssetIdsToAssetTypeIdMap)
local removeInvalidAssetsFromCharacterData = require(AvatarExperienceSave.Utils.removeInvalidAssetsFromCharacterData)
local checkCharacterDataHasTryOnItems = require(AvatarExperienceSave.Utils.checkCharacterDataHasTryOnItems)
local selectCharacterData = require(AvatarExperienceSave.Selectors.selectCharacterData)
local selectHasAvatarData = require(AvatarExperienceSave.Selectors.selectHasAvatarData)
local NavigateToRoute = NavigationRodux.Thunks.NavigateToRoute
local FFlagSignalsNavP3Dispatch = require(AvatarExperienceSaveParent.SharedFlags).FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(AvatarExperienceSaveParent.RobloxAppNavigation).NavigationCommands else nil
local buildHumanoidDescription = AvatarExperienceCommon.Utils.buildHumanoidDescription
local getGearAssetIdFromEquippedAssets = AvatarExperienceCommon.Utils.getGearAssetIdFromEquippedAssets

local getAssetIdToAssetTypeIdFromHumanoidDescription = AvatarExperienceCommon.Utils.getAssetIdToAssetTypeIdFromHumanoidDescription

local num1 = game:DefineFastInt("FIntAXMinSaveIntervalSeconds", 2)
local num2 = game:DefineFastInt("AXMaxUndoRedoHistory", 20)
local FFlagAXEnableManualSavingBlockingPrompt = AvatarExperienceFlags.FFlagAXEnableManualSavingBlockingPrompt
local FFlagAXBackgroundsPersistence = AvatarExperienceFlags.FFlagAXBackgroundsPersistence
local FFlagAXTimeoutAcknowledgementGating = AvatarExperienceFlags.FFlagAXTimeoutAcknowledgementGating
local FFlagAXMomentsLookTryOnDelayAutoSave = AvatarExperienceFlags.FFlagAXMomentsLookTryOnDelayAutoSave

local tbl1 = {
    toastMessage = "Feature.Avatar.Message.SaveThrottled",
    isLocalized = false,
    toastType = ToastType.InformationMessage
}
local tbl2 = {
    toastMessage = "Feature.Avatar.Message.SaveSuccessWithInvalidAssets",
    isLocalized = false,
    toastType = ToastType.SuccessConfirmation
}
local tbl3 = {
    toastMessage = "Feature.Avatar.Message.SaveSuccess",
    isLocalized = false,
    toastType = ToastType.SuccessConfirmation
}
local tbl4 = {
    toastMessage = "Feature.Avatar.Message.SaveFailure",
    isLocalized = false,
    toastType = ToastType.InformationMessage
}

local tbl5 = {
    Home = AppPage.Home,
    More = AppPage.More,
    Chat = AppPage.Chat,
    Games = AppPage.Games
}

local function buildHumanoidDescriptionForCharacterData(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return buildHumanoidDescription({
        currentAssets = arg1.equipped.EquippedAssets,
        avatarScales = arg1.equipped.AvatarScales,
        bodyColor3s = arg1.equipped.BodyColor3s,
        emotesSlotInfo = arg1.equipped.EquippedEmotes.slotInfo
    })
end

local function useAvatarSaveContextProviderValue()
    local var1 = useDispatch()
    local var2 = useNavigation()

    local var3 = useSelectorSignal(selectCharacterData, tutils.deepEqual)
    local var4 = useSelectorSignal(selectHasAvatarData)

    local getHistorySignal, var6 = useSignal({})
    local getCurrentHistoryIndexSignal, var8 = useSignal(0)

    local getLastSuccessfullySavedStateSignal, var10 = useSignal(nil)

    local var11, var12 = useSignal(nil)
    local var13, var14 = useSignal(0)
    local var15, var16 = useSignal(false)
    local var17 = nil
    local var18 = nil
    if FFlagAXMomentsLookTryOnDelayAutoSave then
        var17, var18 = useSignal(nil)
    end

    React.useEffect(function()
        return Signals.createEffect(function(arg1)
            local var19 = var4(arg1)
            local var20 = var3(arg1)
            local var21 = getHistorySignal(false)

            local var22 = var20.equipped.BodyPartRangeIds and tutils.fieldCount(var20.equipped.BodyPartRangeIds) > 0
            if not var19 or not var22 or #var21 ~= 0 then
                return
            end

            var6({ var20 })
            var8(1)

            var10(var20)
            var12(nil)
            var14(0)
        end)
    end, {})

    React.useEffect(function()
        return Signals.createEffect(function(arg1)
            local var19 = var3(arg1)
            local var20 = getHistorySignal(false)
            local var21 = getCurrentHistoryIndexSignal(false)
            local var22 = var20[var21] or var19
            if not (shouldInsertNewHistoryEntry(var22, var19) and #var20 > 0) then
                if shouldReplaceLastHistoryEntry(var22, var19) and #var20 > 0 then
                    local var23 = Dash.slice(var20)
                    var23[var21] = var19
                    var6(var23)
                    var8(var21)
                end
                return
            end

            local var23 = Dash.slice(var20, 1, var21)
            table.insert(var23, var19)
            local var24 = var21 + 1

            if #var23 > num2 then
                table.remove(var23, 1)
                var24 -= 1
            end
            var6(var23)
            var8(var24)
        end)
    end, {})

    local updateHistoryIndexAndGetCharacterData = React.useCallback(function(num3: number)
        local var19 = getHistorySignal(false)

        if num3 < 1 or #var19 < num3 then
            return nil
        end
        var8(num3)
        return var19[num3]
    end, { getHistorySignal, var8 })

    local var20 = React.useCallback(function(tbl6)
        local var20 = getHistorySignal(false)
        local var21 = getCurrentHistoryIndexSignal(false)
        local var22 = var20[var21]
        if not var22 then
            return nil
        end

        local var23, var24 = removeInvalidAssetsFromCharacterData(var22, tbl6)
        if not var24 then
            return nil
        end

        var20[var21] = var23
        var6(var20)
        return var23
    end, { getHistorySignal, var6, var8 })

    local timeoutStatusStore = AvatarExperienceCommon.Stores.getTimeoutStatusStore()

    local getSaveEligibilityStatusSignal = useComputedSignal(function(arg1)
        if timeoutStatusStore and timeoutStatusStore.getIsTimedOut(arg1) then
            return SaveStatusEnum.TimedOut
        end

        local var21 = getHistorySignal(arg1)
        local var22 = getCurrentHistoryIndexSignal(arg1)
        local var23 = getLastSuccessfullySavedStateSignal(arg1)
        local var24 = var11(arg1)
        local var25 = var21[var22]

        if not (var25 and var23) then
            return SaveStatusEnum.NoData
        end

        if var24 then
            return SaveStatusEnum.Saving
        end

        if var23 and not checkHasChangesToSave(var25, var23) then
            return SaveStatusEnum.AlreadySaved
        end

        if checkCharacterDataHasTryOnItems(var25) then
            return SaveStatusEnum.HasTryOns
        end

        return SaveStatusEnum.Eligible
    end)

    local var22 = React.useCallback(function(arg1, arg2, arg3, _, arg4)
        local success = SaveStatusEnum.Success
        local var22

        if arg4.Assets then
            local invalidAssetIdsToAssetTypeIdMap = getInvalidAssetIdsToAssetTypeIdMap(
                getAssetIdToAssetTypeIdFromHumanoidDescription(arg1),
                getAssetIdToAssetTypeIdFromHumanoidDescription(arg2)
            )

            var22 = var20(invalidAssetIdsToAssetTypeIdMap)

            arg3 = removeInvalidAssetsFromCharacterData(arg3, invalidAssetIdsToAssetTypeIdMap)
        else
            var22 = nil
        end

        var10(arg3)
        var12(nil)

        if var22 ~= nil then
            success = SaveStatusEnum.SuccessWithInvalidAssets
        end

        if success == SaveStatusEnum.Success then
            var1(SetCurrentToastMessage(tbl3))
        elseif success == SaveStatusEnum.SuccessWithInvalidAssets then
            var1(SetCurrentToastMessage(tbl2))
        end

        if var22 then
            var1(CharacterHistoryStateChangeButtonActivated(var22))
        end

        return success
    end, {
        getHistorySignal,
        getCurrentHistoryIndexSignal,
        var10,
        var12,
        var20
    })

    local var23 = React.useCallback(function(throttled)
        var12(nil)
        if throttled == SaveStatusEnum.Throttled then
            var1(SetCurrentToastMessage(tbl1))
            return
        end
        var1(SetCurrentToastMessage(tbl4))
    end, { var12, var1 })

    local trySaveAvatar = React.useCallback(function()
        return Promise.new(function(callback, callback2)
            if timeoutStatusStore and timeoutStatusStore.getIsTimedOut(false) then
                if FFlagAXTimeoutAcknowledgementGating and timeoutStatusStore.getStatus(false).requiresAcknowledgement then
                    AvatarExperienceCommon.Utils.showAvatarChangeFeatureRestriction()
                    return
                end
                var23(SaveStatusEnum.TimedOut)
                return
            end

            local var24 = getHistorySignal(false)
            local var25 = getCurrentHistoryIndexSignal(false)
            local var26 = getLastSuccessfullySavedStateSignal(false)
            local var27 = var24[var25]

            if not var27 or not var26 then
                return
            end

            local var28 = var13(false)
            if var28 > 0 and os.time() - var28 < num1 then
                var23(SaveStatusEnum.Throttled)
                return
            end

            var12(var27)
            var14(os.time())
            local humanoidDescriptionForCharacterData = buildHumanoidDescriptionForCharacterData(var27)

            local var29 = Enum.HumanoidRigType[var27.equipped.AvatarType]
            local saveDict = getSaveDict(var27, var26)
            local backgroundAssetId = if FFlagAXBackgroundsPersistence then var27.equipped.BackgroundAssetId else nil
            local bool1 = saveDict.Background == true and backgroundAssetId ~= nil
            local var30 = AvatarExperienceFlags.FFlagAXProfileConfigurationMultiFieldApply and {
                BackgroundAssetId = backgroundAssetId
            }
                or backgroundAssetId

            local bool2 = false
            if FFlagAXBackgroundsPersistence then
                saveDict = Cryo.Dictionary.join(saveDict, { Background = Cryo.None })
                for _, value in saveDict do
                    if value then
                        bool2 = true
                        break
                    end
                end
            end

            if bool1 and not bool2 then
                saveProfileConfiguration(var30):andThen(function()
                    var16(false)
                    var22(humanoidDescriptionForCharacterData, humanoidDescriptionForCharacterData, var27, var26, saveDict)

                    callback()
                end):catch(function()
                    var16(false)
                    var23(SaveStatusEnum.Failure)
                    callback2()
                end)
                return
            end

            local var31 = if bool1 then saveProfileConfiguration(var30) else nil
            local gearAssetIdFromEquippedAssets = getGearAssetIdFromEquippedAssets(var27.equipped.EquippedAssets)
            saveAvatar(humanoidDescriptionForCharacterData, var29, saveDict, gearAssetIdFromEquippedAssets):andThen(function(arg1)
                var16(false)

                local function finishSuccess(arg2) -- Luacid: Inlined by compiler; 3 call sites recovered
                    var22(humanoidDescriptionForCharacterData, arg1.humanoidDescriptionWithValidAssets, arg2, var26, saveDict)

                    callback()
                end

                if not var31 then
                    finishSuccess(var27)

                    return
                end

                var31:andThen(function()
                    finishSuccess(var27)
                end, function()
                    local join = Cryo.Dictionary.join
                    local var32 = var27
                    local tbl6 = {
                        equipped = Cryo.Dictionary.join(
                            var27.equipped,
                            {
                                BackgroundAssetId = if var26.equipped.BackgroundAssetId ~= nil then var26.equipped.BackgroundAssetId else Cryo.None
                            }
                        )
                    }
                    finishSuccess((join(var32, tbl6)))
                end)
            end):catch(
                function(_)
                    var16(false)

                    if timeoutStatusStore then
                        timeoutStatusStore.fetchStatus()
                    end

                    var23(SaveStatusEnum.Failure)
                    callback2()
                end
            )
        end)
    end, {
        timeoutStatusStore,
        getHistorySignal,
        getCurrentHistoryIndexSignal,
        var10,
        var12,
        var14,
        var20,
        var23,
        var16
    })

    if FFlagAXEnableManualSavingBlockingPrompt then
        local var25 = React.useCallback(function(name: string)
            return function()
                trySaveAvatar():finally(function()
                    if FFlagSignalsNavP3Dispatch then
                        NavigationCommands.to(NavigationCommands.fromLegacyPage({ name = name, skipSaveBlockingPrompt = true }))
                        return
                    end
                    var1(NavigateToRoute({{ name = name, skipSaveBlockingPrompt = true }}))
                end)
            end
        end, { trySaveAvatar, var1 })

        local var26 = React.useCallback(function(name: string)
            return function()
                task.spawn(function()
                    local var26 = getLastSuccessfullySavedStateSignal(false)

                    var1(CharacterHistoryStateChangeButtonActivated(var26))

                    task.wait()
                    if FFlagSignalsNavP3Dispatch then
                        NavigationCommands.to(NavigationCommands.fromLegacyPage({ name = name, skipSaveBlockingPrompt = true }))
                        return
                    end
                    var1(NavigateToRoute({{ name = name, skipSaveBlockingPrompt = true }}))
                end)
            end
        end, { var1, getLastSuccessfullySavedStateSignal })

        local var27 = React.useCallback(function(arg1, arg2)
            local routeName = (arg1 or {}).routeName
            local params = (arg1 or {}).params

            if arg1.type == Actions.Back
                and not arg1.immediate
                and arg2.routes[#arg2.routes]
                and arg2.routes[#arg2.routes].routeName == AvatarScreen.SaveAvatarOnLeaveAvatarExperiencePrompt
            then
                return true, nil
            end

            if arg1.type ~= Actions.Navigate
                or tbl5[routeName] == nil
                or params ~= nil and tutils.fieldCount(params) ~= 0
                or getSaveEligibilityStatusSignal(false) ~= SaveStatusEnum.Eligible
            then
                return false, nil
            end

            if arg2.routes[#arg2.routes]
                and arg2.routes[#arg2.routes].routeName == AvatarScreen.SaveAvatarOnLeaveAvatarExperiencePrompt
            then
                return true, nil
            end

            local routes = Cryo.List.join(arg2.routes, {{
                key = AvatarScreen.SaveAvatarOnLeaveAvatarExperiencePrompt,
                routeName = AvatarScreen.SaveAvatarOnLeaveAvatarExperiencePrompt,
                params = {
                    saveAndContinue = var25(routeName),
                    continueWithoutSave = var26(routeName)
                }
            }})

            return true, Cryo.Dictionary.join(arg2, { routes = routes, index = #routes })
        end, { getSaveEligibilityStatusSignal, var25, var26 })

        React.useEffect(function()
            var2.dispatch(RegisterCustomGetStateForAction(CustomGetStateForAction.HandlerId.BlockAXExitOnUnsavedChanges, var27))
        end, { var2, var27 })
    end

    local var25 = nil
    local var26 = nil
    if FFlagAXMomentsLookTryOnDelayAutoSave then
        local var27 = React.useRef(nil)
        var25 = var27

        local var28 = React.useCallback(function(num3: number?)
            if var27.current ~= nil then
                clearTimeout(var27.current)
                var27.current = nil
            end
            if num3 == nil then
                return
            end
            var27.current = setTimeout(function()
                var27.current = nil
                local var28 = getSaveEligibilityStatusSignal(false)

                if var28 == SaveStatusEnum.Eligible or var28 == SaveStatusEnum.HasTryOns then
                    trySaveAvatar()
                end
            end, num3)
        end, { trySaveAvatar, getSaveEligibilityStatusSignal })
        var26 = var28

        React.useEffect(function()
            return function()
                var28(nil)
            end
        end, {})
    end

    React.useEffect(function()
        return Signals.createEffect(function(arg1)
            local var27 = getHistorySignal(arg1)
            if not var27[#var27] or not var15(false) then
                return
            end

            local var28 = getSaveEligibilityStatusSignal(false)

            if var28 ~= SaveStatusEnum.Eligible and var28 ~= SaveStatusEnum.HasTryOns then
                return
            end

            if FFlagAXMomentsLookTryOnDelayAutoSave and var25 and var26 and var17 and var17(false) ~= nil then
                if var25.current == nil then
                    var26(var17(false))
                end
            else
                trySaveAvatar()
            end
        end)
    end, {})

    local useCallback = React.useCallback
    local function func1(num3: number?)
        if FFlagAXMomentsLookTryOnDelayAutoSave and var18 then
            var18(num3)
            if var25 and var25.current ~= nil and var26 then
                var26(num3)
            end
        end
        var16(true)
    end

    local var27 = if FFlagAXMomentsLookTryOnDelayAutoSave then var18 else nil
    local var28 = if FFlagAXMomentsLookTryOnDelayAutoSave then var26 else nil
    local autoSaveNextNewSaveData = useCallback(func1, { var16, var27, var28 })

    return React.useMemo(function()
        return {
            getHistorySignal = getHistorySignal,
            getCurrentHistoryIndexSignal = getCurrentHistoryIndexSignal,
            updateHistoryIndexAndGetCharacterData = updateHistoryIndexAndGetCharacterData,
            getLastSuccessfullySavedStateSignal = getLastSuccessfullySavedStateSignal,
            getSaveEligibilityStatusSignal = getSaveEligibilityStatusSignal,
            trySaveAvatar = trySaveAvatar,
            autoSaveNextNewSaveData = autoSaveNextNewSaveData
        }
    end, {
        getHistorySignal,
        getCurrentHistoryIndexSignal,
        updateHistoryIndexAndGetCharacterData,
        getLastSuccessfullySavedStateSignal,
        getSaveEligibilityStatusSignal,
        trySaveAvatar,
        autoSaveNextNewSaveData
    })
end

return useAvatarSaveContextProviderValue
