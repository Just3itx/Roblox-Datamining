-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:11:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local InExperienceShopParent = script:FindFirstAncestor("InExperienceShop").Parent

local React = require(InExperienceShopParent.React)
local requestInternalWrapper = require(InExperienceShopParent.Http).NetworkLayers.requestInternalWrapper
local CoreScriptsRootProvider = require(InExperienceShopParent.CoreScriptsRoactCommon).CoreScriptsRootProvider
local RoactNavigation = require(InExperienceShopParent.RoactNavigation)
local RoactNetworking = require(InExperienceShopParent.RoactServiceTags).RoactNetworking
local RoactServices = require(InExperienceShopParent.RoactServices).RoactServices
local FocusNavigationUtils = require(InExperienceShopParent.FocusNavigationUtils)
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local FocusRoot = FocusNavigationUtils.FocusRoot
local DynamicReportContainer = require(InExperienceShopParent.GenericAbuseReporting.DynamicReportContainer)
local _AbuseVector = require(InExperienceShopParent.GenericAbuseReporting.AbuseVector)

local value = {
    isFocused = function(): boolean
        return true
    end,
    addListener = function(_: string, _: (...any) -> (...any))
        return {
            remove = function() end
        }
    end
}

local function ShopAbuseReportOverlay(tbl2)
    return React.createElement(
        "Frame",
        {
            Size = UDim2.fromScale(1, 1),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ZIndex = 10
        },
        {
            Providers = React.createElement(CoreScriptsRootProvider, {}, {
                Navigation = React.createElement(RoactNavigation.Provider, { value = value }, {
                    Services = React.createElement(
                        RoactServices.ServiceProvider,
                        {
                            services = {
                                [RoactNetworking] = requestInternalWrapper(HttpService)
                            }
                        },
                        {
                            FocusNavigationCoreScriptsWrapper = React.createElement(FocusRoot, {
                                frameProps = {
                                    Size = UDim2.fromScale(1, 1)
                                },
                                surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.CentralOverlay,
                                isIsolated = true,
                                isAutoFocusRoot = true
                            }, {
                                DynamicReport = React.createElement(
                                    DynamicReportContainer,
                                    {
                                        abuseVector = tbl2.abuseVector,
                                        targetId = tbl2.targetId,
                                        onClose = tbl2.onClose
                                    }
                                )
                            })
                        }
                    )
                })
            })
        }
    )
end

return ShopAbuseReportOverlay
