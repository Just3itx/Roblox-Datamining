-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:31:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SceneUnderstanding = script:FindFirstAncestor("SceneUnderstanding")

local DataModelTraversalOptions = require(SceneUnderstanding.options.DataModelTraversalOptions)

local function createLazyInstanceCollector(tbl1, func1: ((...any) -> (...any))?, arg1)
    local dataModelTraversalOptions = DataModelTraversalOptions.new(arg1)

    local bool1 = false
    local get = {}
    local num1 = 0
    local tbl3 = {}
    local var1 = nil
    local tbl4 = {}
    local tbl5 = ({})

    local function getBatchCount(): number -- Luacid: Inlined by compiler; 2 call sites recovered
        return math.min(#tbl4, dataModelTraversalOptions.instanceProcessingLimit)
    end

    local function onAncestryChanged(child: Instance)
        if child.Parent ~= nil then
            return
        end

        local var2 = table.find(get, child)
        if var2 then
            table.remove(get, var2)
        end
    end

    local function processStack(): boolean
        local batchCount = getBatchCount()

        for _ = 1, batchCount do
            local var2 = table.remove(tbl4, #tbl4)

            if not var2 then
                continue
            end

            if not func1 or func1(var2) then
                table.insert(get, var2)
                table.insert(tbl3, var2.AncestryChanged:Connect(onAncestryChanged))
            end

            for _, child in var2:GetChildren() do
                table.insert(tbl4, child)
            end
        end

        num1 += batchCount

        for value in tbl5 do
            task.spawn(function()
                value(get)
            end)
        end

        if #tbl4 == 0 then
            bool1 = false

            return false
        end

        if not (num1 >= dataModelTraversalOptions.instanceProcessingLimit) then
            return false
        end

        num1 = 0
        return true
    end

    local function startProcessingLoop() -- Luacid: Inlined by compiler; 3 call sites recovered
        if bool1 or getBatchCount() == 0 then
            return
        end

        bool1 = true

        processStack()

        var1 = task.spawn(function()
            task.wait()

            while bool1 do
                local bool2 = processStack()

                if bool1 and bool2 then
                    task.wait()
                end
            end
        end)
    end

    local function onDescendantAdded(descendant: Instance)
        table.insert(tbl4, descendant)

        if not bool1 then
            startProcessingLoop()
        end
    end

    return {
        setInstancesProcessedPerFrame = function(num2: number)
            dataModelTraversalOptions.instanceProcessingLimit = math.clamp(num2, 0, math.huge)
            startProcessingLoop()
        end,
        listen = function()
            for _, value in tbl1 do
                table.insert(tbl3, value.DescendantAdded:Connect(onDescendantAdded))

                for _, child in value:GetChildren() do
                    table.insert(tbl4, child)
                end
            end

            startProcessingLoop()
        end,
        get = function()
            return get
        end,
        destroy = function()
            bool1 = false

            for _, value in tbl3 do
                value:Disconnect()
            end

            tbl5 = {}

            if var1 then
                task.cancel(var1)
            end
        end,
        onStepped = function(func2: (...any) -> (...any))
            tbl5[func2] = true
            return function()
                tbl5[func2] = nil
            end
        end
    }
end

return createLazyInstanceCollector
