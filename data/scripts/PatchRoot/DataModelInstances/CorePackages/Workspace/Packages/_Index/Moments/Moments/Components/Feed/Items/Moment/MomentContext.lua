-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:10:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local React = require(MomentsParent.React)
local MomentsCommon = require(MomentsParent.MomentsCommon)
local ReactOtter = require(MomentsParent.ReactOtter)
local Signals = require(MomentsParent.Signals)
local GetFFlagMomentsRenderPostAssets = require(MomentsParent.MomentsCommon.GetFFlagMomentsRenderPostAssets)

local createMomentStore = require(script.Parent.createMomentStore)

local MediaPreloadProvider = MomentsCommon.Media.MediaPreloadProvider

local tbl1 = {
    duration = 0.08,
    easingStyle = Enum.EasingStyle.Quad
}

local Context = React.createContext(nil)

return table.freeze({
    Context = Context,
    Provider = function(tbl2) -- name: MomentProvider
        local data = tbl2.data

        local store = React.useMemo(function()
            return createMomentStore(data)
        end, { if GetFFlagMomentsRenderPostAssets() then tbl2.dataVersion or false else nil })

        local var2 = MediaPreloadProvider.useMediaControllerProvider()
        local controller, var4 = React.useState(nil)

        React.useEffect(function()
            return (Signals.createEffect(function(arg1)
                if var2 == nil then
                    return
                end

                local var5 = var2.getControllerMap(arg1)[data.momentId]
                if var5 == nil then
                    return
                end

                var4(var5)
            end))
        end, { data.momentId, var2 })

        local animationRatio, var6 = ReactOtter.useAnimatedBinding(0)

        React.useEffect(function()
            return (Signals.createEffect(function(arg1)
                local isScrubbing = store.getIsScrubbing(arg1)
                var6(ReactOtter.ease(if isScrubbing then 1 else 0, tbl1))
            end))
        end, { store })

        local value = React.useMemo(function()
            return {
                momentId = data.momentId,
                controller = controller,
                store = store,
                animationRatio = animationRatio
            }
        end, {
            data.momentId,
            controller,
            store,
            animationRatio
        })

        return React.createElement(Context.Provider, { value = value }, tbl2.children)
    end,
    useMoment = function()
        local var1 = React.useContext(Context)
        if var1 == nil then
            error("useMoment must be used within a MomentProvider")
        end
        return var1
    end,
    SCRUB_FADE_SECONDS = tbl1.duration
})
