-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:31:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParentParentParent = scriptParent.Parent.Parent.Parent
local React = require(scriptParentParentParentParent.React)

local Constants = require(scriptParent.Constants)

local function GetUserCFrameWorldSpace(userCFrame: Enum.UserCFrame, vrService)
    local userCFrame2 = vrService:GetUserCFrame(userCFrame)
    local currentCamera = workspace.CurrentCamera

    if not currentCamera.HeadLocked then
        userCFrame2 = vrService:GetUserCFrame(Enum.UserCFrame.Head):Inverse() * userCFrame2
    end

    return currentCamera.CFrame * (CFrame.new(userCFrame2.p * currentCamera.HeadScale) * (userCFrame2 - userCFrame2.p))
end

local function usePanel3DRenderStep(arg1, arg2)
    if arg1.anchoring == Constants.AnchoringTypes.PanelManaged and arg1.connectPanelManagerFunction then
        return
    end

    local var1 = React.useRef(arg1.offset)
    local var2 = React.useRef(nil)
    local var3 = React.useRef(false)

    local vrService = arg1.vrService

    React.useEffect(function()
        var1.current = arg1.offset
    end, {})

    local var4 = React.useCallback(function(arg3)
        local currentCamera = workspace.CurrentCamera

        local currentCameraCFrame = currentCamera.CFrame
        local headScale = currentCamera.HeadScale
        local userCFrame = nil
        local userCFrame2, pos

        if arg1.anchoring == Constants.AnchoringTypes.Head then
            userCFrame2 = vrService:GetUserCFrame(Enum.UserCFrame.Head)

            local current = GetUserCFrameWorldSpace(Enum.UserCFrame.Head, vrService)

            if var2.current == nil then
                var2.current = current
            end

            assert(var2.current ~= nil, "lastLookCFrame should not be nil.")

            if var2.current.LookVector:Dot(current.LookVector) < 0.85 then
                var3.current = true
            elseif var2.current.LookVector:Dot(current.LookVector) > 0.99 then
                var3.current = false
            end

            if var3.current then
                var2.current = var2.current:Lerp(current, 7.2 * arg3)
            end

            local var4 = current.Position + var2.current.LookVector * headScale * 2
            pos = Vector3.new(var4.X, current.Position.Y, var4.Z)

            local alignedPanel = arg1.alignedPanel
            if alignedPanel then
                local part = alignedPanel:GetPart()
                if part and alignedPanel:IsPositionLockedType() and (alignedPanel:IsVisible() or alignedPanel.alwaysUpdatePosition) then
                    pos = Vector3.new(part.Position.X, current.Position.Y - 0.4 * headScale, part.Position.Z)
                end
            end
        else
            if arg1.anchoring ~= Constants.AnchoringTypes.Wrist then
                return
            end

            if vrService:GetUserCFrameEnabled(Enum.UserCFrame.RightHand) and vrService.GuiInputUserCFrame == Enum.UserCFrame.LeftHand then
                userCFrame = vrService:GetUserCFrame(Enum.UserCFrame.RightHand)
            elseif vrService:GetUserCFrameEnabled(Enum.UserCFrame.LeftHand) then
                userCFrame = vrService:GetUserCFrame(Enum.UserCFrame.LeftHand)
            end
            userCFrame2 = userCFrame or vrService:GetUserCFrame(Enum.UserCFrame.Head)

            local pos2 = userCFrame2.Position * headScale
            pos = (currentCameraCFrame * CFrame.new(pos2)).Position
        end

        if arg1.offsetCallback then
            pos = arg1.offsetCallback({ finalPosition = pos, cameraHeadScale = headScale })
        end

        if arg1.lerp and var1.current ~= nil then
            var1.current = var1.current:Lerp(arg1.offset, 7.2 * arg3)
        else
            var1.current = arg1.offset
        end

        local var4

        if var1.current == nil then
            var4 = nil
        elseif arg1.faceCamera then
            local userCFrameWorldSpace = GetUserCFrameWorldSpace(Enum.UserCFrame.Head, vrService)

            var4 = CFrame.new(pos + var1.current.Position * headScale, userCFrameWorldSpace.Position)
        else
            local var5, ry, var6 = userCFrame2:ToOrientation()
            local cFrame = CFrame.new(var1.current.Position * headScale)
            var4 = CFrame.new(pos) * CFrame.Angles(-var5, ry, -var6) * cFrame
        end

        if arg1.tiltCallback then
            var4 = arg1.tiltCallback({ panelCFrame = var4, cameraHeadScale = headScale })
        end

        if arg2.current ~= nil then
            arg2.current.CFrame = var4

            local current = arg2.current
            current.Size = Vector3.new(arg1.partSize.X * headScale, arg1.partSize.Y * headScale, 0.05)
        end
    end, {
        arg1.anchoring,
        arg1.faceCamera,
        arg1.lerp,
        arg1.offset,
        arg1.partSize,
        arg1.alignedPanel,
        arg1.offsetCallback,
        arg1.tiltCallback
    })

    React.useEffect(function()
        if arg1.anchoring == Constants.AnchoringTypes.World then
            return function() end
        end

        local connection = nil
        local connection2 = nil

        local function onCurrentCameraChanged()
            if connection then
                connection:Disconnect()
            end
            if workspace.CurrentCamera then
                connection = workspace.CurrentCamera:GetPropertyChangedSignal("CFrame"):Connect(function()
                    var4(0)
                end)
            end
        end

        local connection3 = workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(onCurrentCameraChanged)
        onCurrentCameraChanged()

        if arg1.alignedPanel then
            local part = arg1.alignedPanel:GetPart()
            if part then
                connection2 = part:GetPropertyChangedSignal("CFrame"):Connect(function()
                    var4(0)
                end)
            end
        end

        local connection4 = arg1.movementUpdateEvent:Connect(var4)

        return function()
            connection4:Disconnect()
            connection3:Disconnect()
            if connection then
                connection:Disconnect()
            end
            if connection2 then
                connection2:Disconnect()
            end
        end
    end, { arg1.anchoring, var4 })
end

return usePanel3DRenderStep
