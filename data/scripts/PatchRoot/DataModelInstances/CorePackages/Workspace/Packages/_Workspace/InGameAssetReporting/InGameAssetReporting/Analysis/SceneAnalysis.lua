-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T22:21:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")

local InGameAssetReporting = script:FindFirstAncestor("InGameAssetReporting")

local _Types = require(InGameAssetReporting.Analysis.Types)
local GetFIntIGARRaycastTargetCount = require(InGameAssetReporting.Flags.GetFIntIGARRaycastTargetCount)
local GetFIntIGARSubtreeDivergenceThresholdPerMille = require(InGameAssetReporting.Flags.GetFIntIGARSubtreeDivergenceThresholdPerMille)
local extractAssetIdsFromInstance = require(InGameAssetReporting.Analysis.extractAssetIdsFromInstance)

local random = Random.new()

function getRandomSampleUniformDisk(vector2: Vector2, num1: number, vector2_2: Vector2): Vector2 | Vector2
    local num2 = 0

    while true do
        local num3 = random:NextNumber() * 2 * math.pi
        local num4 = math.sqrt((random:NextNumber())) * num1
        local num5 = math.cos(num3) * num4
        local num6 = math.sin(num3) * num4
        local x = vector2.X + num5
        local y = vector2.Y + num6
        num2 += 1
        if num2 > 6 then
            break
        end

        if x >= 0 and x <= vector2_2.X and y >= 0 and y <= vector2_2.Y then
            return Vector2.new(x, y)
        end
    end

    return vector2
end

function interpretAnnotation(vector2: Vector2, num1: number, callback: (...any) -> (...any))
    local bool1 = false

    local tbl1 = {
        hitCountMap = {},
        stats = {
            targetCount = GetFIntIGARRaycastTargetCount(),
            completedCount = 0,
            hitCount = 0,
            resumptionCount = 0,
            wallTime = 0,
            computeTime = 0
        },
        highlights = {},
        topLevelObjects = {},
        errorReason = nil,
        cancel = function()
            bool1 = true
        end
    }

    tbl1.raycastComputation = coroutine.create(function()
        callback(tbl1)
    end)

    local currentCamera = workspace.CurrentCamera
    if currentCamera == nil then
        tbl1.errorReason = "No camera"
        return tbl1
    end

    local viewportSize = currentCamera.ViewportSize

    if vector2.X < 0 or vector2.X > viewportSize.X or vector2.Y < 0 or vector2.Y > viewportSize.Y then
        tbl1.errorReason = "Coordinates out of bounds"
        return tbl1
    end

    if num1 <= 0 or math.max(viewportSize.X, viewportSize.Y) < num1 then
        tbl1.errorReason = "Invalid radius"
        return tbl1
    end

    local localPlayer = Players.LocalPlayer
    if localPlayer == nil then
        tbl1.errorReason = "No local player"
        return tbl1
    end

    local filterDescendantsInstances = { localPlayer.Character }

    tbl1.raycastComputation = coroutine.create(function()
        local raycastParams = RaycastParams.new()
        raycastParams.FilterType = Enum.RaycastFilterType.Exclude
        raycastParams.FilterDescendantsInstances = filterDescendantsInstances
        raycastParams.IgnoreWater = true

        local startTime = os.clock()
        local num2 = os.clock()

        for _ = 1, tbl1.stats.targetCount do
            if bool1 then
                break
            end

            if num2 + 1 / 90 < os.clock() then
                local stats = tbl1.stats
                stats.computeTime += os.clock() - num2
                task.wait()
                num2 = os.clock()
                local stats2 = tbl1.stats
                stats2.resumptionCount += 1
                if bool1 then
                    break
                end
            end

            local randomSampleUniformDisk = getRandomSampleUniformDisk(vector2, num1, viewportSize)

            local ray = currentCamera:ViewportPointToRay(randomSampleUniformDisk.X, randomSampleUniformDisk.Y)
            local var1 = nil

            for _ = 1, 5 do
                var1 = workspace:Raycast(ray.Origin, ray.Direction * 5000, raycastParams)
                if var1 == nil then
                    break
                end

                local instance = var1.Instance
                if (1 - instance.Transparency) * (1 - instance.LocalTransparencyModifier) > 0.05 then
                    break
                end

                table.insert(filterDescendantsInstances, instance)
                raycastParams.FilterDescendantsInstances = filterDescendantsInstances
                var1 = nil
            end

            if var1 then
                local instance = var1.Instance
                local var2

                if instance == nil then
                    var2 = nil
                else
                    local stats = tbl1.stats
                    stats.hitCount += 1
                    var2 = nil
                end

                while instance ~= nil and (instance:IsA("PVInstance") or instance:IsA("Accessory")) and instance ~= workspace do
                    if not tbl1.hitCountMap[instance] then
                        tbl1.hitCountMap[instance] = {
                            raycastHits = 0,
                            children = {}
                        }
                    end
                    local var3 = tbl1.hitCountMap[instance]
                    var3.raycastHits += 1
                    if var2 then
                        tbl1.hitCountMap[instance].children[var2] = true
                    end

                    local instanceParent = instance.Parent
                    var2 = instance
                    instance = instanceParent
                end

                if var2 then
                    tbl1.topLevelObjects[var2] = (tbl1.topLevelObjects[var2] or 0) + 1
                end
            end
            local stats = tbl1.stats
            stats.completedCount += 1
        end

        tbl1.stats.wallTime = os.clock() - startTime
        local stats = tbl1.stats
        stats.computeTime += os.clock() - num2

        callback(tbl1)
    end)

    return tbl1
end

function createPlayerCharacterReferenceToPlayerMap(players)
    local playerCharacterReferenceToPlayerMap = ({})
    for _, player in ipairs(players) do
        local character = player.Character
        if character then
            playerCharacterReferenceToPlayerMap[character] = player
        end
    end
    return playerCharacterReferenceToPlayerMap
end

function descendingOrderBySecondElement(tbl1, tbl2): boolean
    return tbl1[2] > tbl2[2]
end

function createTraversalTaskList(tbl1, tbl2)
    local tbl3 = {}
    local tbl4 = {}
    local playerCharacterReferenceToPlayerMap = createPlayerCharacterReferenceToPlayerMap(Players:GetPlayers())

    local tbl5 = {}
    for k, value in pairs(tbl2) do
        table.insert(tbl5, { k, value })
    end
    table.sort(tbl5, descendingOrderBySecondElement)

    local var1 = GetFIntIGARSubtreeDivergenceThresholdPerMille() / 1000
    for _, value in ipairs(tbl5) do
        local var2 = value[1]
        local count = value[2]

        if playerCharacterReferenceToPlayerMap[var2] == nil then
            local instance = var2
            local num1 = 0

            while tbl1[var2] do
                local var5 = tbl1[var2]
                local raycastHits = var5.raycastHits
                local children = var5.children
                local num2 = 0
                for k, _ in pairs(children) do
                    if tbl1[k] then
                        num2 += 1
                    end
                end
                if num2 == 0 then
                    break
                end

                local num3 = 0
                for k, _ in pairs(children) do
                    if tbl1[k] then
                        num3 = math.max(num3, tbl1[k].raycastHits)
                    end
                end

                if num3 / raycastHits < var1 then
                    break
                end

                var2 = nil
                local num4 = 0
                for k, _ in pairs(children) do
                    if tbl1[k] and num4 < tbl1[k].raycastHits then
                        num4 = tbl1[k].raycastHits
                        var2 = k
                    end
                end

                num1 += 1
            end

            table.insert(tbl3, { instance = var2, count = count })

            if var2 ~= instance then
                table.insert(tbl3, { instance = instance, count = count })
            end
        else
            table.insert(tbl4, { player = playerCharacterReferenceToPlayerMap[var2], count = count })
        end
    end

    return tbl3, tbl4
end

function mutateMergeExtractedAssets(tbl1, extractedAssets, arg1)
    for _, value in ipairs(arg1.Image) do
        if not tbl1[value] then
            tbl1[value] = true
            table.insert(extractedAssets.Image, value)
        end
    end

    for _, value in ipairs(arg1.Mesh) do
        if not tbl1[value] then
            tbl1[value] = true
            table.insert(extractedAssets.Mesh, value)
        end
    end

    for _, value in ipairs(arg1.Video) do
        if not tbl1[value] then
            tbl1[value] = true
            table.insert(extractedAssets.Video, value)
        end
    end

    for _, value in ipairs(arg1.Model) do
        if not tbl1[value] then
            tbl1[value] = true
            table.insert(extractedAssets.Model, value)
        end
    end

    for _, value in ipairs(arg1.Package) do
        if not tbl1[value.id] then
            tbl1[value.id] = true
            table.insert(extractedAssets.Package, value)
        end
    end
    if not game:GetEngineFeature("ExperienceStateCaptureExperienceChatSupport") then
        return
    end

    for _, value in ipairs(arg1.Text) do
        if not tbl1[value] then
            tbl1[value] = true
            table.insert(extractedAssets.Text, value)
        end
    end
end

function interpretInstanceListForGUIObjects(tbl1)
    local tbl2 = {
        hitCountMap = {},
        stats = {
            targetCount = 0,
            completedCount = 0,
            hitCount = 0,
            resumptionCount = 0,
            wallTime = 0,
            computeTime = 0
        },
        highlights = {},
        topLevelObjects = {},
        errorReason = nil,
        cancel = function() end
    }
    for _, value in ipairs(tbl1) do
        local var1 = value
        local var2 = nil

        while var1 ~= nil and var1:IsA("GuiObject") do
            if not tbl2.hitCountMap[var1] then
                tbl2.hitCountMap[var1] = {
                    raycastHits = 0,
                    children = {}
                }
            end
            local var3 = tbl2.hitCountMap[var1]
            var3.raycastHits += 1
            if var2 then
                tbl2.hitCountMap[var1].children[var2] = true
            end

            local parent = var1.Parent
            var2 = var1
            var1 = parent
        end

        if var2 then
            tbl2.topLevelObjects[var2] = (tbl2.topLevelObjects[var2] or 0) + 1
        end
    end

    return tbl2
end

function interpretAndExtractItemsFromInstanceForPreciseSelection(arg1)
    local tbl1 = {
        extractedAssets = {
            Package = {},
            Model = {},
            Image = {},
            Mesh = {},
            Text = {},
            Video = {}
        },
        extractedPlayers = {},
        cancel = function() end,
        stats = {
            hitCountMapSize = 0,
            topLevelObjectsSize = 0,
            instancesTraversed = 0,
            traversalTaskListSize = 0,
            traversalTasksCompleted = 0,
            playersCount = 0,
            resumptionCount = 0,
            wallTime = 0,
            computeTime = 0,
            raycastTargetCount = 0,
            raycastCompletedCount = 0,
            raycastResumptionCount = 0,
            raycastComputeTime = 0
        }
    }

    tbl1.computation = coroutine.create(function() end)

    if not arg1 then
        return tbl1
    end

    local tbl2 = {}
    local function func1(arg2) -- Luacid: Inlined by compiler; 2 call sites recovered
        local var1 = extractAssetIdsFromInstance(arg2)
        if var1 then
            mutateMergeExtractedAssets(tbl2, tbl1.extractedAssets, var1)
        end
        local stats = tbl1.stats
        stats.instancesTraversed += 1
    end

    local playerCharacterReferenceToPlayerMap = createPlayerCharacterReferenceToPlayerMap(Players:GetPlayers())
    local var1 = arg1

    while arg1 ~= nil
        and (arg1:IsA("PVInstance") or arg1:IsA("Accessory") or arg1:IsA("GuiObject") or arg1:IsA("FaceInstance"))
        and arg1 ~= workspace do
        if playerCharacterReferenceToPlayerMap[arg1] ~= nil then
            table.insert(tbl1.extractedPlayers, { player = playerCharacterReferenceToPlayerMap[arg1], count = 1 })

            return tbl1
        end

        func1(arg1)
        arg1 = arg1.Parent
    end

    local children = var1:GetChildren()
    for _, child in ipairs(children) do
        func1(child)
    end

    return tbl1
end

function extractItemsFromInterpretations(tbl1, callback: (...any) -> (...any))
    local bool1 = false

    local tbl2 = {
        extractedAssets = {
            Package = {},
            Model = {},
            Image = {},
            Mesh = {},
            Text = {},
            Video = {}
        },
        extractedPlayers = {},
        cancel = function()
            bool1 = true
        end,
        stats = {
            hitCountMapSize = 0,
            topLevelObjectsSize = 0,
            instancesTraversed = 0,
            traversalTaskListSize = 0,
            traversalTasksCompleted = 0,
            playersCount = 0,
            resumptionCount = 0,
            wallTime = 0,
            computeTime = 0,
            raycastTargetCount = 0,
            raycastCompletedCount = 0,
            raycastResumptionCount = 0,
            raycastComputeTime = 0
        }
    }

    tbl2.computation = coroutine.create(function()
        callback(tbl2)
    end)
    for _, value in ipairs(tbl1) do
        value.cancel()
        local stats = tbl2.stats
        stats.raycastTargetCount += value.stats.targetCount
        local stats2 = tbl2.stats
        stats2.raycastCompletedCount += value.stats.completedCount
        local stats3 = tbl2.stats
        stats3.raycastResumptionCount += value.stats.resumptionCount
        local stats4 = tbl2.stats
        stats4.raycastComputeTime += value.stats.computeTime
    end

    local startTime = os.clock()

    local tbl3 = ({})
    local tbl4 = ({})
    for _, value in ipairs(tbl1) do
        for k, value2 in pairs(value.hitCountMap) do
            if not tbl3[k] then
                tbl3[k] = {
                    raycastHits = 0,
                    children = {}
                }
                local stats = tbl2.stats
                stats.hitCountMapSize += 1
            end
            local var1 = tbl3[k]
            var1.raycastHits += value2.raycastHits
            for k2, _ in pairs(value2.children) do
                tbl3[k].children[k2] = true
            end
        end
        for k, topLevelObject in pairs(value.topLevelObjects) do
            local var1 = tbl4[k]
            if not var1 then
                local stats = tbl2.stats
                stats.topLevelObjectsSize += 1
            end
            tbl4[k] = (var1 or 0) + topLevelObject
        end
    end

    local var1, extractedPlayers = createTraversalTaskList(tbl3, tbl4)

    tbl2.extractedPlayers = extractedPlayers
    tbl2.stats.playersCount = #extractedPlayers

    tbl2.stats.wallTime = os.clock() - startTime
    tbl2.stats.traversalTaskListSize = #var1

    tbl2.computation = coroutine.create(function()
        local startTime2 = os.clock()
        local num1 = os.clock()
        local function func1(): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
            return num1 + 1 / 90 < os.clock()
        end
        local function func2() -- Luacid: Inlined by compiler; 2 call sites recovered
            local stats = tbl2.stats
            stats.computeTime += os.clock() - num1
            task.wait()
            num1 = os.clock()
            local stats2 = tbl2.stats
            stats2.resumptionCount += 1
        end

        local tbl5 = {}
        local tbl6 = ({})
        for _, value in ipairs(var1) do
            local tbl7 = {}

            table.insert(tbl7, value.instance)
            local tbl8 = {}

            while #tbl7 > 0 do
                if func1() then
                    func2()

                    if bool1 then
                        local stats = tbl2.stats
                        stats.wallTime += os.clock() - startTime2
                        callback(tbl2)
                        return
                    end
                end

                local var3 = table.remove(tbl7)

                if tbl6[var3] then
                    continue
                end

                table.insert(tbl8, var3)

                local children = var3:GetChildren()
                local tbl9 = {}
                for _, child in pairs(children) do
                    table.insert(tbl9, { child, if tbl3[child] then tbl3[child].raycastHits else 0 })
                end

                table.sort(tbl9, descendingOrderBySecondElement)

                for _, value2 in ipairs(tbl9) do
                    table.insert(tbl7, value2[1])
                end

                tbl6[var3] = true
            end

            while #tbl8 > 0 do
                if func1() then
                    func2()

                    if bool1 then
                        local stats = tbl2.stats
                        stats.wallTime += os.clock() - startTime2
                        callback(tbl2)
                        return
                    end
                end
                local var3 = table.remove(tbl8)

                local var4 = extractAssetIdsFromInstance(var3)
                if var4 then
                    mutateMergeExtractedAssets(tbl5, tbl2.extractedAssets, var4)
                end
                local stats = tbl2.stats
                stats.instancesTraversed += 1
            end
            local stats = tbl2.stats
            stats.traversalTasksCompleted += 1
        end

        local stats = tbl2.stats
        stats.wallTime += os.clock() - startTime2
        local stats2 = tbl2.stats
        stats2.computeTime += os.clock() - num1
        callback(tbl2)
    end)

    return tbl2
end

return {
    interpretAnnotation = interpretAnnotation,
    extractItemsFromInterpretations = extractItemsFromInterpretations,
    interpretInstanceListForGUIObjects = interpretInstanceListForGUIObjects,
    interpretAndExtractItemsFromInstanceForPreciseSelection = interpretAndExtractItemsFromInstanceForPreciseSelection,
    __setRandomGenerator = function(arg1)
        random = arg1
    end
}
