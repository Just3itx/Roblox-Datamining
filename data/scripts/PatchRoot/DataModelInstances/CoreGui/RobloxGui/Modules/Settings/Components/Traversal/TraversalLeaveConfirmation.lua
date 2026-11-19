-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:51:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local ContextActionService = game:GetService("ContextActionService")
local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")

local Foundation = require(CorePackages.Packages.Foundation)
local React = require(CorePackages.Packages.React)
local Signals = require(CorePackages.Packages.Signals)
local SignalsReact = require(CorePackages.Packages.SignalsReact)

local DataHydration = require(CorePackages.Workspace.Packages.DataHydration)
local CoreScriptsRoactCommon = require(CorePackages.Workspace.Packages.CoreScriptsRoactCommon)
local Localization = require(CorePackages.Workspace.Packages.Localization)
local Responsive = require(CorePackages.Workspace.Packages.Responsive)

local View = Foundation.View
local getGameInfoStore = DataHydration.Game.getGameInfoStore
local Traversal = CoreScriptsRoactCommon.Traversal
local Constants = Traversal.Constants
local TeleportLeaveConfirmation = Traversal.TeleportLeaveConfirmation
local useLocalization = Localization.Hooks.useLocalization
local GetInputModeStore = Responsive.GetInputModeStore
local Input = Responsive.Input

return React.memo(function(tbl1) -- name: TraversalLeaveConfirmation
    local ref = React.useRef(nil)

    local var2 = useLocalization({ previous = "CoreScripts.TopBar.Traversal.BackButtonDefault" })

    local var3 = SignalsReact.useSignalState(getGameInfoStore(false).getAndFetchGameInfo(tostring(tbl1.universeId)).data)

    local var4 = nil
    local var5

    if typeof(var3) == "table" then
        var5 = var3.name
        var4 = tonumber(var3.rootPlaceId)
    else
        var5 = var2.previous
    end

    local functionToBind = React.useCallback(function(_, userInputState)
        if userInputState ~= Enum.UserInputState.End then
            return Enum.ContextActionResult.Pass
        end

        tbl1.onCancel()
        return Enum.ContextActionResult.Sink
    end, { tbl1.onCancel })

    React.useEffect(function()
        local effect = Signals.createEffect(function(arg1)
            local userInputType = UserInputService:GetLastInputType()
            local var6 = GetInputModeStore(arg1).getLastInputType(arg1)
            local bool1 = var6 == Input.Directional or var6 == Input.Pointer and userInputType == Enum.UserInputType.Keyboard

            if var4 ~= nil and var4 > Constants.NO_PLACE_ID then
                if bool1 then
                    ContextActionService:BindCoreAction("FREEZE_CONTROLLER", function() end, false, Enum.UserInputType.Gamepad1)
                    ContextActionService:BindCoreAction("EXIT_DIALOG", functionToBind, false, Enum.KeyCode.ButtonB)
                    GuiService.SelectedCoreObject = ref.current
                end
            elseif bool1 then
                ContextActionService:UnbindCoreAction("FREEZE_CONTROLLER")
                ContextActionService:UnbindCoreAction("EXIT_DIALOG")
            end
        end)

        return function()
            effect()
        end
    end, { var4 })

    return tbl1.isDialogOpen
        and var4
        and React.createElement(
            "ScreenGui",
            {
                DisplayOrder = 10,
                IgnoreGuiInset = true,
                ZIndexBehavior = Enum.ZIndexBehavior.Sibling
            },
            {
                NoEscapeZone = React.createElement(View, {
                    tag = "auto-xy size-full",
                    selectionGroup = {
                        SelectionBehaviorUp = Enum.SelectionBehavior.Stop,
                        SelectionBehaviorDown = Enum.SelectionBehavior.Stop,
                        SelectionBehaviorLeft = Enum.SelectionBehavior.Stop,
                        SelectionBehaviorRight = Enum.SelectionBehavior.Stop
                    }
                }, {
                    Dialog = React.createElement(TeleportLeaveConfirmation, {
                        onCancel = tbl1.onCancel,
                        onClose = tbl1.onClose,
                        placeId = var4,
                        teleportName = var5,
                        source = tbl1.source,
                        ref = ref
                    })
                })
            }
        )
end)
