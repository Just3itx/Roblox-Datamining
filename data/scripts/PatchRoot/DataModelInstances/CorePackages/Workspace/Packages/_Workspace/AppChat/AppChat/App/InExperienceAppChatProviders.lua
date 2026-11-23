-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:01:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local LocalizationService = game:GetService("LocalizationService")

local InExperienceSquadContract = require(AppChat.Contracts).SquadContract.InExperienceSquadContract

local Contexts = require(AppChat.Contexts)
local UnreadMessagesProvider = Contexts.UnreadMessagesProvider
local ParentContainerProvider = Contexts.ParentContainer.ParentContainerProvider

local ApolloProvider = require(AppChatParent.ApolloClient).ApolloProvider

local Localization = require(AppChatParent.RobloxAppLocales).Localization
local LocalizationProvider = require(AppChatParent.Localization).LocalizationProvider
local React = require(AppChatParent.React)
local RoactUtils = require(AppChatParent.RoactUtils)
local RoactRodux = require(AppChatParent.RoactRodux)
local SquadExternalContractProvider = require(AppChatParent.SquadsCore.SquadExternalContractProvider)
local SharedFlags = require(AppChatParent.SharedFlags)

local SquadExternalContractProvider2 = SquadExternalContractProvider.SquadExternalContractProvider
local SquadLocationEnum = require(AppChatParent.SquadsCore.Enums).SquadLocationEnum
local ProviderContainer = RoactUtils.Components.ProviderContainer
local UniversalAppPolicy = require(AppChatParent.UniversalAppPolicy).UniversalAppPolicy
local AppFeaturePolicies = require(AppChatParent.UniversalAppPolicy).AppFeaturePolicies
local ChatPolicies = require(AppChatParent.SocialPolicies).ChatPolicies

local GetFFlagIsSquadEnabled = SharedFlags.GetFFlagIsSquadEnabled

return function(tbl1)
    local providers = React.useMemo(function()
        local result = {}

        table.insert(result, { class = ParentContainerProvider, props = tbl1.parentContainerContext })

        table.insert(result, { class = UnreadMessagesProvider, props = { dispatch = tbl1.updateAppChatUnreadMessagesCount } })

        table.insert(result, { class = RoactRodux.StoreProvider, props = { store = tbl1.store } })

        table.insert(result, { class = ApolloProvider, props = { client = tbl1.apolloClient } })

        table.insert(result, { class = UniversalAppPolicy.Provider, props = { policy = { AppFeaturePolicies, ChatPolicies } } })

        if GetFFlagIsSquadEnabled() then
            table.insert(result, {
                class = SquadExternalContractProvider2,
                props = {
                    contract = InExperienceSquadContract,
                    squadLocation = SquadLocationEnum.InExperience
                }
            })
        end

        table.insert(
            result,
            {
                class = LocalizationProvider,
                props = {
                    localization = Localization.new(LocalizationService.RobloxLocaleId)
                }
            }
        )
        return result
    end, {})

    return React.createElement(ProviderContainer, { providers = providers }, tbl1.children)
end
