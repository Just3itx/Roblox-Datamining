-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:50:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AbuseReportMenu = script:FindFirstAncestor("AbuseReportMenu")
local CorePackages = game:GetService("CorePackages")
local Players = game:GetService("Players")
local RobloxGui = game:GetService("CoreGui").RobloxGui
local React = require(CorePackages.Packages.React)
local Cryo = require(CorePackages.Packages.Cryo)

local getMenuItemsFromConfigs = require(AbuseReportMenu.MenuConfigs.getMenuItemsFromConfigs)
local getMenuItemSizings = require(AbuseReportMenu.Utility.getMenuItemSizings)
local _Types = require(AbuseReportMenu.Components.Types)
local Constants = require(AbuseReportMenu.Components.Constants)
local ReportPlayerMenuItemConfigList = require(AbuseReportMenu.MenuConfigs.Players.ReportPlayerMenuItemConfigList)
local reportPersonUIStateReducer = require(AbuseReportMenu.Reducers.reportPersonUIStateReducer)
local handlePreselectedPlayer = require(AbuseReportMenu.Utility.handlePreselectedPlayer)

local default = require(RobloxGui.Modules.VoiceChat.VoiceChatServiceManager).default
local _VoiceUsersByProximity = require(RobloxGui.Modules.VoiceChat.VoiceUsersByProximity)
local Constants2 = require(CorePackages.Workspace.Packages.VoiceChatCore).Constants

local PlayerMenuActions = Constants.PlayerMenuActions

local bool1 = game:DefineFastFlag("PreselectedPlayerReportBugfix", false)

local function alphabeticalSort(arg1, arg2): boolean
    return arg1.Name:lower() < arg2.Name:lower()
end

local function ReportPersonMenuItemsContainer(tbl1)
    local menuItemSizings = getMenuItemSizings()
    local var1, var2 = React.useReducer(reportPersonUIStateReducer, Constants.InitPersonUIState)

    React.useEffect(function()
        if tbl1.utilityProps.isReportTabVisible ~= true then
            return
        end
        tbl1.utilityProps.analyticsDispatch({ type = Constants.AnalyticsActions.SwitchToPersonInitialSelections })

        if bool1 and (not default:UserVoiceEnabled() or default:GetVoiceJoinProgress() == Constants2.VOICE_JOIN_PROGRESS.Suspended) then
            if tbl1.utilityProps.preselectedPlayer then
                handlePreselectedPlayer(tbl1.utilityProps.preselectedPlayer, false, var2, tbl1.utilityProps.analyticsDispatch)
            end

            var2({ type = PlayerMenuActions.SetVoiceEnabled, enabled = false })
            return
        end

        default:asyncInit():andThen(function()
            if tbl1.utilityProps.preselectedPlayer then
                handlePreselectedPlayer(tbl1.utilityProps.preselectedPlayer, true, var2, tbl1.utilityProps.analyticsDispatch)
            end

            var2({ type = PlayerMenuActions.SetVoiceEnabled, enabled = true })
        end):catch(function()
            if tbl1.utilityProps.preselectedPlayer then
                handlePreselectedPlayer(tbl1.utilityProps.preselectedPlayer, false, var2, tbl1.utilityProps.analyticsDispatch)
            end
        end)
    end, { tbl1.utilityProps.isReportTabVisible })

    React.useEffect(function()
        local tbl2 = {}
        if var1.methodOfAbuse == Constants.AbuseMethods.VoiceChat then
            local recentUsersInteractionData = default:getRecentUsersInteractionData()

            for _, value in pairs(recentUsersInteractionData) do
                table.insert(tbl2, value.player)
            end

            table.sort(tbl2, alphabeticalSort)
        elseif var1.methodOfAbuse == Constants.AbuseMethods.TextChat
            or var1.methodOfAbuse == Constants.AbuseMethods.Other
            or var1.methodOfAbuse == Constants.AbuseMethods.Avatar
            or var1.methodOfAbuse == nil
        then
            tbl2 = Players:GetPlayers()
            table.sort(tbl2, alphabeticalSort)
        end

        local bool2 = false
        local bool3 = false

        local playerObjects = Cryo.List.filter(tbl2, function(localPlayer): boolean
            if var1.preselectedPlayer and localPlayer.UserId == var1.preselectedPlayer.UserId then
                bool2 = true
            end
            if var1.allegedAbuser and localPlayer.UserId == var1.allegedAbuserId then
                bool3 = true
            end

            return not (localPlayer == Players.LocalPlayer) and localPlayer.UserId > 0
        end)

        var2({ type = PlayerMenuActions.UpdatePlayerNameMap, playerObjects = playerObjects })
        if var1.preselectedPlayer and bool2 then
            var2({
                type = Constants.PlayerMenuActions.UpdateAbuser,
                abuseId = var1.preselectedPlayer.UserId,
                abuser = var1.preselectedPlayer
            })

            var2({ type = Constants.PlayerMenuActions.SetPreselectedPlayer, player = nil })
        elseif not bool3 then
            var2({ type = Constants.PlayerMenuActions.UpdateAbuser, abuseId = nil, abuser = nil })
        end
    end, {
        var1.methodOfAbuse,
        var1.isVoiceEnabled,
        tbl1.utilityProps.isReportTabVisible,
        var1.preselectedPlayer
    })

    local menuItemsFromConfigs = getMenuItemsFromConfigs(var1, var2, tbl1.utilityProps, ReportPlayerMenuItemConfigList, tbl1.isSmallPortraitViewport)

    local var3 = Cryo.Dictionary.join({
        Layout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, menuItemSizings.ItemPadding)
        })
    }, menuItemsFromConfigs)

    return React.createElement(
        "Frame",
        {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1
        },
        {
            MenuItems = React.createElement("Frame", { Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1 }, var3)
        }
    )
end

return ReportPersonMenuItemsContainer
