-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T21:11:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local LocalizationService = game:GetService("LocalizationService")

local UserRelationshipModals = script:FindFirstAncestor("UserRelationshipModals")
local UserRelationshipModalsParent = UserRelationshipModals.Parent

local Provider = require(UserRelationshipModalsParent.FocusNavigationUtils).FocusNavigableSurfaceRegistry.Provider
local Foundation = require(UserRelationshipModalsParent.Foundation)
local FoundationProvider = Foundation.FoundationProvider
local LocalizationProvider = require(UserRelationshipModalsParent.Localization).LocalizationProvider
local Localization = require(UserRelationshipModalsParent.InExperienceLocales).Localization
local React = require(UserRelationshipModalsParent.React)
local ReactFocusNavigation = require(UserRelationshipModalsParent.ReactFocusNavigation)
local ReactRoblox = require(UserRelationshipModalsParent.ReactRoblox)
local Rodux = require(UserRelationshipModalsParent.Rodux)
local RoactRodux = require(UserRelationshipModalsParent.RoactRodux)

local installReducer = require(UserRelationshipModals.Rodux.installReducer)
local RODUX_KEY = require(UserRelationshipModals.Rodux.RODUX_KEY)

local function createRoduxStore()
    return Rodux.Store.new(Rodux.combineReducers({ [RODUX_KEY] = installReducer() }), nil, { Rodux.thunkMiddleware })
end

return function(arg1, arg2)
    if CoreGui:FindFirstChild("UserRelationshipModal") then
        return
    end

    local userRelationshipModal = Instance.new("Folder")
    userRelationshipModal.Name = "UserRelationshipModal"
    userRelationshipModal.Parent = CoreGui
    local userRelationshipModalOverlay = Instance.new("ScreenGui")
    userRelationshipModalOverlay.Parent = userRelationshipModal
    userRelationshipModalOverlay.Name = "UserRelationshipModalOverlay"
    userRelationshipModalOverlay.DisplayOrder = -1
    userRelationshipModalOverlay.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    userRelationshipModalOverlay.Enabled = true
    userRelationshipModalOverlay.ScreenInsets = Enum.ScreenInsets.CoreUISafeInsets
    userRelationshipModalOverlay.SafeAreaCompatibility = Enum.SafeAreaCompatibility.None
    userRelationshipModalOverlay.ClipToDeviceSafeArea = false

    local var1 = table.clone(arg2)
    function var1.onClose()
        userRelationshipModal:Destroy()
    end

    local focusNavigationService = ReactFocusNavigation.FocusNavigationService.new(ReactFocusNavigation.EngineInterface.CoreGui)

    local element = React.createElement(
        LocalizationProvider,
        {
            localization = Localization.new(LocalizationService.RobloxLocaleId)
        },
        {
            FoundationProvider = React.createElement(
                FoundationProvider,
                {
                    colorMode = Foundation.Enums.ColorMode.Dark,
                    overlayGui = userRelationshipModalOverlay
                },
                {
                    FocusNavigationProvider = React.createElement(
                        ReactFocusNavigation.FocusNavigationContext.Provider,
                        { value = focusNavigationService },
                        {
                            FocusNavigationRegistryProvider = React.createElement(Provider, nil, {
                                StoreProvider = React.createElement(
                                    RoactRodux.StoreProvider,
                                    {
                                        store = createRoduxStore()
                                    },
                                    {
                                        UserRelationshipModal = React.createElement(arg1, var1, {})
                                    }
                                )
                            })
                        }
                    )
                }
            )
        }
    )
    ReactRoblox.createRoot(userRelationshipModalOverlay):render(element)
end
