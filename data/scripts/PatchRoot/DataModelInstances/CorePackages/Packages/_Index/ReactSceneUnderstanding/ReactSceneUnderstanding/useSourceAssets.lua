-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:41:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ReactSceneUnderstanding = script:FindFirstAncestor("ReactSceneUnderstanding")

local React = require(ReactSceneUnderstanding.Parent.React)
local SceneUnderstanding = require(ReactSceneUnderstanding.Parent.SceneUnderstanding)
local SceneAnalysisContext = require(ReactSceneUnderstanding.SceneAnalysisContext)
local useCurrentCamera = require(ReactSceneUnderstanding.useCurrentCamera)
local useCameraState = require(ReactSceneUnderstanding.useCameraState)
local enums = require(ReactSceneUnderstanding.enums)

local getSourceAssetsInView = SceneUnderstanding.getSourceAssetsInView
local getSourceAssetsInRange = SceneUnderstanding.getSourceAssetsInRange
local useCallback = React.useCallback
local useEffect = React.useEffect

local function useSourceAssets(tbl1)
    local var1 = useCurrentCamera()

    local var2 = SceneAnalysisContext.use()
    local var3 = useCameraState(var1)

    local var4 = useCallback(function(tbl2, tbl3)
        if #tbl3 ~= #tbl2 then
            return true
        end

        for _, value in tbl2 do
            if not table.find(tbl3, value) then
                return true
            end
        end

        return false
    end, {})

    local var5 = useCallback(function()
        local sourceAssetsInView = getSourceAssetsInView(var1, if tbl1 then tbl1.viewportQueryOptions else nil)
        var2.setAssetsInView(function(arg1)
            return if var4(arg1, sourceAssetsInView) then sourceAssetsInView else arg1
        end)

        local sourceAssetsInRange = getSourceAssetsInRange(var1.CFrame.Position, if tbl1 then tbl1.rangeQueryOptions else nil)
        var2.setAssetsInRange(function(arg1)
            return if var4(arg1, sourceAssetsInRange) then sourceAssetsInRange else arg1
        end)
    end, { var1, tbl1, var2 })

    useEffect(function()
        local connection = workspace.DescendantAdded:Connect(function(descendant: Instance)
            if SceneUnderstanding.isSourceAsset(descendant) then
                var5()
            end
        end)

        var5()

        return function()
            connection:Disconnect()
        end
    end, { var5 })

    useEffect(function()
        if var3 == enums.CameraState.Idle then
            var5()
        end
    end, { var3 })

    return {
        assetsInRange = var2.assetsInRange,
        assetsInView = var2.assetsInView
    }
end

return useSourceAssets
