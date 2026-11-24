-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T14:40:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxReplicatedStorage = game:GetService("RobloxReplicatedStorage")
local RunService = game:GetService("RunService")
local GuiService = game:GetService("GuiService")

local GameInvite = script:FindFirstAncestor("GameInvite")
local Components = GameInvite.Components
local Context = GameInvite.Context
local Actions = GameInvite.State.Actions
local GameInviteParent = GameInvite.Parent

local React = require(GameInviteParent.React)
local RoactUtils = require(GameInviteParent.RoactUtils)
local ReactRoblox = require(GameInviteParent.ReactRoblox)
local Promise = require(GameInviteParent.Promise)
local GetGameNameAndDescription = require(GameInviteParent.GameDetailRodux).GetGameNameAndDescription

local InputHandlers = require(GameInviteParent.InputHandlers)
local FocusNavigationUtils = require(GameInviteParent.FocusNavigationUtils)
local FocusNavigableSurfaceWrapper = FocusNavigationUtils.FocusNavigableSurfaceWrapper
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local FocusNavigationEventNameEnum = FocusNavigationUtils.FocusNavigationEventNameEnum

local _gameInviteModalType = require(GameInvite.gameInviteModalType)
local GameInviteModalManager = require(GameInvite.GameInviteModalManager)
local GameInviteModalLayoutProvider = require(Context.GameInviteModalLayoutProvider)
local GameInviteModalWindow = require(Components.GameInviteModalWindow)
local GameInviteContentWrapper = require(Components.GameInviteContentWrapper)
local GameInviteDependencies = require(GameInvite.GameInviteDependencies)
local GameInviteConstants = require(GameInvite.GameInviteConstants)
local ResetUserInviteStatus = require(Actions.ResetUserInviteStatus)

local VrCompatibility = require(GameInviteParent.VrCompatibility)
local VRReadyWrapper = VrCompatibility.VRReadyWrapper
local VRConstants = VrCompatibility.VRConstants

local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local networkImpl = GameInviteDependencies.networkImpl

local SharedFlags = require(GameInviteParent.SharedFlags)
local FFlagUseSignalsForGameInvitesStatus = SharedFlags.FFlagUseSignalsForGameInvitesStatus
local GetGameInvitesStatusStore = if FFlagUseSignalsForGameInvitesStatus then require(GameInviteParent.NotificationsCommon).GetGameInvitesStatusStore else nil
local GetFFlagEnableGameInviteModalVRSupport = SharedFlags.GetFFlagEnableGameInviteModalVRSupport
local isInExperienceUIVREnabled = require(GameInviteParent.SharedExperimentDefinition).isInExperienceUIVREnabled
local FFlagEnableInExperienceUIPCVRFix = SharedFlags.FFlagEnableInExperienceUIPCVRFix

local Responsive = nil
local UIManager = nil
local PanelType = nil
local useStyleSheet = nil
if isInExperienceUIVREnabled then
    Responsive = require(GameInviteParent.Responsive)
    if FFlagEnableInExperienceUIPCVRFix then
        useStyleSheet = require(GameInviteParent.Foundation).Hooks.useStyleSheet
    else
        useStyleSheet = nil
    end
    local vrSpatialUi = require(GameInviteParent.VrSpatialUi)
    UIManager = vrSpatialUi.UIManager
    PanelType = vrSpatialUi.Constants.PanelType
end

local customEventHandlers = {
    [FocusNavigationEventNameEnum.NavigateBack] = {
        handler = InputHandlers.onRelease(function(arg1)
            GameInviteModalManager:closeModal()
            arg1:cancel()
        end)
    }
}

return function(tbl2)
    local var1, var2 = React.useState(false)
    local isLoading, var4 = React.useState(false)

    local options, var6 = React.useState({})
    local gameDetails, var8 = React.useState({})
    local serverType, var10 = React.useState("")

    local bool1 = not RunService:IsStudio()
    local isCoreScript = tbl2.renderLocation == GameInviteConstants.RenderLocation.CoreScripts
    local disableSelectionParentManagement = tbl2.renderLocation == GameInviteConstants.RenderLocation.UniversalApp
    local var11 = useDispatch()
    local var12, var13

    if isInExperienceUIVREnabled then
        var12 = Responsive.useIsSpatial()
        if FFlagEnableInExperienceUIPCVRFix then
            var13 = useStyleSheet()
        else
            var13 = nil
        end
    else
        var12 = nil
        var13 = nil
    end

    local function func1(arg1, arg2, arg3)
        var2(arg1)
        var4(arg2 or false)
        if arg3 then
            var6(arg3)
        end

        if FFlagUseSignalsForGameInvitesStatus then
            if disableSelectionParentManagement and not arg1 then
                GetGameInvitesStatusStore(false).reset()
            end
        elseif disableSelectionParentManagement and not arg1 and var11 then
            var11(ResetUserInviteStatus())
        end
    end
    React.useEffect(function()
        local connection = GameInviteModalManager.ToggleGameInviteModalEvent.Event:Connect(func1)
        return function()
            connection:Disconnect()
        end
    end, {})

    React.useEffect(function()
        if not isCoreScript then
            return function() end
        end

        local connection = GuiService.MenuOpened:Connect(function()
            if var1 then
                GameInviteModalManager:closeModal()
            end
        end)
        return function()
            connection:Disconnect()
        end
    end, { var1, isCoreScript })

    React.useEffect(function()
        if not bool1 or not var1 or not isCoreScript then
            return
        end

        if serverType == "" then
            Promise.try(function()
                return RobloxReplicatedStorage:WaitForChild("GetServerType", 2):InvokeServer()
            end):andThen(function(arg1)
                var10(arg1)
            end)
        end

        if GetGameNameAndDescription and not gameDetails.Created then
            GetGameNameAndDescription(networkImpl, game.GameId):andThen(function(arg1)
                var8(arg1)
            end)
        end
    end, { var1 })

    if not var1 then
        return nil
    end

    local element = React.createElement(GameInviteModalWindow, {}, {
        GameInviteModalContentWrapper = React.createElement(GameInviteContentWrapper, {
            options = options,
            serverType = serverType,
            gameDetails = gameDetails,
            isLoading = isLoading,
            isCoreScript = isCoreScript,
            disableSelectionParentManagement = disableSelectionParentManagement,
            hideCloseButton = options.hideCloseButton
        })
    })

    if GetFFlagEnableGameInviteModalVRSupport() and disableSelectionParentManagement then
        local createElement = React.createElement
        local var14 = VRReadyWrapper
        local tbl3 = {
            component = "ScreenGui",
            props = {
                DisplayOrder = tbl2.displayOrder,
                ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
                IgnoreGuiInset = true,
                Name = GameInviteConstants.ParentComponentName
            },
            vrProps = {
                partSize = VRConstants.MainScreenSize,
                offset = CFrame.new(VRConstants.MainScreenPosition) * CFrame.fromEulerAnglesXYZ(0, -math.pi, 0),
                virtualScreenSize = VRConstants.MainScreenResolution,
                panelName = "GameInviteMenu",
                curvature = VRConstants.MainScreenCurvature
            }
        }
        local tbl4 = { GameInviteModalLayoutProvider = 0 }
        local createElement2 = React.createElement
        local var15 = GameInviteModalLayoutProvider
        local tbl5 = { isCoreScript = isCoreScript }
        local tbl6 = { ModalWindowContainer = 0 }
        if disableSelectionParentManagement then
            element = React.createElement(FocusNavigableSurfaceWrapper, {
                surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.PopUp,
                isAutoFocusRoot = true,
                isIsolated = true,
                isFocusable = true,
                customEventHandlers = customEventHandlers
            }, { ModalWindowContainer = element })
        end

        tbl6.ModalWindowContainer = element
        tbl4.GameInviteModalLayoutProvider = createElement2(var15, tbl5, tbl6)
        return createElement(var14, tbl3, tbl4)
    end

    if not (isInExperienceUIVREnabled and var12) then
        local createElement = React.createElement
        local str1 = "ScreenGui"
        local tbl3 = {
            DisplayOrder = tbl2.displayOrder,
            ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
            IgnoreGuiInset = true,
            Name = GameInviteConstants.ParentComponentName
        }
        local tbl4 = { GameInviteModalLayoutProvider = 0 }
        local createElement2 = React.createElement
        local var14 = GameInviteModalLayoutProvider
        local tbl5 = { isCoreScript = isCoreScript }
        local tbl6 = { ModalWindowContainer = 0 }
        if disableSelectionParentManagement then
            element = React.createElement(FocusNavigableSurfaceWrapper, {
                surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.PopUp,
                isAutoFocusRoot = true,
                isFocusable = true,
                isIsolated = true,
                customEventHandlers = customEventHandlers
            }, { ModalWindowContainer = element })
        end

        tbl6.ModalWindowContainer = element
        tbl4.GameInviteModalLayoutProvider = createElement2(var14, tbl5, tbl6)
        return createElement(str1, tbl3, tbl4)
    end

    local panelObject = UIManager.getInstance():getPanelObject(PanelType.MoreMenu)
    local panelSizeInPixel = if FFlagEnableInExperienceUIPCVRFix then UIManager.getInstance():getPanelSizeInPixel(PanelType.MoreMenu) else nil
    local createPortal = ReactRoblox.createPortal
    local tbl3 = {
        FoundationStyleLink = if FFlagEnableInExperienceUIPCVRFix then React.createElement("StyleLink", { StyleSheet = var13 }) else nil,
        GameInviteModalLayoutProvider = 0
    }

    local createElement = React.createElement
    local var14 = GameInviteModalLayoutProvider
    local tbl4 = { isCoreScript = isCoreScript, screenSizeOverride = 0 }
    if not FFlagEnableInExperienceUIPCVRFix then
        panelSizeInPixel = nil
    end

    tbl4.screenSizeOverride = panelSizeInPixel
    tbl3.GameInviteModalLayoutProvider = createElement(var14, tbl4, {
        ModalWindowContainer = React.createElement(GameInviteModalWindow, {}, {
            GameInviteModalContentWrapper = React.createElement(GameInviteContentWrapper, {
                options = options,
                serverType = serverType,
                gameDetails = gameDetails,
                isLoading = isLoading,
                isCoreScript = isCoreScript
            })
        })
    })
    return createPortal(tbl3, panelObject)
end
