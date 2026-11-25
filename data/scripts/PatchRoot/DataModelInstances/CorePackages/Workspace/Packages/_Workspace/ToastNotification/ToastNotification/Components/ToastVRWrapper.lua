-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:31:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")

local scriptParentParentParent = script.Parent.Parent.Parent

local React = require(scriptParentParentParent.React)
local UIBlox = require(scriptParentParentParent.UIBlox)

local VRConstants = require(scriptParentParentParent.VrCompatibility).VRConstants
local Panel3D = UIBlox.Core.VR.Panel3D
local Constants = UIBlox.Core.VR.Constants

local bool1 = game:DefineFastFlag("RepositionInExperienceVRToasts", false)

return function(arg1)
    local isConfirmModalOpen = arg1.isConfirmModalOpen
    local isToastOpen = arg1.isToastOpen
    local isCoreScript = arg1.isCoreScript

    local toastComponent = arg1.ToastComponent
    local confirmationModalComponent = arg1.ConfirmationModalComponent

    local var1 = React.useRef(nil)

    local var2 = GuiService.CoreGuiFolder and GuiService.CoreGuiFolder:FindFirstChild(VRConstants.PositionLockedPanelName)

    if var2 then
        var1.current = var2
    else
        var2 = var1.current
    end
    local var3 = if var2 then var2.Size.Y else 2.45

    local tbl1 = {
        partSize = VRConstants.ToastSize,
        offset = CFrame.lookAt(VRConstants.ToastPosition, VRConstants.DefaultCameraPosition),
        virtualScreenSize = VRConstants.ToastResolution,
        curvature = VRConstants.ToastCurvature,
        panelName = "ToastNotifications",
        hidden = not isToastOpen
    }

    if isCoreScript then
        local tiltCallback = React.useCallback(function(arg2)
            if var2 then
                if bool1 then
                    return var2.CFrame * CFrame.new(0, var3 * -0.53, var3 * -0.15) * CFrame.Angles(0.25, 0, 0)
                end

                return var2.CFrame * CFrame.new(0, var3 * -0.45, var3 * -0.15) * CFrame.Angles(0.2, 0, 0)
            end

            return arg2.panelCFrame
        end, { var2, var3 })

        tbl1 = {
            panelName = "ToastNotifications",
            partSize = if bool1 then Vector3.new(1, 0.5, 0) else Vector3.new(1.2, 0.6, 0),
            virtualScreenSize = Vector2.new(300, 150),
            lerp = false,
            tilt = 0,
            anchoring = Constants.AnchoringTypes.Head,
            faceCamera = true,
            curvature = 0,
            alwaysOnTop = true,
            parent = GuiService.CoreGuiFolder,
            hidden = not isToastOpen,
            tiltCallback = tiltCallback
        }
    end

    local tiltCallback = React.useCallback(function(arg2)
        if var2 then
            return var2.CFrame * CFrame.new(0, 0, -0.1)
        end

        return arg2.panelCFrame
    end, { var2 })

    return React.createElement(React.Fragment, nil, { React.createElement(Panel3D, tbl1, { Toast = toastComponent }), React.createElement(
            Panel3D,
            {
                panelName = "ConfirmationModal",
                partSize = Vector3.new(3, 3, 0),
                virtualScreenSize = Vector2.new(600, 600),
                lerp = false,
                tilt = 0,
                anchoring = Constants.AnchoringTypes.Head,
                faceCamera = true,
                curvature = 0,
                alwaysOnTop = true,
                parent = GuiService.CoreGuiFolder,
                hidden = not isConfirmModalOpen,
                tiltCallback = tiltCallback
            },
            { DeeplinkConfirmationModal = confirmationModalComponent }
        ) })
end
