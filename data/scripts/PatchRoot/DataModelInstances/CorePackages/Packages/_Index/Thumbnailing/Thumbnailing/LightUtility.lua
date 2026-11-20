-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T16:20:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

local Lighting = game:GetService("Lighting")

local ColorUtility = require(script.Parent.ColorUtility)
local VectorUtility = require(script.Parent.VectorUtility)

function module.AddLight(tbl1, num1: number)
    local part = Instance.new("Part")
    part.Anchored = true
    part.Transparency = 1
    part.Shape = Enum.PartType.Ball
    part.Color = tbl1.color
    part.Name = "ThumbnailLightAnchor_" .. tostring(num1)
    part.Parent = workspace

    local pointLight = Instance.new("PointLight")
    pointLight.Color = tbl1.color
    pointLight.Brightness = 3
    pointLight.Range = 10
    pointLight.Shadows = true
    pointLight.Name = "PointLight_" .. tostring(num1)
    pointLight.Parent = part

    part.Position = tbl1.worldPos
end

function module.AddLightsFromExtraParams(tbl1, cFrame: CFrame): boolean
    local bool1 = false
    local pointLights = tbl1 and tbl1.pointLights

    if pointLights then
        for i, pointLight in ipairs(pointLights) do
            local tbl2 = {
                color = ColorUtility.Color3FromString(pointLight.color),
                worldPos = cFrame * VectorUtility.Vector3FromJson(pointLight.pos)
            }
            module.AddLight(tbl2, i)
            bool1 = true
        end
    end

    local clockTime = tbl1 and tbl1.clockTime
    if clockTime then
        Lighting.ClockTime = clockTime
        bool1 = true
    end

    local brightness = tbl1 and tbl1.brightness
    if brightness then
        Lighting.Brightness = brightness
        bool1 = true
    end

    return bool1
end

function module.AddDefaultPointLightRelativeTo(cFrame: CFrame)
    local worldPos = cFrame * Vector3.new(-5, 7, -5)
    local tbl1 = {
        color = Color3.new(1, 1, 1),
        worldPos = worldPos
    }
    module.AddLight(tbl1, 0)
end

function module.SetupSunlightWithJsonConfig(tbl1)
    tbl1 = tbl1
        or {
            brightness = "1",
            ambient = "124,124,124",
            colorShiftBottom = "108,94,66",
            colorShiftTop = "94,100,172",
            environmentDiffuseScale = "0",
            environmentSpecularScale = "1",
            globalShadows = "true",
            shadowSoftness = "0",
            outdoorAmbient = "0,0,0",
            clockTime = "9.5",
            geographicLatitude = "330",
            exposureCompensation = "0",
            timeOfDay = "09:30:00"
        }

    local lighting = Lighting
    local var1 = if tbl1.brightness then tonumber(tbl1.brightness) or 1 else 1
    lighting.Brightness = var1

    local var2 = not tbl1.ambient and { "124", "124", "124" } or tbl1.ambient:split(",") or { "124", "124", "124" }
    local lighting2 = Lighting
    lighting2.Ambient = Color3.fromRGB(tonumber(var2[1]), tonumber(var2[2]), tonumber(var2[3]))

    local var3 = not tbl1.colorShiftBottom and { "108", "94", "66" } or tbl1.colorShiftBottom:split(",") or { "108", "94", "66" }

    local var4 = not tbl1.colorShiftTop and { "94", "100", "172" } or tbl1.colorShiftTop:split(",") or { "94", "100", "172" }

    local lighting3 = Lighting
    lighting3.ColorShift_Bottom = Color3.fromRGB(tonumber(var3[1]), tonumber(var3[2]), tonumber(var3[3]))
    local lighting4 = Lighting
    lighting4.ColorShift_Top = Color3.fromRGB(tonumber(var4[1]), tonumber(var4[2]), tonumber(var4[3]))

    local lighting5 = Lighting
    local var5 = if tbl1.environmentDiffuseScale then tonumber(tbl1.environmentDiffuseScale) or 0 else 0
    lighting5.EnvironmentDiffuseScale = var5
    local lighting6 = Lighting
    local var6 = if tbl1.environmentSpecularScale then tonumber(tbl1.environmentSpecularScale) or 1 else 1
    lighting6.EnvironmentSpecularScale = var6

    Lighting.GlobalShadows = not not (tbl1.globalShadows and tbl1.globalShadows == "true")
    local lighting7 = Lighting
    local var7 = if tbl1.shadowSoftness then tonumber(tbl1.shadowSoftness) or 0 else 0
    lighting7.ShadowSoftness = var7

    local var8 = not tbl1.outdoorAmbient and { "0", "0", "0" } or tbl1.outdoorAmbient:split(",") or { "0", "0", "0" }
    local lighting8 = Lighting
    lighting8.OutdoorAmbient = Color3.fromRGB(tonumber(var8[1]), tonumber(var8[2]), tonumber(var8[3]))
    local lighting9 = Lighting
    local var9 = if tbl1.clockTime then tonumber(tbl1.clockTime) or 9.5 else 9.5
    lighting9.ClockTime = var9
    local lighting10 = Lighting
    local var10 = if tbl1.geographicLatitude then tonumber(tbl1.geographicLatitude) or 330 else 330
    lighting10.GeographicLatitude = var10
    local lighting11 = Lighting
    local var11 = if tbl1.exposureCompensation then tonumber(tbl1.exposureCompensation) or 0 else 0
    lighting11.ExposureCompensation = var11
    Lighting.TimeOfDay = tbl1.timeOfDay or "09:30:00"
end

function module.SetupSceneLight(tbl1, str1: string?)
    tbl1 = tbl1 or {}
    local lightType = tbl1.lightType or "SpotLight"
    str1 = str1 or lightType
    local part = Instance.new("Part")
    part.Anchored = true
    part.Transparency = 1
    part.Size = tbl1.partSize or Vector3.new(4, 1, 2)
    part.Shape = tbl1.partType or Enum.PartType.Block
    part.Name = "ThumbnailLightAnchor_" .. tostring(str1)
    part.Parent = workspace

    local instance = Instance.new(lightType)
    instance.Enabled = tbl1.enabled == nil or tbl1.enabled
    instance.Color = tbl1.color or Color3.fromRGB(255, 255, 255)
    instance.Brightness = tbl1.brightness or 10
    instance.Range = tbl1.range or 12
    instance.Angle = tbl1.angle or 30
    instance.Shadows = tbl1.shadows == nil or tbl1.shadows
    instance.Name = tostring(str1)
    instance.Parent = part

    part.CFrame = tbl1.partCFrame
end

function module.SetupSpotLight(tbl1, str1: string?)
    tbl1 = tbl1 or {}
    tbl1.lightType = "SpotLight"
    module.SetupSceneLight(tbl1, str1)
end

function module.SetupSpotLightsIn3PointLighting(tbl1)
    tbl1 = tbl1
        or {
            keyLight = {
                partCFrame = CFrame.new(2.219, 103.178, 4.675) * CFrame.Angles(30, 60, -90),
                color = Color3.fromRGB(218, 196, 144),
                brightness = 11.2,
                range = 12,
                angle = 54
            },
            fillLight = {
                partCFrame = CFrame.new(3.554, 107.01, -1.036) * CFrame.Angles(-15, 90, -90),
                color = Color3.fromRGB(255, 255, 255),
                brightness = 1.6,
                range = 12,
                angle = 36
            }
        }

    if tbl1.keyLight then
        module.SetupSpotLight(tbl1.keyLight, "KeyLight")
    end
    if tbl1.fillLight then
        module.SetupSpotLight(tbl1.fillLight, "FillLight")
    end
end

function module.SetupSpotLightsIn3PointLightingWithJsonConfig(tbl1)
    tbl1 = tbl1
        or {
            rotation = "105",
            keyCFrame = "2.219,103.178,4.675,30,60,-90",
            keyBrightness = "11.2",
            keyRange = "12",
            keyAngle = "54",
            keyColor = "218,196,144",
            fillCFrame = "3.554,107.01,-1.036,-15,90,-90",
            fillBrightness = "1.6",
            fillRange = "12",
            fillAngle = "36",
            fillColor = "255,255,255"
        }
    local var1 = if tbl1.rotation then tonumber(tbl1.rotation) or 105 else 105
    local cFrame = CFrame.Angles(0, math.rad(var1), 0)

    local var2 = not tbl1.keyCFrame and {
        "2.219",
        "103.178",
        "4.675",
        "30",
        "60",
        "-90"
    }
        or tbl1.keyCFrame:split(",")
        or {
            "2.219",
            "103.178",
            "4.675",
            "30",
            "60",
            "-90"
        }

    local var3 = CFrame.new(tonumber(var2[1]) or 0, tonumber(var2[2]) or 0, tonumber(var2[3]) or 0)

    local angles = CFrame.Angles
    local num1 = math.rad(tonumber(var2[4]) or 0)
    local num2 = math.rad(tonumber(var2[5]) or 0)
    local num3 = tonumber(var2[6]) or 0
    local cFrame2 = cFrame:ToWorldSpace(var3 * angles(num1, num2, math.rad(num3)))

    local var4 = not tbl1.fillCFrame and {
        "3.554",
        "107.01",
        "-1.036",
        "-15",
        "90",
        "-90"
    }
        or tbl1.fillCFrame:split(",")
        or {
            "3.554",
            "107.01",
            "-1.036",
            "-15",
            "90",
            "-90"
        }

    local var5 = CFrame.new(tonumber(var4[1]) or 0, tonumber(var4[2]) or 0, tonumber(var4[3]) or 0)

    local angles2 = CFrame.Angles
    local num4 = math.rad(tonumber(var4[4]) or 0)
    local num5 = math.rad(tonumber(var4[5]) or 0)
    local num6 = tonumber(var4[6]) or 0
    local cFrame3 = cFrame:ToWorldSpace(var5 * angles2(num4, num5, math.rad(num6)))
    local var6 = if tbl1.keyBrightness then tonumber(tbl1.keyBrightness) or 11.2 else 11.2
    local var7 = if tbl1.keyRange then tonumber(tbl1.keyRange) or 12 else 12
    local var8 = if tbl1.keyAngle then tonumber(tbl1.keyAngle) or 54 else 54
    local var9 = not tbl1.keyColor and { "218", "196", "144" } or tbl1.keyColor:split(",") or { "218", "196", "144" }
    local var10 = if tbl1.fillBrightness then tonumber(tbl1.fillBrightness) or 1.6 else 1.6
    local var11 = if tbl1.fillRange then tonumber(tbl1.fillRange) or 12 else 12
    local var12 = if tbl1.fillAngle then tonumber(tbl1.fillAngle) or 36 else 36
    local var13 = tbl1.fillColor and tbl1.fillColor:split(",") or { "255", "255", "255" }

    module.SetupSpotLightsIn3PointLighting({
        keyLight = {
            partCFrame = cFrame2,
            color = Color3.fromRGB(tonumber(var9[1]), tonumber(var9[2]), tonumber(var9[3])),
            brightness = var6,
            range = var7,
            angle = var8
        },
        fillLight = {
            partCFrame = cFrame3,
            color = Color3.fromRGB(tonumber(var13[1]), tonumber(var13[2]), tonumber(var13[3])),
            brightness = var10,
            range = var11,
            angle = var12
        }
    })
end

return module
