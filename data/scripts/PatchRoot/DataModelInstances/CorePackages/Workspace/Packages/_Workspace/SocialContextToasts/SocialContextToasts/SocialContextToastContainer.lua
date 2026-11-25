-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T15:31:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local LocalizationService = game:GetService("LocalizationService")
local SocialContextToasts = script:FindFirstAncestor("SocialContextToasts")
local SocialContextToastsParent = SocialContextToasts.Parent

local Localization = require(SocialContextToastsParent.RobloxAppLocales).Localization
local LocalizationProvider = require(SocialContextToastsParent.Localization).LocalizationProvider

local SocialContextToastDispatcher = require(SocialContextToasts.SocialContextToastDispatcher)
local ToastRoot = require(SocialContextToasts.ToastRoot)
local ToastTypes = require(SocialContextToasts.Enums.ToastTypes)

local ConfirmationModalRoot = require(SocialContextToasts.ConfirmationModalRoot)
local DisplayOrder = require(SocialContextToastsParent.DisplayOrder)
local ReactRoblox = require(SocialContextToastsParent.ReactRoblox)
local React = require(SocialContextToastsParent.React)
local Rodux = require(SocialContextToastsParent.Rodux)
local RoactRodux = require(SocialContextToastsParent.RoactRodux)
local Cryo = require(SocialContextToastsParent.Cryo)

local DisplayOrderEnum = DisplayOrder.DisplayOrderEnum

local StyleProviderWithDefaultTheme = require(SocialContextToastsParent.Style).StyleProviderWithDefaultTheme

local function renderWithStyleProvider(tbl1: {LocalizationProvider: any}) -- Luacid: Inlined by compiler; 1 call site recovered
    return React.createElement(StyleProviderWithDefaultTheme, {}, tbl1)
end

local function SocialContextToastContainer(services, gameId, placeId)
    local socialContextToast = Instance.new("Folder")
    socialContextToast.Name = "SocialContextToast"
    socialContextToast.Parent = CoreGui

    local tbl1 = {
        ToastContent = {
            toastType = ToastTypes.None
        }
    }

    local reducer = Rodux.createReducer({}, {
        SetToastContent = function(arg1, arg2)
            return (Cryo.Dictionary.join(arg1, { ToastContent = arg2.toastContent }))
        end,
        SetConfirmationModal = function(arg1, arg2)
            return (Cryo.Dictionary.join(
                arg1,
                {
                    ConfirmationModal = {
                        isOpen = arg2.isConfirmationModalOpen,
                        closeCallback = arg2.closeCallback
                    }
                }
            ))
        end
    })

    local store = Rodux.Store.new(reducer, tbl1, { Rodux.thunkMiddleware })
    local element = React.createElement(RoactRodux.StoreProvider, { store = store }, {
        StyleProvider = renderWithStyleProvider({
            LocalizationProvider = React.createElement(
                LocalizationProvider,
                {
                    localization = Localization.new(LocalizationService.RobloxLocaleId)
                },
                {
                    SocialContextToastGUI = React.createElement(
                        "ScreenGui",
                        {
                            DisplayOrder = DisplayOrderEnum.SocialContextToastContainer,
                            ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets
                        },
                        {
                            ToastDispatcher = React.createElement(SocialContextToastDispatcher, { services = services, gameId = gameId, placeId = placeId }),
                            ToastRoot = React.createElement(
                                ToastRoot,
                                {
                                    analyticsProps = {
                                        eventIngest = services.eventIngest,
                                        gameId = gameId,
                                        placeId = placeId
                                    }
                                }
                            ),
                            ConfirmationModalRoot = React.createElement(ConfirmationModalRoot)
                        }
                    )
                }
            )
        })
    })
    ReactRoblox.createRoot(socialContextToast):render(element)

    return element
end

return SocialContextToastContainer
