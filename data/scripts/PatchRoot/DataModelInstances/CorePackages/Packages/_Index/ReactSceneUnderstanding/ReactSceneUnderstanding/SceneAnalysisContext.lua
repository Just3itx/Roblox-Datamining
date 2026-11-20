-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:41:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ReactSceneUnderstanding = script:FindFirstAncestor("ReactSceneUnderstanding")

local React = require(ReactSceneUnderstanding.Parent.React)
local _SceneUnderstanding = require(ReactSceneUnderstanding.Parent.SceneUnderstanding)

local useState = React.useState

local context = React.createContext(nil)

return {
    Provider = function(tbl1) -- name: SceneAnalysisProvider
        local sourceAssets, setSourceAssets = useState({})
        local assetsInView, setAssetsInView = useState({})
        local assetsInRange, setAssetsInRange = useState({})
        local audibleSounds, setAudibleSounds = useState({})

        return React.createElement(context.Provider, {
            value = {
                rangeQueryOptions = tbl1.rangeQueryOptions,
                viewportQueryOptions = tbl1.viewportQueryOptions,
                dataModelTraversalOptions = tbl1.dataModelTraversalOptions,
                sourceAssets = sourceAssets,
                setSourceAssets = setSourceAssets,
                assetsInView = assetsInView,
                setAssetsInView = setAssetsInView,
                assetsInRange = assetsInRange,
                setAssetsInRange = setAssetsInRange,
                audibleSounds = audibleSounds,
                setAudibleSounds = setAudibleSounds
            }
        }, tbl1.children)
    end,
    use = function()
        local var1 = React.useContext(context)

        if var1 then
            return var1
        end
        error(
            "attempt to use SceneAnalysisContext with no provider. Add `ReactSceneUnderstanding.SceneAnalysisProvider` to the React tree and try again"
        )
    end
}
