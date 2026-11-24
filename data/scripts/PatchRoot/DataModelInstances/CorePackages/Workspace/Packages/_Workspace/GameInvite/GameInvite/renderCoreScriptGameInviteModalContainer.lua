-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T14:50:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local CoreGui = game:GetService("CoreGui")
local scriptParent = script.Parent
local Components = scriptParent.Components
local scriptParentParent = scriptParent.Parent

local React = require(scriptParentParent.React)
local RoactRodux = require(scriptParentParent.RoactRodux)
local ReactRoblox = require(scriptParentParent.ReactRoblox)
local Style = require(scriptParentParent.Style)
local UniversalAppPolicy = require(scriptParentParent.UniversalAppPolicy)
local ApolloProvider = require(scriptParentParent.ApolloClient).ApolloProvider
local GameInviteConstants = require(scriptParent.GameInviteConstants)
local GameInviteModal = require(Components.GameInviteModal)
local _gameInviteModalType = require(scriptParent.gameInviteModalType)

local AppFeaturePolicies = UniversalAppPolicy.AppFeaturePolicies
local RoactAppPolicy = UniversalAppPolicy.RoactAppPolicy
local StyleProviderWithDefaultTheme = Style.StyleProviderWithDefaultTheme
local Localization = require(scriptParentParent.InExperienceLocales).Localization
local LocalizationProvider = require(scriptParentParent.Localization).LocalizationProvider
local LocalizationService = game:GetService("LocalizationService")
local FoundationProvider = require(scriptParentParent.Foundation).FoundationProvider

game:DefineFastFlag("FixGameInviteModalLoadTimeIncrease", false)

local var1 = if game:GetFastFlag("FixGameInviteModalLoadTimeIncrease") then nil else require(scriptParentParent.RobloxApolloClient).initializeApolloClient({})

return function(client)
    local gameInviteStore = require(scriptParent.State.GameInviteStore)
    local gameInvite = Instance.new("Folder")
    gameInvite.Name = "GameInvite"
    gameInvite.Parent = CoreGui

    local createElement = React.createElement
    local var2 = LocalizationProvider
    local tbl1 = {
        localization = Localization.new(LocalizationService.RobloxLocaleId)
    }
    local createElement2 = React.createElement
    local storeProvider = RoactRodux.StoreProvider
    local tbl2 = { store = gameInviteStore }
    local tbl3 = { PolicyProvider = 0 }
    local createElement3 = React.createElement
    local provider = RoactAppPolicy.Provider
    local tbl4 = {
        policy = { AppFeaturePolicies }
    }

    local tbl5 = { StyleProvider = 0 }
    local createElement4 = React.createElement
    local var3 = StyleProviderWithDefaultTheme
    local tbl6 = {}
    local tbl7 = { ApolloClientProvider = 0 }
    local createElement5 = React.createElement
    local var4 = ApolloProvider
    local tbl8 = { client = 0 }
    if not game:GetFastFlag("FixGameInviteModalLoadTimeIncrease") then
        client = var1
    end

    tbl8.client = client
    tbl7.ApolloClientProvider = createElement5(var4, tbl8, {
        GameInviteModalWrapper = React.createElement(
            GameInviteModal,
            {
                displayOrder = -1,
                renderLocation = GameInviteConstants.RenderLocation.CoreScripts
            }
        )
    })
    tbl5.StyleProvider = createElement4(var3, tbl6, tbl7)
    tbl3.PolicyProvider = createElement3(provider, tbl4, tbl5)
    local element = createElement(var2, tbl1, { createElement2(storeProvider, tbl2, tbl3) })

    local root = ReactRoblox.createRoot(gameInvite)
    root:render(React.createElement(FoundationProvider, nil, { element }))

    return root
end
