-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:21:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function toScreenPoint(input: InputObject): Vector2 -- Luacid: Inlined by compiler; 3 call sites recovered
    return Vector2.new(input.Position.X, input.Position.Y)
end

local function raycast(camera, world, vector2: Vector2)
    local var1 = camera:ScreenPointToRay(vector2.X, vector2.Y)
    local filterDescendantsInstances = {}
    local terrain = world:FindFirstChildWhichIsA("Terrain")
    if terrain ~= nil then
        table.insert(filterDescendantsInstances, terrain)
    end
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
    raycastParams.BruteForceAllSlow = true
    for _ = 1, 50 do
        raycastParams.FilterDescendantsInstances = filterDescendantsInstances
        local var2 = world:Raycast(var1.Origin, var1.Direction * 1000, raycastParams)
        if var2 == nil then
            return nil
        end
        local instance = var2.Instance
        if instance:IsA("BasePart") and instance.Transparency < 1 then
            return instance
        end
        table.insert(filterDescendantsInstances, instance)
    end
    return nil
end

local function createViewerWorldPicker(tbl1)
    local tbl2 = ({})

    local function pick(inputObject: InputObject) -- Luacid: Inlined by compiler; 2 call sites recovered
        local var1 = raycast(tbl1.camera, tbl1.world, toScreenPoint(inputObject))
        if var1 ~= nil then
            tbl1.onPick(var1)
        elseif tbl1.onMiss ~= nil then
            tbl1.onMiss()
        end
    end

    local tbl3 = {
        tbl1.userInputService.InputBegan:Connect(function(input: InputObject, bool1: boolean)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                if not (bool1 or tbl1.isBlocked()) then
                    pick(input)
                end

                return
            end

            if input.UserInputType ~= Enum.UserInputType.Touch then
                return
            end

            local isGesture = bool1 or tbl1.isBlocked() or next(tbl2) ~= nil
            for _, value in tbl2 do
                value.isGesture = true
            end

            tbl2[input] = {
                start = toScreenPoint(input),
                isGesture = isGesture
            }
        end),
        tbl1.userInputService.InputChanged:Connect(function(input: InputObject)
            local var1 = tbl2[input]

            if var1 ~= nil and (toScreenPoint(input) - var1.start).Magnitude > 12 then
                var1.isGesture = true
            end
        end),
        tbl1.userInputService.InputEnded:Connect(function(input: InputObject, bool1: boolean)
            local var1 = tbl2[input]
            if var1 == nil then
                return
            end
            tbl2[input] = nil

            if var1.isGesture
                or bool1
                or input.UserInputState == Enum.UserInputState.Cancel
                or (toScreenPoint(input) - var1.start).Magnitude > 12
                or tbl1.isBlocked()
            then
                return
            end

            pick(input)
        end)
    }

    return function()
        for _, value in tbl3 do
            value:Disconnect()
        end
        table.clear(tbl2)
    end
end

return createViewerWorldPicker
