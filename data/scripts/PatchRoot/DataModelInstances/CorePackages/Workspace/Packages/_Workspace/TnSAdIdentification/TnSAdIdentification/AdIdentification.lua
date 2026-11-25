-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:10:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AdService = game:GetService("AdService")
local Players = game:GetService("Players")

local TnSAdIdentification = script:FindFirstAncestor("TnSAdIdentification")

local GetFIntAdIdentificationMinimumAreaPerMyriad = require(TnSAdIdentification.Flags.GetFIntAdIdentificationMinimumAreaPerMyriad)

local GetFIntAdIdentifiedTelemetryThrottleHundredthsPercent = require(TnSAdIdentification.Flags.GetFIntAdIdentifiedTelemetryThrottleHundredthsPercent)

local TnSAdIdentificationParent = TnSAdIdentification.Parent
local LoggingProtocol = require(TnSAdIdentificationParent.LoggingProtocol)
local default = LoggingProtocol.default

local IdentificationUtils = require(TnSAdIdentificationParent.AvatarIdentification).IdentificationUtils

local num1 = math.max(GetFIntAdIdentificationMinimumAreaPerMyriad() / 10000, 0)

local module = {}

function getLocalCharacterPosition(character)
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    return if humanoidRootPart then humanoidRootPart.Position else nil
end

function checkVisibility(camera, instance, assetCorners, filterDescendantsInstances): number
    local cameraCFramePosition = camera.CFrame.Position
    local viewportSize = camera.ViewportSize

    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
    raycastParams.FilterDescendantsInstances = filterDescendantsInstances
    raycastParams.IgnoreWater = true

    local num2 = 0
    local num3 = 0

    local var1 = assetCorners[2] - assetCorners[1]
    local var2 = assetCorners[3] - assetCorners[1]

    for i = 1, 4 do
        local var3 = var1 * (i - 0.5) / 4
        for j = 1, 4 do
            local var4 = assetCorners[1] + var3 + var2 * (j - 0.5) / 4
            local var5 = var4 - cameraCFramePosition

            num2 += 1

            local var6, _ = camera:WorldToViewportPoint(var4)

            if var6.Z < 0 or var6.X < 0 or var6.Y < 0 or var6.X > viewportSize.X or var6.Y > viewportSize.Y then
                continue
            end

            local raycastResult = workspace:Raycast(cameraCFramePosition, var5 * 1.1, raycastParams)

            if raycastResult and raycastResult.Instance == instance then
                num3 += 1
            end
        end
    end

    return num3 / num2
end

function createSingleVisibleRegionFromWorldSpaceCorners(assetCorners, currentCamera, viewportInfo)
    local var1 = table.create(#assetCorners)
    for i, assetCorner in ipairs(assetCorners) do
        local var2, _, _ = IdentificationUtils.worldToFullViewportPointNormalized(assetCorner, currentCamera, viewportInfo)
        var1[i] = Vector2.new(var2.X, var2.Y)
    end

    return {
        convexHull = {
            var1[1],
            var1[2],
            var1[4],
            var1[3]
        },
        id = 1
    }
end

function getAdCenterAndScreenArea(assetCorners, camera)
    local viewportSize = camera.ViewportSize
    local vec3 = Vector3.new(0, 0, 0)
    local num2 = 0
    local tbl1 = {}

    for _, assetCorner in ipairs(assetCorners) do
        vec3 += assetCorner
        local var1, _ = camera:WorldToViewportPoint(assetCorner)
        table.insert(tbl1, Vector2.new(var1.X, var1.Y) / viewportSize)
    end

    return vec3 / 4, (num2 + math.abs(((tbl1[2] - tbl1[1]):Cross(tbl1[3] - tbl1[1]))) + math.abs(((tbl1[2] - tbl1[4]):Cross(tbl1[3] - tbl1[4])))) / 2
end

function module.getAdsForPoint(tbl1, vector2: Vector2)
    local result = ({})
    for k, value in pairs(tbl1) do
        local boundingBox = value.boundingBox

        if vector2.X < boundingBox.min.X
            or vector2.Y < boundingBox.min.Y
            or vector2.X > boundingBox.max.X
            or vector2.Y > boundingBox.max.Y
        then
            continue
        end

        for _, visibleRegion in ipairs(value.visibleRegions) do
            local convexHull = visibleRegion.convexHull
            if #convexHull < 3 then
                continue
            end

            local var1 = convexHull[#convexHull]
            local bool1 = true
            local bool2 = true
            for _, value2 in ipairs(convexHull) do
                local var2 = (value2 - var1):Cross(vector2 - var1)

                bool2 = bool2 and var2 <= 0
                bool1 = bool1 and var2 >= 0
                var1 = value2
            end

            if bool1 or bool2 then
                result[k] = value
                break
            end
        end
    end

    return result
end

function module.getVisibleAds()
    local tbl1 = ({})
    local tbl2 = { totalAds = 0, checkedAds = 0, duration = 0 }

    local reportAdInfo = AdService:GetReportAdInfo()

    local currentCamera = workspace.CurrentCamera
    if not currentCamera then
        return tbl1, tbl2
    end

    local localPlayer = Players.LocalPlayer
    if not localPlayer then
        return tbl1, tbl2
    end

    local character = localPlayer.Character

    local tbl3 = {}
    local var1 = if character then getLocalCharacterPosition(character) or currentCamera.CFrame.Position else currentCamera.CFrame.Position
    local viewportInfo = IdentificationUtils.getViewportInfo()
    tbl2.viewportInfo = viewportInfo

    local startTime = os.clock()
    tbl2.totalAds = #reportAdInfo

    local function func1() -- Luacid: Inlined by compiler; 3 call sites recovered
        tbl2.duration = os.clock() - startTime
        return tbl2
    end

    local function func2(): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
        return os.clock() - startTime > 0.2
    end
    local num2 = 1
    for _, value in ipairs(reportAdInfo) do
        if func2() then
            return tbl1, (func1())
        end

        local basePart = value.basePart
        local adUnitName = value.adUnitName
        local assetId = value.assetId
        local encryptedAdTrackingData = value.encryptedAdTrackingData
        local encryptionMetadata = value.encryptionMetadata

        if encryptedAdTrackingData == "" or encryptionMetadata == "" or assetId == "11307989327" then
            tbl2.checkedAds += 1
        else
            local assetCorners = value.assetCorners
            if not assetCorners or #assetCorners < 4 then
                tbl2.checkedAds += 1
            else
                local var2, var3 = getAdCenterAndScreenArea(assetCorners, currentCamera)

                local magnitude = (var2 - var1).Magnitude

                if (var2 - currentCamera.CFrame.Position):Dot(currentCamera.CFrame.LookVector) < 0 then
                    tbl2.checkedAds += 1
                else
                    local unit = (assetCorners[1] - assetCorners[2]):Cross(assetCorners[1] - assetCorners[3]).Unit

                    if unit:Dot(var2 - basePart.Position) < 0 then
                        unit = -unit
                    end

                    if (currentCamera.CFrame.Position - var2):Dot(unit) < 0 then
                        tbl2.checkedAds += 1
                    else
                        local min, max = IdentificationUtils.getViewportCorners(assetCorners, currentCamera, viewportInfo)

                        if min == IdentificationUtils.defaultMin or var3 < num1 then
                            tbl2.checkedAds += 1
                        else
                            local hitRate = checkVisibility(currentCamera, basePart, assetCorners, tbl3)
                            if hitRate < 0.3 then
                                tbl2.checkedAds += 1
                            else
                                if func2() then
                                    return tbl1, (func1())
                                end

                                local tbl4 = {
                                    distance = magnitude,
                                    boundingBox = { min = min, max = max },
                                    hitRate = hitRate,
                                    visibleRegions = { createSingleVisibleRegionFromWorldSpaceCorners(assetCorners, currentCamera, viewportInfo) },
                                    adUnitName = adUnitName,
                                    assetId = assetId,
                                    encryptedAdTrackingData = encryptedAdTrackingData,
                                    encryptionMetadata = encryptionMetadata
                                }
                                tbl1[num2] = tbl4

                                default:logRobloxTelemetryEvent(
                                    {
                                        eventName = "AdIdentifiedInAbuseReport",
                                        backends = { LoggingProtocol.TelemetryBackends.Points },
                                        throttlingPercentage = GetFIntAdIdentifiedTelemetryThrottleHundredthsPercent(),
                                        lastUpdated = { 24, 6, 25 },
                                        description = "Ad Identified in Report Anything Screenshot"
                                    },
                                    nil,
                                    {
                                        assetId = assetId,
                                        encryptedAdTrackingData = encryptedAdTrackingData,
                                        encryptionMetadata = encryptionMetadata
                                    }
                                )

                                tbl2.checkedAds += 1
                                num2 += 1
                            end
                        end
                    end
                end
            end
        end
    end

    return tbl1, (func1())
end

return module
