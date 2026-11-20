-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:17:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local LocalizationService = game:GetService("LocalizationService")

local Roact = require(CorePackages.Packages.Roact)
local Rodux = require(CorePackages.Packages.Rodux)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local t = require(CorePackages.Packages.t)
local _UIBlox = require(CorePackages.Packages.UIBlox)

local Dependencies = require(script.Dependencies)
local Localization = Dependencies.Localization
local LocalizationProvider = require(Dependencies.LocalizationProvider)
local playerInterface = require(Dependencies.playerInterface)

local Constants = require(script.Resources.Constants)
local GlobalConfig = require(script.GlobalConfig)
local Reducers = require(script.Reducers)
local TrustAndSafetyApp = require(script.Components.TrustAndSafetyApp)
local TrustAndSafetyAppPolicy = require(script.TrustAndSafetyAppPolicy)

local _OpenReportDialog = require(script.Actions.OpenReportDialog)
local _OpenReportMenu = require(script.Actions.OpenReportMenu)
local BeginReportFlow = require(script.Actions.BeginReportFlow)
local SetVoiceReportingFlow = require(script.Actions.SetVoiceReportingFlow)
local SessionUtility = require(script.Utility.SessionUtility)

local FetchPlaceInfo = require(script.Thunks.FetchPlaceInfo)

local tbl1 = {
    getInstance = function(arg1)
        if not arg1._initialized then
            arg1:initialize()
            arg1._initialized = true
        end
        return arg1
    end,
    initialize = function(arg1)
        if GlobalConfig.propValidation then
            Roact.setGlobalConfig({ propValidation = true })
        end

        if GlobalConfig.elementTracing then
            Roact.setGlobalConfig({ elementTracing = true })
        end

        arg1.store = arg1:createStore()
        arg1.store:dispatch(FetchPlaceInfo(game.GameId))

        arg1.localization = arg1:createLocalization()

        arg1.root = Roact.createElement(RoactRodux.StoreProvider, {
            store = arg1.store
        }, {
            PolicyProvider = Roact.createElement(
                TrustAndSafetyAppPolicy.Provider,
                {
                    policy = { TrustAndSafetyAppPolicy.Mapper }
                },
                {
                    LocalizationProvider = Roact.createElement(
                        LocalizationProvider,
                        {
                            localization = arg1.localization
                        },
                        {
                            TrustAndSafety = Roact.createElement(TrustAndSafetyApp)
                        }
                    )
                }
            )
        })
        arg1.element = Roact.mount(arg1.root, CoreGui, "TrustAndSafety")
    end,
    createStore = function(_)
        local var1 = Reducers
        local tbl1 = { Rodux.thunkMiddleware }

        if GlobalConfig.logStore then
            table.insert(tbl1, Rodux.loggerMiddleware)
        end
        return Rodux.Store.new(var1, nil, tbl1)
    end,
    createLocalization = function(_)
        local robloxLocaleId = LocalizationService.RobloxLocaleId
        local localization = Localization.new(robloxLocaleId)

        LocalizationService:GetPropertyChangedSignal("RobloxLocaleId"):Connect(function()
            local robloxLocaleId2 = LocalizationService.RobloxLocaleId
            localization:SetLocale(robloxLocaleId2)
        end)

        return localization
    end,
    openReportDialog = function(arg1, arg2, arg3)
        arg1.store:dispatch(SetVoiceReportingFlow(true))
        arg1.store:dispatch(BeginReportFlow(arg2, arg3))
    end,
    openReportMenu = function(arg1)
        arg1.store:dispatch(SetVoiceReportingFlow(true))
        arg1.store:dispatch(BeginReportFlow())
    end
}
return {
    openReportDialogForPlayer = function(arg1, arg2)
        assert(playerInterface(arg1) and t.instanceIsA("Player")(arg1))
        SessionUtility.startAbuseReportSession(arg2)
        tbl1:getInstance():openReportDialog(Constants.ReportType.Player, arg1)
    end,
    openReportDialogForPlace = function(arg1)
        SessionUtility.startAbuseReportSession(arg1)
        tbl1:getInstance():openReportDialog(Constants.ReportType.Place)
    end,
    openReportMenu = function(arg1)
        SessionUtility.startAbuseReportSession(arg1)
        tbl1:getInstance():openReportMenu()
    end
}
