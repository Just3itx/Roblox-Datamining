-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:01:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local selectSnapshotSources = require(script.Parent.selectSnapshotSources)

local CaptureService = require(scriptParentParent.Services.CaptureService)

local function snapToVoxelGrid(position: vector): Vector3 -- Luacid: Inlined by compiler; 1 call site recovered
    return Vector3.new(math.floor(position.X / 4) * 4, math.floor(position.Y / 4) * 4, math.floor(position.Z / 4) * 4)
end

local function getAppliedDescription(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    local humanoid = arg1:FindFirstChildOfClass("Humanoid")
    if humanoid == nil then
        return nil
    end
    local success, result = pcall(function(): HumanoidDescription
        return humanoid:GetAppliedDescription()
    end)
    return if success then result else nil
end

local function freeze(arg1)
    if arg1:IsA("Sound") or arg1:IsA("AudioPlayer") or arg1:IsA("Explosion") then
        arg1:Destroy()
    elseif arg1:IsA("BasePart") then
        arg1.Anchored = true
    elseif arg1:IsA("VideoFrame") then
        arg1.Playing = false
    end
end

return {
    captureSnapshotTree = function(tbl1)
        local tbl2 = tbl1 or {}
        local var1 = tbl2.camera or Workspace.CurrentCamera
        if var1 == nil then
            return nil
        end
        local localPlayer = Players.LocalPlayer
        local localCharacter = tbl2.localCharacter

        if not localCharacter then
            if localPlayer == nil then
                localCharacter = nil
            else
                localCharacter = localPlayer.Character
            end
        end

        local maxDepth = tbl2.maxDepth or 800
        local fovMargin = tbl2.fovMargin or 25
        local cFrame = var1.CFrame
        local fieldOfView = var1.FieldOfView
        local aspect = var1.ViewportSize.X / math.max(var1.ViewportSize.Y, 1)

        local var3 = selectSnapshotSources({
            root = tbl2.sceneRoot or Workspace,
            cameraCFrame = cFrame,
            fieldOfView = fieldOfView,
            aspect = aspect,
            maxDepth = maxDepth,
            fovMargin = fovMargin,
            nearRadius = 30,
            localCharacter = localCharacter
        })
        if #var3.looseParts == 0 and #var3.characters == 0 then
            return nil
        end

        local snapshotHeader = Instance.new("Configuration")
        snapshotHeader.Name = "SnapshotHeader"
        snapshotHeader:SetAttribute("PresentationOrigin", (snapToVoxelGrid(cFrame.Position)))
        snapshotHeader:SetAttribute("SelectionCameraCFrame", cFrame)
        snapshotHeader:SetAttribute("SelectionFovDeg", fieldOfView)
        snapshotHeader:SetAttribute("SelectionAspect", aspect)
        snapshotHeader:SetAttribute("SelectionFovMarginDeg", fovMargin)
        snapshotHeader:SetAttribute("SelectionMaxDepth", maxDepth)
        snapshotHeader:SetAttribute("SelectionNearRadius", 30)

        local var4 = table.clone(var3.looseParts)
        local num1 = #var4 + 1
        for _, character in var3.characters do
            table.insert(var4, character)
        end
        table.insert(var4, snapshotHeader)

        local success, result = pcall(function()
            return CaptureService:CloneForSnapshot(var4, true)
        end)
        snapshotHeader:Destroy()
        if not success then
            warn("CloneForSnapshot failed with error:", result)
            return nil
        end

        local roots = result:GetRoots()
        for _, root in roots do
            for _, descendant in root:GetDescendants() do
                freeze(descendant)
            end
            freeze(root)
        end

        for k, character in var3.characters do
            local root = roots[num1 + k - 1]
            if root == nil or root.ClassName ~= character.ClassName or root.Name ~= character.Name then
                continue
            end

            local appliedDescription = getAppliedDescription(character)

            if appliedDescription ~= nil then
                appliedDescription.Name = "Scene3DInspectDescription"
                appliedDescription.Parent = root
            end
        end

        return result
    end,
    HEADER_NAME = "SnapshotHeader",
    AVATAR_DESCRIPTION_NAME = "Scene3DInspectDescription"
}
