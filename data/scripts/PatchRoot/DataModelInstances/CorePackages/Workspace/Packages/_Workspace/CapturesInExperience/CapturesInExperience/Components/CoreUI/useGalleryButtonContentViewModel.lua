-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:41:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local Foundation = require(scriptParentParentParentParent.Foundation)
local React = require(scriptParentParentParentParent.React)
local ReactOtter = require(scriptParentParentParentParent.ReactOtter)

local _GalleryButtonContentView = require(script.Parent.GalleryButtonContentView)
local _Types = require(scriptParentParentParent.Types)

local useTokens = Foundation.Hooks.useTokens

local tbl1 = { dampingRatio = 1, frequency = 4 }

local function getOtherSlot(arg1): number -- Luacid: Inlined by compiler; 1 call site recovered
    return if arg1 == 1 then 2 else 1
end

local function getThumbnailProgress(tbl2, num1: number) -- Luacid: Inlined by compiler; 2 call sites recovered
    return if num1 == 1 then tbl2.thumbnail1 else tbl2.thumbnail2
end

local function getProgressGoal(bool1: boolean) -- Luacid: Inlined by compiler; 3 call sites recovered
    return ReactOtter.spring(if bool1 then 1 else 0, tbl1)
end

local function createThumbnailBindings(arg1, num1: number)
    return {
        style = arg1:map(function(tbl2)
            return {
                Color3 = Color3.new(1, 1, 1),
                Transparency = 1 - math.clamp(if num1 == 1 then getThumbnailProgress(tbl2, 1) else tbl2.thumbnail2, 0, 1)
            }
        end),
        scale = arg1:map(function(tbl2): number
            return math.lerp(0.5, 1, math.clamp(if num1 == 1 then getThumbnailProgress(tbl2, 1) else tbl2.thumbnail2, 0, 1))
        end)
    }
end

local function useGalleryButtonContentViewModel(current)
    local var1 = useTokens()

    local activeSlot, var3 = React.useState(1)
    local slotCaptures, var5 = React.useState({ current })
    local var6 = React.useRef(1)
    local var7 = React.useRef(current)

    local var8 = React.useCallback(function()
        var5(function(arg2)
            return if current then {
                [activeSlot] = arg2[activeSlot]
            } else {}
        end)
    end, { current, activeSlot })

    local var9, var10 = ReactOtter.useAnimatedBinding(
        {
            icon = if current then 1 else 0,
            thumbnail1 = if current then 1 else 0,
            thumbnail2 = 0
        },
        var8
    )

    React.useEffect(function()
        local current3 = var7.current
        var7.current = current
        if current3 == current then
            return
        end

        local current2 = var6.current
        if current3 and current then
            current2 = getOtherSlot(current2)
            var6.current = current2
        end

        if current then
            var5(function(arg2)
                local var11 = table.clone(arg2)
                var11[current2] = current
                return var11
            end)
        end
        var3(current2)
        var10({
            icon = getProgressGoal(current ~= nil),
            thumbnail1 = getProgressGoal(not (current == nil) and current2 == 1),
            thumbnail2 = getProgressGoal(not (current == nil) and current2 == 2)
        })
    end, { current })

    local emphasis = var1.Color.Content.Emphasis

    local var11 = React.useMemo(function()
        return {
            iconStyle = var9:map(function(tbl2)
                return {
                    Color3 = emphasis.Color3,
                    Transparency = math.lerp(emphasis.Transparency, 1, math.clamp(tbl2.icon, 0, 1))
                }
            end),
            iconScale = var9:map(function(tbl2): number
                return math.lerp(1, 0.5, math.clamp((tbl2.icon - 0.1) / 0.9, 0, 1))
            end),
            thumbnails = { createThumbnailBindings(var9, 1), (createThumbnailBindings(var9, 2)) }
        }
    end, { var9, emphasis })

    return {
        activeSlot = activeSlot,
        slotCaptures = slotCaptures,
        iconStyle = var11.iconStyle,
        iconScale = var11.iconScale,
        thumbnails = var11.thumbnails
    }
end

return useGalleryButtonContentViewModel
