-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T01:30:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local GuiService = game:GetService("GuiService")
local Players = game:GetService("Players")

local PeopleReactView = script:FindFirstAncestor("PeopleReactView")
local PeopleReactViewParent = PeopleReactView.Parent

local PeopleService = require(PeopleReactViewParent.PeopleService)
local React = require(PeopleReactViewParent.React)
local SignalsReact = require(PeopleReactViewParent.SignalsReact)
local _Signals = require(PeopleReactViewParent.Signals)
local RobloxAppHooks = require(PeopleReactViewParent.RobloxAppHooks)
local RobloxAppEnums = require(PeopleReactViewParent.RobloxAppEnums)
local useLocalization = require(PeopleReactViewParent.Localization).Hooks.useLocalization
local ButtonVariant = require(PeopleReactViewParent.Foundation).Enums.ButtonVariant

local useSignalState = SignalsReact.useSignalState
local useDeviceOrientation = RobloxAppHooks.useDeviceOrientation

local Constants = require(PeopleReactView.Constants)
local service = PeopleService.getService("Constants")

local service2 = PeopleService.getService("Flags")
local GetFFlagNewPeopleButtonOrder = service2.GetFFlagNewPeopleButtonOrder

local engineFeature = game:GetEngineFeature("RbxAnalyticsServiceExposePlaySessionId")
local GetFFlagNewPeoplePageIcons = service2.GetFFlagNewPeoplePageIcons
local GetFFlagAddPeoplePageCardLayout = service2.GetFFlagAddPeoplePageCardLayout
local FFlagStandardizeSafetyIcon = require(PeopleReactViewParent.SharedFlags).FFlagStandardizeSafetyIcon
local FFlagPeopleListButtonOverflow = require(PeopleReactView.Flags.FFlagPeopleListButtonOverflow)

local function getPlaySessionId()
    if engineFeature then
        return RbxAnalyticsService:GetPlaySessionId()
    end
    return ""
end

local function usePersonButtonConfigs(userId: number?, bool1: boolean?)
    local service3 = PeopleService.getService("PeopleVoiceChatStore")
    local service4 = PeopleService.getService("PeopleReportAbuseMenu")
    local service5 = PeopleService.getService("PeopleAnalyticsManager")
    local service6 = PeopleService.getService("SettingsHubService")
    local service7 = PeopleService.getService("FriendStatusStore")
    local service8 = PeopleService.getService("PeopleBlockStatusStore")
    local service9 = PeopleService.getService("PeopleUtility")

    local var1 = useDeviceOrientation() == RobloxAppEnums.DeviceOrientationMode.Portrait
        or FFlagPeopleListButtonOverflow and bool1 == true

    local var2 = useLocalization({
        requestSent = Constants.PEOPLEPAGE.PERSON_BUTTONS.LOCALIZED_STRINGS.REQUEST_SENT,
        friend = Constants.PEOPLEPAGE.PERSON_BUTTONS.LOCALIZED_STRINGS.FRIEND,
        addFriend = Constants.PEOPLEPAGE.PERSON_BUTTONS.LOCALIZED_STRINGS.ADD_FRIEND,
        unblock = Constants.PEOPLEPAGE.PERSON_BUTTONS.LOCALIZED_STRINGS.UNBLOCK
    })

    local var3 = React.useMemo(function()
        return {
            isFriend = var2.friend,
            addPerson = var2.addFriend,
            requestSent = var2.requestSent
        }
    end, { var2 })

    local var4 = React.useMemo(function()
        if userId then
            return (Players:GetPlayerByUserId(userId))
        end

        return nil
    end, { userId })

    local var5 = React.useMemo(getPlaySessionId, {})

    local buttonState = service3.getPlayerMuteState(userId)
    local animatedIcon = service3.getPlayerAnimatedIcon(userId)
    local isGrayedOut = service3.getPlayerIsLocalMuted(userId)
    local shouldShow = useSignalState(service3.getPlayerShouldShowMuteButton(userId))
    local var6 = useSignalState(service7.getShouldShowFriendButton(userId, var4))

    local var7 = if GetFFlagAddPeoplePageCardLayout() then React.useMemo(function()
        return service7.getFriendStatus(userId)
    end, { userId }) else service7.getFriendStatus(userId)

    local var9 = if GetFFlagAddPeoplePageCardLayout() then React.useMemo(function()
        return service7.getFriendButtonText(userId, var3)
    end, { userId, var3 }) else service7.getFriendButtonText(userId, var3)

    local var10 = if GetFFlagAddPeoplePageCardLayout() then React.useMemo(function()
        return service7.getFriendButtonVariant(userId)
    end, { userId }) else service7.getFriendButtonVariant(userId)

    local var11 = React.useMemo(function()
        if userId then
            return (service8.getPlayerBlockStatus(userId))
        end

        return nil
    end, { userId })
    local var12 = useSignalState(var11)

    local var8 = React.useMemo(function()
        return service9.showPersonButtons(var4, userId)
    end, { userId })

    return (React.useMemo(function()
        local result = {}

        local tbl1 = {
            id = service.PERSON_BUTTONS.MUTE_PLAYER,
            animatedIcon = animatedIcon,
            buttonState = buttonState,
            shouldShow = function()
                return shouldShow
            end,
            onActivated = function(str1: string?)
                local var14 = service5
                local var15 = userId
                local var16 = isGrayedOut(false)
                if not GetFFlagAddPeoplePageCardLayout() then
                    str1 = nil
                end

                var14:trackToggleMutePlayer(var15, var16, str1)

                service3.togglePlayerMute(userId)
            end,
            layoutOrder = if GetFFlagNewPeopleButtonOrder() then 30 else 10,
            isGrayedOut = isGrayedOut,
            isBuilderIcon = false
        }

        if GetFFlagAddPeoplePageCardLayout() then
            result[service.PERSON_BUTTONS.MUTE_PLAYER] = tbl1
        else
            table.insert(result, tbl1)
        end

        local tbl2 = {
            id = service.PERSON_BUTTONS.BLOCK_PLAYER,
            text = if var12 then var2.unblock else nil,
            onIcon = if var12 then nil elseif GetFFlagNewPeoplePageIcons() then Constants.PEOPLEPAGE.PERSON_BUTTONS.ICON.BLOCK_NEW else Constants.PEOPLEPAGE.PERSON_BUTTONS.ICON.BLOCK_LEGACY,
            shouldShow = 0,
            onActivated = 0,
            buttonVariant = 0,
            layoutOrder = 0,
            isBuilderIcon = 0
        }

        function tbl2.shouldShow()
            return var8
        end
        function tbl2.onActivated(str1: string?)
            if not var4 then
                return
            end

            if var12 then
                local unblockPlayer = service8.unblockPlayer
                local var14 = var4
                if not GetFFlagAddPeoplePageCardLayout() then
                    str1 = nil
                end

                unblockPlayer(var14, str1)
                return
            end

            local blockPlayer = service8.blockPlayer
            local var14 = var4
            if not GetFFlagAddPeoplePageCardLayout() then
                str1 = nil
            end

            blockPlayer(var14, str1)
        end

        tbl2.buttonVariant = if var12 then ButtonVariant.Subtle else nil
        tbl2.layoutOrder = if GetFFlagNewPeopleButtonOrder() then 10 else 40
        tbl2.isBuilderIcon = GetFFlagNewPeoplePageIcons()

        if GetFFlagAddPeoplePageCardLayout() then
            result[service.PERSON_BUTTONS.BLOCK_PLAYER] = tbl2
        else
            table.insert(result, tbl2)
        end

        local tbl3 = {
            id = service.PERSON_BUTTONS.ADD_FRIEND,
            text = if var1 then nil else var9,
            onIcon = if var1 then if GetFFlagNewPeoplePageIcons() then Constants.PEOPLEPAGE.PERSON_BUTTONS.ICON.ADD_FRIEND_NEW else Constants.PEOPLEPAGE.PERSON_BUTTONS.ICON.ADD_FRIEND_LEGACY else nil,
            offIcon = if var1 then if GetFFlagNewPeoplePageIcons() then Constants.PEOPLEPAGE.PERSON_BUTTONS.ICON.FRIEND_NEW else Constants.PEOPLEPAGE.PERSON_BUTTONS.ICON.FRIEND_LEGACY else nil,
            buttonState = var7,
            buttonVariant = if var1 then nil else var10,
            shouldShow = 0,
            onActivated = 0,
            layoutOrder = 60,
            isDisabled = 0,
            isGrayedOut = 0,
            isBuilderIcon = 0
        }

        function tbl3.shouldShow()
            return var6
        end
        function tbl3.onActivated(str1: string?)
            local var14 = service5
            if not GetFFlagAddPeoplePageCardLayout() then
                str1 = nil
            end

            var14:trackRequestFriendship(str1)

            service7.sendFriendRequest(var4)
        end

        tbl3.isDisabled = service7.getIsFriendButtonDisabled(userId)
        tbl3.isGrayedOut = service7.getIsFriendButtonGrayedOut(userId)
        tbl3.isBuilderIcon = GetFFlagNewPeoplePageIcons()

        if GetFFlagAddPeoplePageCardLayout() then
            result[service.PERSON_BUTTONS.ADD_FRIEND] = tbl3
        else
            table.insert(result, tbl3)
        end

        local tbl4 = {
            id = service.PERSON_BUTTONS.REPORT_PLAYER,
            onIcon = if FFlagStandardizeSafetyIcon then Constants.PEOPLEPAGE.PERSON_BUTTONS.ICON.REPORT_PLAYER_FLAG elseif GetFFlagNewPeoplePageIcons() then Constants.PEOPLEPAGE.PERSON_BUTTONS.ICON.REPORT_PLAYER_NEW else Constants.PEOPLEPAGE.PERSON_BUTTONS.ICON.REPORT_PLAYER_LEGACY,
            shouldShow = 0,
            onActivated = 0,
            layoutOrder = 0,
            isBuilderIcon = 0
        }

        function tbl4.shouldShow()
            return var8
        end
        function tbl4.onActivated(str1: string?)
            if var4 then
                service4:ReportPlayer(var4, if GetFFlagAddPeoplePageCardLayout() then str1 else "MenuPlayerList")
            end
        end

        tbl4.layoutOrder = if GetFFlagNewPeopleButtonOrder() then 40 else 30
        tbl4.isBuilderIcon = GetFFlagNewPeoplePageIcons()

        if GetFFlagAddPeoplePageCardLayout() then
            result[service.PERSON_BUTTONS.REPORT_PLAYER] = tbl4
        else
            table.insert(result, tbl4)
        end

        local tbl5 = {
            id = service.PERSON_BUTTONS.INSPECT,
            onIcon = if GetFFlagNewPeoplePageIcons() then Constants.PEOPLEPAGE.PERSON_BUTTONS.ICON.INSPECT_NEW else Constants.PEOPLEPAGE.PERSON_BUTTONS.ICON.INSPECT_LEGACY,
            shouldShow = 0,
            onActivated = 0,
            layoutOrder = 20,
            isBuilderIcon = 0
        }

        function tbl5.shouldShow(): boolean
            return GuiService:GetInspectMenuEnabled()
        end
        function tbl5.onActivated(str1: string?)
            if not var4 then
                return
            end
            if GetFFlagAddPeoplePageCardLayout() then
                service5:trackInspectButton(game.GameId, var5, str1)
            else
                service5:trackInspectButton(game.GameId, var5)
            end

            GuiService:InspectPlayerFromUserIdWithCtx(var4.UserId, "escapeMenu")
            local var14 = service6.hubRef()
            if var14 then
                var14:SetVisibility(false)
            end
        end

        tbl5.isBuilderIcon = GetFFlagNewPeoplePageIcons()

        if GetFFlagAddPeoplePageCardLayout() then
            result[service.PERSON_BUTTONS.INSPECT] = tbl5
        else
            table.insert(result, tbl5)
        end

        return result
    end, {
        shouldShow,
        var6,
        var8,
        var12,
        var1,
        var9,
        var10,
        var7
    }))
end
return usePersonButtonConfigs
