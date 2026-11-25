-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:31:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ContextActionService = game:GetService("ContextActionService")
local GuiService = game:GetService("GuiService")
local SwitchServer = script:FindFirstAncestor("SwitchServer")
local SwitchServerParent = SwitchServer.Parent
local RunService = game:GetService("RunService")

local Foundation = require(SwitchServerParent.Foundation)
local Localization = require(SwitchServerParent.Localization)
local React = require(SwitchServerParent.React)
local FocusNavigationUtils = require(SwitchServerParent.FocusNavigationUtils)
local InputHandlers = require(SwitchServerParent.InputHandlers)
local ReactFocusNavigation = require(SwitchServerParent.ReactFocusNavigation)

local Constants = require(SwitchServer.Constants)

local Dialog = Foundation.Dialog
local DialogSize = Foundation.Enums.DialogSize
local ButtonVariant = Foundation.Enums.ButtonVariant
local EnumsOrientation = Foundation.Enums.Orientation
local useLocalization = Localization.Hooks.useLocalization

local useFocusRoot = FocusNavigationUtils.useFocusRoot
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local FocusNavigationEventNameEnum = FocusNavigationUtils.FocusNavigationEventNameEnum

local eventMap = {
    [Enum.KeyCode.ButtonB] = FocusNavigationEventNameEnum.NavigateBack
}

local LaunchGame = require(SwitchServerParent.GameLaunch).LaunchGame
local default = require(SwitchServerParent.ExperienceService).GameProtocol.default

local RecentServerHistory = require(SwitchServer.RecentServerHistory)
local callTeleportSwitchServer = require(SwitchServer.Utils.callTeleportSwitchServer)

local SwitchServerTelemetry = require(SwitchServer.Telemetry.SwitchServerTelemetry)
local FFlagUseTeleportForLuaSwitchServerImpl = require(SwitchServer.Flags.FFlagUseTeleportForLuaSwitchServerImpl)
local FFlagUseMultipleServerIdsForSwitchServer = require(SwitchServer.Flags.FFlagUseMultipleServerIdsForSwitchServer)

local function simpleLeaveGame() -- Luacid: Inlined by compiler; 1 call site recovered
    GuiService.SelectedCoreObject = nil

    RunService.RenderStepped:Wait()
    RunService.RenderStepped:Wait()

    game:Shutdown()
end

local function SwitchServerConfirmationDialog(tbl2)
    local var1 = useLocalization({
        title = Constants.CONFIRMATION.TITLE,
        body = Constants.CONFIRMATION.BODY,
        confirm = Constants.CONFIRMATION.CONFIRM,
        cancel = Constants.CONFIRMATION.CANCEL
    })

    local onActivated = React.useCallback(function()
        SwitchServerTelemetry.sendSwitchServerConfirmationActions({ event_type = "confirm" })

        tbl2.setSwitchServerConfirmationOpen(false)
        if FFlagUseTeleportForLuaSwitchServerImpl and game:GetEngineFeature("SwitchServerAvailable") then
            if FFlagUseMultipleServerIdsForSwitchServer then
                callTeleportSwitchServer(RecentServerHistory.default:getRecentServerIds())
                return
            end
            callTeleportSwitchServer()

            return
        end
        LaunchGame(
            tostring(game.PlaceId),
            Constants.REFERRAL_PAGE,
            {
                gameIdToExclude = tostring(game.JobId)
            },
            default,
            Constants.SOURCE
        )
        simpleLeaveGame()
    end, { tbl2.setSwitchServerConfirmationOpen, game.PlaceId, game.JobId })

    local var3 = React.useRef(false)
    local var4 = React.useCallback(function()
        if var3.current then
            return
        end
        var3.current = true
        SwitchServerTelemetry.sendSwitchServerConfirmationActions({ event_type = "cancel" })

        tbl2.setSwitchServerConfirmationOpen(false)
    end, { tbl2.setSwitchServerConfirmationOpen })

    React.useEffect(function()
        ContextActionService:BindCoreAction("SwitchServerConfirmationCloseOnBack", function(_, userInputState): Enum.ContextActionResult
            if userInputState == Enum.UserInputState.Begin then
                var4()
            end

            return Enum.ContextActionResult.Sink
        end, false, Enum.KeyCode.Escape, Enum.KeyCode.ButtonB)

        return function()
            ContextActionService:UnbindCoreAction("SwitchServerConfirmationCloseOnBack")
        end
    end, { var4 })

    React.useEffect(function()
        GuiService:SetMenuIsOpen(true, "SwitchServerConfirmation")
        return function()
            GuiService:SetMenuIsOpen(false, "SwitchServerConfirmation")
        end
    end, {})

    local eventHandlers = React.useMemo(function()
        return {
            [FocusNavigationEventNameEnum.NavigateBack] = {
                handler = InputHandlers.onRelease(function(arg1)
                    var4()
                    arg1:cancel()
                end)
            }
        }
    end, { var4 })

    local ref = useFocusRoot({
        surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.PopUp,
        isAutoFocusRoot = true,
        eventMap = eventMap,
        eventHandlers = eventHandlers
    })

    return React.createElement(
        Dialog.Root,
        {
            ref = ref,
            size = DialogSize.Small,
            hasBackdrop = true,
            disablePortal = false,
            onClose = var4
        },
        {
            DialogTitle = React.createElement(Dialog.Title, { text = var1.title, LayoutOrder = 1 }),
            DialogContent = React.createElement(
                Dialog.Content,
                { LayoutOrder = 2 },
                {
                    DialogText = React.createElement(Dialog.Text, { Text = var1.body })
                }
            ),
            DialogActions = React.createElement(Dialog.Actions, {
                orientation = EnumsOrientation.Vertical,
                LayoutOrder = 3,
                actions = {
                    {
                        text = var1.confirm,
                        variant = ButtonVariant.Emphasis,
                        onActivated = onActivated
                    },
                    {
                        text = var1.cancel,
                        variant = ButtonVariant.Standard,
                        onActivated = var4
                    }
                }
            })
        }
    )
end

return React.memo(function(tbl2) -- name: SwitchServerConfirmation
    local value = React.useMemo(function()
        return ReactFocusNavigation.FocusNavigationService.new(ReactFocusNavigation.EngineInterface.CoreGui)
    end, {})

    React.useEffect(function()
        return function()
            value:teardown()
        end
    end, { value })

    return React.createElement(
        ReactFocusNavigation.FocusNavigationContext.Provider,
        { value = value },
        React.createElement(SwitchServerConfirmationDialog, tbl2)
    )
end)
