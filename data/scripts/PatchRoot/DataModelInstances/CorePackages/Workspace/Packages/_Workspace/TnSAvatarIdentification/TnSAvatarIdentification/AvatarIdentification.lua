-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:11:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TnSAvatarIdentification = script:FindFirstAncestor("TnSAvatarIdentification")

local GetFIntReportAnythingAvatarIdentificationCloseDiscardDistanceHundredths = require(TnSAvatarIdentification.Flags.GetFIntReportAnythingAvatarIdentificationCloseDiscardDistanceHundredths)

local GetFIntReportAnythingAvatarIdentificationDiscardFractionSkipThresholdPercent = require(TnSAvatarIdentification.Flags.GetFIntReportAnythingAvatarIdentificationDiscardFractionSkipThresholdPercent)

local GetFIntReportAnythingAvatarIdentificationOffScreenDiscardDistancePercent = require(TnSAvatarIdentification.Flags.GetFIntReportAnythingAvatarIdentificationOffScreenDiscardDistancePercent)
local Players = game:GetService("Players")

local TnSAvatarIdentificationParent = TnSAvatarIdentification.Parent
local GetFFlagGetHumanoidDescriptionUpdatesV2E = require(TnSAvatarIdentificationParent.SharedFlags).GetFFlagGetHumanoidDescriptionUpdatesV2E

local GetHumanoidDescription = require(TnSAvatarIdentificationParent.GetHumanoidDescription)

local IdentificationUtils = require(script.Parent.IdentificationUtils)

local var1 = GetFIntReportAnythingAvatarIdentificationCloseDiscardDistanceHundredths() / 100
local var2 = GetFIntReportAnythingAvatarIdentificationOffScreenDiscardDistancePercent() / 100
local var3 = GetFIntReportAnythingAvatarIdentificationDiscardFractionSkipThresholdPercent() / 100

local module = {}

function getBBCorners(cFrame: CFrame, vec1: vector)
    local var4 = table.create(8)

    local xVector = cFrame.XVector
    local yVector = cFrame.YVector
    local zVector = cFrame.ZVector
    local num1 = 1
    for i = -0.5, 0.5 do
        local var5 = xVector * i * vec1.X
        for j = -0.5, 0.5 do
            local var6 = yVector * j * vec1.Y
            for k = -0.5, 0.5 do
                local var7 = zVector * k * vec1.Z

                var4[num1] = cFrame.Position + var5 + var6 + var7
                num1 += 1
            end
        end
    end
    return var4
end

local var4 = var2 + 1
local var5 = -var2
local function func1(vector2: Vector2): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    local vector2Y = vector2.Y
    local bool1

    if var4 < vector2Y or vector2.Y < var5 then
        bool1 = true
    else
        local vector2X = vector2.X
        bool1 = var4 < vector2X or vector2.X < var5
    end

    return bool1
end

local tbl1 = { total = 0, offScreenDiscardCount = 0, tooCloseDiscardCount = 0, wasSkipped = false }

function getCoveringPolygon(tbl2, currentCamera, viewportInfo)
    if #tbl2 == 0 then
        return {}, tbl1
    end

    local tbl3 = {}

    for _, value in ipairs(tbl2) do
        local target = value.target

        local extentsCFrame = target.ExtentsCFrame
        local extentsSize = target.ExtentsSize
        for _, value2 in (getBBCorners(extentsCFrame, extentsSize)) do
            table.insert(tbl3, value2)
        end
    end

    local tbl4 = {}
    local num1 = 0
    local num2 = 0
    assert(viewportInfo, "getCoveringPolygon requires viewportInfo")
    for _, value in ipairs(tbl3) do
        local var6, var7, _ = IdentificationUtils.worldToFullViewportPointNormalized(value, currentCamera, viewportInfo)

        if var7 < var1 then
            num1 += 1
        elseif func1(var6) then
            num2 += 1
        else
            tbl4[#tbl4 + 1] = var6
        end
    end

    local tbl5 = {
        total = #tbl3,
        offScreenDiscardCount = num2,
        tooCloseDiscardCount = num1,
        wasSkipped = false
    }

    if not ((num1 + num2) / #tbl3 > var3) then
        return getConvexHull(tbl4), tbl5
    end

    tbl5.wasSkipped = true
    return {}, tbl5
end

function getDistanceAlongCamLookVector(cFrame: CFrame, currentCamera)
    local currentCameraCFrame = currentCamera.CFrame

    return ((cFrame.Position - currentCameraCFrame.Position):Dot(currentCameraCFrame.LookVector))
end

function getVisibleParts(currentCamera, player, filterDescendantsInstances)
    local currentCameraCFramePosition = currentCamera.CFrame.Position

    local character = player.Character
    if not (character and character.Parent) then
        return 0, {}
    end

    local children = character:GetChildren()
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
    raycastParams.FilterDescendantsInstances = filterDescendantsInstances
    raycastParams.IgnoreWater = true

    local num1 = 0
    local tbl2 = {}
    for _, target in ipairs(children) do
        if not target:IsA("BasePart") then
            continue
        end

        local direction = target.CFrame.Position - currentCameraCFramePosition

        num1 += 1
        local raycastResult = workspace:Raycast(currentCameraCFramePosition, direction, raycastParams)
        if raycastResult and raycastResult.Instance:IsDescendantOf(character) then
            table.insert(tbl2, { result = raycastResult, target = target })
        end
    end

    return num1, tbl2
end

local function counterclockwise(vector2: Vector2, vector2_2: Vector2, vector2_3: Vector2) -- Luacid: Inlined by compiler; 1 call site recovered
    return (vector2_2 - vector2):Cross(vector2_3 - vector2_2)
end

function getConvexHull(tbl2)
    if #tbl2 <= 2 then
        return {}
    end

    local convexHull = {}
    local var6 = tbl2[1]
    local tbl3 = {}
    for i = 2, #tbl2 do
        local var7 = tbl2[i]
        if var7.Y < var6.Y or var7.Y == var6.Y and var7.X < var6.X then
            var6 = var7
        end
    end

    table.insert(convexHull, var6)
    local function angleFromLowest(vector2: Vector2): number -- Luacid: Inlined by compiler; 1 call site recovered
        local var7 = vector2 - var6
        return math.atan2(var7.Y, var7.X)
    end

    for _, value in ipairs(tbl2) do
        if value ~= var6 then
            table.insert(tbl3, Vector3.new(value.X, value.Y, (angleFromLowest(value))))
        end
    end
    table.sort(tbl3, function(vec1: vector, vec2: vector): boolean -- name: compareByAngle
        if vec1.Z == vec2.Z then
            return (Vector2.new(vec1.X, vec1.Y) - var6).Magnitude < (Vector2.new(vec2.X, vec2.Y) - var6).Magnitude
        end

        return vec1.Z < vec2.Z
    end)

    local tbl4 = {}

    local var7 = tbl3[1]
    local var8 = var7

    for i = 2, #tbl3 do
        var7 = tbl3[i]
        if var8.Z ~= var7.Z then
            table.insert(tbl4, Vector2.new(var8.X, var8.Y))
        end

        var8 = var7
    end

    table.insert(tbl4, Vector2.new(var8.X, var8.Y))

    if #tbl4 == 1 then
        return {}
    end

    table.insert(convexHull, tbl4[1])
    table.insert(convexHull, tbl4[2])
    for i = 3, #tbl4 do
        local var9 = tbl4[i]
        while #convexHull > 1 and counterclockwise(convexHull[#convexHull - 1], convexHull[#convexHull], var9) <= 0 do
            table.remove(convexHull)
        end
        table.insert(convexHull, var9)
    end
    return convexHull
end

function projectVertices(convexHull, vector2: Vector2, vector2_2: Vector2)
    local huge = math.huge
    local huge2 = -math.huge

    for _, value in ipairs(convexHull) do
        local var6 = (value * vector2_2):Dot(vector2)

        if var6 < huge then
            huge = var6
        end

        if huge2 < var6 then
            huge2 = var6
        end
    end

    return huge, huge2
end

function projectCircle(vector2: Vector2, num1: number, vector2_2: Vector2)
    local var6 = vector2_2.Unit * num1

    local var7 = vector2 + var6
    local var8 = vector2 - var6

    local var9 = var7:Dot(vector2_2)
    local var10 = var8:Dot(vector2_2)

    if var10 < var9 then
        local var11 = var10
        var10 = var9
        var9 = var11
    end

    return var9, var10
end

function getClosestPoint(vector2: Vector2, convexHull, vector2_2: Vector2)
    local num1 = -1
    local huge = math.huge
    for i, value in ipairs(convexHull) do
        local var6 = value * vector2_2
        local num2 = math.sqrt(math.pow(var6.X - vector2.X, 2) + math.pow(var6.Y - vector2.Y, 2))
        if num2 < huge then
            num1 = i
            huge = num2
        end
    end

    return num1
end

function intersectCirclePolygon(vector2: Vector2, num1: number, convexHull, vector2_2: Vector2)
    for i, _ in ipairs(convexHull) do
        local var6 = convexHull[i] * vector2_2
        local var7 = convexHull[i % #convexHull + 1] * vector2_2 - var6

        local unit = Vector2.new(var7.Y, -var7.X).Unit
        local var8, var9 = projectVertices(convexHull, unit, vector2_2)
        local var10, var11 = projectCircle(vector2, num1, unit)
        if var11 <= var8 or var9 <= var10 then
            return false
        end
    end
    local closestPoint = getClosestPoint(vector2, convexHull, vector2_2)

    if closestPoint == -1 then
        return false
    end

    local unit = (convexHull[closestPoint] - vector2).Unit
    local var6, var7 = projectVertices(convexHull, unit, vector2_2)
    local var8, var9 = projectCircle(vector2, num1, unit)

    return not (var9 <= var6 or var7 <= var8)
end

function intersectCircleBox(vector2: Vector2, num1: number, vector2_2: Vector2, vector2_3: Vector2, _vector2: Vector2): boolean
    local vector2X = vector2.X
    local vector2Y = vector2.Y

    local vector22X = vector2_2.X
    local vector22Y = vector2_2.Y

    local var6 = vector2_3.X - vector2_2.X
    local var7 = vector2_3.Y - vector2_2.Y

    if not (vector2X < vector22X) then
        if vector22X + var6 < vector2X then
            vector22X += var6
        else
            vector22X = vector2X
        end
    end
    if not (vector2Y < vector22Y) then
        if vector22Y + var7 < vector2Y then
            vector22Y += var7
        else
            vector22Y = vector2Y
        end
    end
    local var8 = vector2X - vector22X
    local var9 = vector2Y - vector22Y

    return math.sqrt(var8 * var8 + var9 * var9) <= num1
end

function module.getAvatarsForRegion(tbl2, vector2: Vector2, num1: number, num2: number, num3: number)
    local result = {}

    local bool1 = num3 < num2
    local num4 = if bool1 then num2 / num3 else num3 / num2
    local vector2_2 = if bool1 then Vector2.new(num4, 1) else Vector2.new(1, num4)

    for _, value in pairs(tbl2) do
        if intersectCircleBox(
            vector2 * vector2_2,
            num1 * num4,
            value.boundingBox.min * vector2_2,
            value.boundingBox.max * vector2_2,
            vector2_2
        )
            and not (#value.convexHull < 3)
            and intersectCirclePolygon(vector2 * vector2_2, num1 * num4, value.convexHull, vector2_2)
        then
            result[value.player.UserId] = value.player
        end
    end

    return result
end

function module.getAvatarsForPoint(tbl2, vector2: Vector2)
    local result = {}

    for _, value in pairs(tbl2) do
        local boundingBox = value.boundingBox

        if vector2.X < boundingBox.min.X
            or vector2.Y < boundingBox.min.Y
            or vector2.X > boundingBox.max.X
            or vector2.Y > boundingBox.max.Y
        then
            continue
        end

        local convexHull = value.convexHull
        if #convexHull < 3 then
            continue
        end

        local var6 = convexHull[#convexHull]
        local bool1 = true
        local bool2 = true
        for _, value2 in ipairs(convexHull) do
            local var7 = (value2 - var6):Cross(vector2 - var6)

            bool2 = bool2 and var7 <= 0
            bool1 = bool1 and var7 >= 0
            var6 = value2
        end

        if bool1 or bool2 then
            result[value.player.UserId] = value.player
        end
    end

    return result
end

function module.getVisibleAvatars(bool1: boolean?, num1: number?)
    local players = Players:GetPlayers()
    local tbl2 = { totalPlayers = 0, checkedPlayers = 0, duration = 0 }

    local currentCamera = workspace.CurrentCamera
    if not currentCamera then
        return {}, tbl2
    end

    local localPlayer = Players.LocalPlayer
    if not localPlayer then
        return {}, tbl2
    end

    local character = localPlayer.Character

    local tbl3 = {}
    local var6

    if character then
        var6 = IdentificationUtils.getLocalCharacterPosition(character) or currentCamera.CFrame.Position
        if IdentificationUtils.shouldIgnoreLocalCharacter(character) then
            tbl3[#tbl3 + 1] = character
        end
    else
        var6 = currentCamera.CFrame.Position
    end

    local viewportInfo = IdentificationUtils.getViewportInfo()
    tbl2.viewportInfo = viewportInfo

    local tbl4 = {}
    local startTime = os.clock()
    tbl2.totalPlayers = #players - 1

    local function func2() -- Luacid: Inlined by compiler; 3 call sites recovered
        tbl2.duration = os.clock() - startTime
        return tbl2
    end
    local function _(): boolean -- Luacid: unused: defined but never referenced
        return (num1 or 0.5) < os.clock() - startTime
    end

    if var6 then
        table.sort(players, function(player: Player, player2: Player): boolean
            return player:DistanceFromCharacter(var6) < player2:DistanceFromCharacter(var6)
        end)
    end

    for _, player in ipairs(players) do
        if player == localPlayer and not bool1 or not player.Character then
            continue
        end

        if (num1 or 0.5) < os.clock() - startTime then
            return tbl4, (func2())
        end

        local var7, var8 = player.Character:GetBoundingBox()

        local magnitude = (var7.Position - var6).Magnitude

        if getDistanceAlongCamLookVector(var7, currentCamera) < 0 then
            tbl2.checkedPlayers += 1
        else
            local bBCorners = getBBCorners(var7, var8)

            local min, max = IdentificationUtils.getViewportCorners(bBCorners, currentCamera, viewportInfo)
            if max.X == 0 or max.Y == 0 then
                tbl2.checkedPlayers += 1
            else
                local var11, var12 = getVisibleParts(currentCamera, player, tbl3)

                if (num1 or 0.5) < os.clock() - startTime then
                    return tbl4, (func2())
                end

                local hitRate = #var12 / var11
                local convexHull, pointProcessingStats = getCoveringPolygon(var12, currentCamera, viewportInfo)
                local var16, var17

                if GetFFlagGetHumanoidDescriptionUpdatesV2E() then
                    var16, var17 = GetHumanoidDescription.getHumanoidDescription(player.UserId)
                else
                    var16 = nil
                    var17 = nil
                end

                tbl4[player.UserId] = {
                    player = player,
                    distance = magnitude,
                    boundingBox = { min = min, max = max },
                    hitRate = hitRate,
                    convexHull = convexHull,
                    pointProcessingStats = pointProcessingStats,
                    humanoidDescription = var16,
                    humanoidDescriptionStatus = var17
                }

                tbl2.checkedPlayers += 1
            end
        end
    end

    return tbl4, (func2())
end

return module
