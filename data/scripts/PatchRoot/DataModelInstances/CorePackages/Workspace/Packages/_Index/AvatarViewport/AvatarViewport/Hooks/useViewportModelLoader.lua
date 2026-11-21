-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T05:21:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarViewport = script:FindFirstAncestor("AvatarViewport")
local AvatarViewportParent = AvatarViewport.Parent

local React = require(AvatarViewportParent.React)

local _Types = require(AvatarViewport.Types)

local function destroyLoadedModel(tbl1) -- Luacid: Inlined by compiler; 2 call sites recovered
    local current = tbl1.current
    if current then
        current:Destroy()
        tbl1.current = nil
    end
end

local function useViewportModelLoader(tbl1)
    local isLoading, var2 = React.useState(true)
    local isReady, var4 = React.useState(false)
    local model, var6 = React.useState(nil)
    local var7 = React.useRef(0)
    local var8 = React.useRef(nil)

    local var9 = React.useRef(tbl1.onModelReady)
    local var10 = React.useRef(tbl1.onLoadFailed)
    var9.current = tbl1.onModelReady
    var10.current = tbl1.onLoadFailed

    local var11 = React.useCallback(function(bool1: boolean)
        local modelSource = tbl1.modelSource
        local var11 = var7
        var11.current += 1
        local current = var7.current

        if bool1 then
            var2(true)
        end
        var4(false)
        var6(nil)
        destroyLoadedModel(var8)

        task.spawn(function()
            local function isCancelled(): boolean -- Luacid: Inlined by compiler; 1 call site recovered
                return var7.current ~= current
            end

            local var12 = modelSource({ isCancelled = isCancelled })

            if isCancelled() then
                if var12 and var12.model then
                    var12.model:Destroy()
                end

                return
            end

            if not var12 then
                if bool1 then
                    var2(false)
                end
                if var10.current then
                    var10.current()
                end

                return
            end

            local current2 = tbl1.worldModelRef.current
            if not current2 then
                var12.model:Destroy()
                if bool1 then
                    var2(false)
                end
                return
            end

            var12.model.Parent = current2
            var8.current = var12.model
            var6(var12.model)
            var4(true)
            if bool1 then
                var2(false)
            end
            if var9.current then
                var9.current(var12)
            end
        end)
    end, { tbl1.modelSource, tbl1.worldModelRef })

    React.useLayoutEffect(function()
        var11(true)
        return function()
            local var12 = var7
            var12.current += 1
            var4(false)
            var6(nil)
            destroyLoadedModel(var8)
        end
    end, { var11 })

    return { isLoading = isLoading, isReady = isReady, model = model }
end

return useViewportModelLoader
