-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:11:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local React = require(CorePackages.Packages.React)
local Rodux = require(CorePackages.Packages.Rodux)
local RoactRodux = require(CorePackages.Packages.RoactRodux)

local View = require(CorePackages.Packages.Foundation).View

local Responsive = require(CorePackages.Workspace.Packages.Responsive)

local CoreScriptsRootProvider = require(CorePackages.Workspace.Packages.CoreScriptsRoactCommon).CoreScriptsRootProvider

local RoactAppPolicy = require(CorePackages.Workspace.Packages.UniversalAppPolicy).RoactAppPolicy
local AppFeaturePolicies = require(CorePackages.Workspace.Packages.UniversalAppPolicy).AppFeaturePolicies
local ChatPolicies = require(CorePackages.Workspace.Packages.SocialPolicies).ChatPolicies
local AvatarPolicies = require(CorePackages.Workspace.Packages.AvatarPolicies).AvatarPolicies
local SharePolicies = require(CorePackages.Workspace.Packages.SocialPolicies).SharePolicies
local ShareTargetGamePolicies = require(CorePackages.Workspace.Packages.SocialPolicies).ShareTargetGamePolicies
local Enums = require(CorePackages.Workspace.Packages.ProfilePlatform.Enums)
local installReducer = require(CorePackages.Workspace.Packages.ProfilePlatform.installReducer)

local Constants = require(CorePackages.Workspace.Packages.ProfilePlatform.Constants)
local ProfileTypes = Enums.ProfileTypes
local ProfileWrapperContext = require(CorePackages.Workspace.Packages.ProfilePlatform.ProfileWrapperContext)

local PlayerProfile = require(script.Parent.PlayerProfile)

local function createStore(arg1)
    local var1 = Rodux.combineReducers({ [Constants.RODUX_KEY] = installReducer() })

    return Rodux.Store.new(var1, arg1 or {}, { Rodux.thunkMiddleware })
end

local function PlayerProfileContainer(tbl1)
    local var1 = React.useRef(nil)

    local createElement = React.createElement
    local provider = RoactAppPolicy.Provider
    local tbl2 = {
        policy = {
            AppFeaturePolicies,
            ChatPolicies,
            AvatarPolicies,
            SharePolicies,
            ShareTargetGamePolicies
        }
    }

    local tbl3 = { ProfileWrapperProvider = 0 }
    local createElement2 = React.createElement
    local provider2 = ProfileWrapperContext.Provider
    local tbl4 = {
        value = {
            profileId = tostring(tbl1.userId),
            profileType = ProfileTypes.User,
            sourceInfo = {
                source = Enums.Sources.InExperienceProfile,
                contextualInfoType = ""
            },
            navigateTo = {
                qRCodePage = function() end,
                previousView = function(_: boolean) end,
                itemDetails = function(_) end,
                itemOrBundleDetails = function(_, _) end,
                catalogSearch = function(_) end,
                tryOnItem = function(_: string, _: string, _: string?, _: string?) end,
                inspectAvatar = tbl1.inspectAvatar,
                editUsername = function() end,
                openLeaveRobloxAlertUIBlox = function(_: (...any) -> (...any)) end,
                closeLeaveRobloxAlert = function() end
            },
            externalAnalytics = {
                catalogAnalytics = {}
            }
        }
    }
    tbl3.ProfileWrapperProvider = createElement2(provider2, tbl4, {
        CoreScriptsRootProvider = React.createElement(CoreScriptsRootProvider, {}, {
            RoduxStore = React.createElement(RoactRodux.StoreProvider, {
                store = createStore()
            }, {
                ResponsiveProvider = React.createElement(Responsive.ContainerRef.Provider, {
                    value = var1
                }, {
                    PlayerProfileContainer = React.createElement(
                        View,
                        { tag = "size-full", ref = var1 },
                        {
                            PlayerProfile = React.createElement(PlayerProfile, { userId = tbl1.userId, closePage = tbl1.closePage })
                        }
                    )
                })
            })
        })
    })
    return createElement(provider, tbl2, tbl3)
end

return PlayerProfileContainer
