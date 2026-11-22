-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:11:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local Foundation = require(MomentsParent.Foundation)
local _MomentsCommon = require(MomentsParent.MomentsCommon)
local React = require(MomentsParent.React)
local Signals = require(MomentsParent.Signals)

local usePreferences = Foundation.Hooks.usePreferences

local MAX_CONCURRENT_EXPLOSIONS = require(script.Parent.reactionsConstants).MAX_CONCURRENT_EXPLOSIONS

local Context = React.createContext(nil)

return {
    Context = Context,
    Provider = function(tbl1) -- name: ReactionEffectsProvider
        local reducedMotion = usePreferences().reducedMotion

        local var1 = React.useRef(0)
        local layerRef = React.useRef(nil)

        local var3 = React.useRef(reducedMotion)
        var3.current = reducedMotion

        local var4 = React.useMemo(function()
            local get, set = Signals.createSignal({})
            return { get = get, set = set }
        end, {})

        local value = React.useMemo(function()
            return {
                spawnExplosion = function(reactionType, vector2: Vector2?)
                    local current = layerRef.current

                    if var3.current or current == nil then
                        return
                    end
                    local var5 = var4.get(false)
                    if #var5 >= MAX_CONCURRENT_EXPLOSIONS then
                        return
                    end

                    local originLocal = if vector2 ~= nil then vector2 - current.AbsolutePosition else current.AbsoluteSize / 2
                    local var7 = var1
                    var7.current += 1
                    local tbl2 = {
                        id = var1.current,
                        reactionType = reactionType,
                        originLocal = originLocal
                    }
                    local var8 = table.clone(var5)
                    table.insert(var8, tbl2)
                    var4.set(var8)
                end,
                getExplosions = var4.get,
                onExplosionComplete = function(id: number)
                    local tbl2 = {}

                    for _, value in (var4.get(false)) do
                        if value.id ~= id then
                            table.insert(tbl2, value)
                        end
                    end
                    var4.set(tbl2)
                end,
                layerRef = layerRef
            }
        end, { var4 })

        return React.createElement(Context.Provider, { value = value }, tbl1.children)
    end,
    useReactionEffects = function()
        return React.useContext(Context)
    end
}
