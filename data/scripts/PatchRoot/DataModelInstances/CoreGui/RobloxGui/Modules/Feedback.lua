-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:21:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local LocalizationService = game:GetService("LocalizationService")

local Roact = require(CorePackages.Packages.Roact)
local Rodux = require(CorePackages.Packages.Rodux)
local RoactRodux = require(CorePackages.Packages.RoactRodux)

local Localization = require(CorePackages.Workspace.Packages.InExperienceLocales).Localization
local LocalizationProvider = require(CorePackages.Workspace.Packages.Localization).LocalizationProvider

local GlobalConfig = require(script.GlobalConfig)
local Reducers = require(script.Reducers)
local FeedbackApp = require(script.Components.FeedbackApp)

return {
    initialize = function()
        if GlobalConfig.propValidation then
            Roact.setGlobalConfig({ propValidation = true })
        end

        if GlobalConfig.elementTracing then
            Roact.setGlobalConfig({ elementTracing = true })
        end

        local tbl1 = { Rodux.thunkMiddleware }

        if GlobalConfig.logStore then
            table.insert(tbl1, Rodux.loggerMiddleware)
        end
        local store = Rodux.Store.new(Reducers, nil, tbl1)

        local element = Roact.createElement(RoactRodux.StoreProvider, { store = store }, {
            LocalizationProvider = Roact.createElement(
                LocalizationProvider,
                {
                    localization = Localization.new(LocalizationService.RobloxLocaleId)
                },
                {
                    Feedback = Roact.createElement(FeedbackApp)
                }
            )
        })

        Roact.mount(element, CoreGui, "Feedback")
    end
}
