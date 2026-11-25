-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:51:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VrSpatialUiParent = script:FindFirstAncestor("VrSpatialUi").Parent
local getSceneOverridesStore = require(VrSpatialUiParent.Style).getSceneOverridesStore

local var1 = nil

local function getVrEnvironment(): Instance? -- Luacid: Inlined by compiler; 1 call site recovered
    return workspace:FindFirstChild("VR Environment")
end

local function applyColorToBaseParts(arg1: Instance, color3: Color3)
    for _, descendant in arg1:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.Color = color3
        end
    end
end

local function applySceneOverrides(tbl1)
    if not tbl1 then
        return
    end

    local vrEnvironment = getVrEnvironment()

    if not vrEnvironment then
        return
    end

    local corePlatform = vrEnvironment:FindFirstChild("Core_Platform")
    if corePlatform then
        applyColorToBaseParts(corePlatform, tbl1.LargerShapes)
    end

    local midGroundCubeFloor = vrEnvironment:FindFirstChild("MidGround_CubeFloor")
    if midGroundCubeFloor then
        applyColorToBaseParts(midGroundCubeFloor, tbl1.LargerShapes)
    end
end

local function deinitialize() -- Luacid: Inlined by compiler; 1 call site recovered
    if var1 then
        var1()
        var1 = nil
    end
end

return {
    initialize = function()
        deinitialize()
        local sceneOverridesStore = getSceneOverridesStore()
        applySceneOverrides(sceneOverridesStore.getSceneOverrides())
        var1 = sceneOverridesStore.subscribe(function(arg1)
            applySceneOverrides(arg1)
        end)
    end,
    deinitialize = deinitialize,
    getVrEnvironment = getVrEnvironment
}
