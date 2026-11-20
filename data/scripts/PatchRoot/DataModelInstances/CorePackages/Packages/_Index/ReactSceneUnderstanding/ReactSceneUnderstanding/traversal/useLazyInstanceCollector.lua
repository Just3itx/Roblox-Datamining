-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:41:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ReactSceneUnderstanding = script:FindFirstAncestor("ReactSceneUnderstanding")

local Cryo = require(ReactSceneUnderstanding.Parent.Cryo)
local React = require(ReactSceneUnderstanding.Parent.React)
local ReactUtils = require(ReactSceneUnderstanding.Parent.ReactUtils)
local SceneUnderstanding = require(ReactSceneUnderstanding.Parent.SceneUnderstanding)

local DataModelTraversalOptions = SceneUnderstanding.DataModelTraversalOptions

local useEffect = React.useEffect
local useMemo = React.useMemo
local useState = React.useState
local usePrevious = ReactUtils.usePrevious

local function useLazyInstanceCollector(tbl1, func1: ((...any) -> (...any))?, arg1)
    local dataModelTraversalOptions = DataModelTraversalOptions.new(arg1)

    local var1 = usePrevious(arg1)

    local var2 = useMemo(function()
        return SceneUnderstanding.createLazyInstanceCollector(tbl1, func1, arg1)
    end, Cryo.List.join(tbl1, { func1 }))

    local var3, var4 = useState({})

    if arg1 and var1 and arg1.instanceProcessingLimit ~= var1.instanceProcessingLimit then
        var2.setInstancesProcessedPerFrame(dataModelTraversalOptions.instanceProcessingLimit)
    end

    useEffect(function()
        var2.onStepped(function(arg2)
            var4(table.clone(arg2))
        end)
        var2.listen()

        return function()
            var2.destroy()
        end
    end, { var2 })

    return var3
end

return useLazyInstanceCollector
