-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:10:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local CoreGui = game:GetService("CoreGui")
local LocalizationService = game:GetService("LocalizationService")

local renderWithCoreScriptsStyleProvider = require(script.Parent.Common.renderWithCoreScriptsStyleProvider)

local Localization = require(CorePackages.Workspace.Packages.InExperienceLocales).Localization
local LocalizationProvider = require(CorePackages.Workspace.Packages.Localization).LocalizationProvider

local Roact = require(CorePackages.Packages.Roact)
local Rodux = require(CorePackages.Packages.Rodux)
local RoactRodux = require(CorePackages.Packages.RoactRodux)

local PublishAssetPromptApp = require(script.Components.PublishAssetPromptApp)
local Reducer = require(script.Reducer)
local ConnectAssetServiceEvents = require(script.ConnectAssetServiceEvents)

local tbl1 = {}
tbl1.__index = tbl1

function tbl1.new()
    local self = setmetatable({}, tbl1)
    local publishAssetPromptApp = Roact.createElement(PublishAssetPromptApp)

    self.store = Rodux.Store.new(Reducer, nil, { Rodux.thunkMiddleware })

    local element2 = Roact.createElement(RoactRodux.StoreProvider, {
        store = self.store
    }, {
        ThemeProvider = renderWithCoreScriptsStyleProvider({
            LocalizationProvider = Roact.createElement(
                LocalizationProvider,
                {
                    localization = Localization.new(LocalizationService.RobloxLocaleId)
                },
                { PublishAssetPromptApp = publishAssetPromptApp }
            )
        })
    })

    self.root = Roact.createElement("Folder", { Name = "PublishAssetPrompt" }, element2)

    self.element = Roact.mount(self.root, CoreGui, "PublishAssetPrompt")

    self.serviceConnections = ConnectAssetServiceEvents(self.store)

    return self
end

return tbl1.new()
