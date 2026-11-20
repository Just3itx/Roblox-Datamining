-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T06:31:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent
local React = require(FoundationParent.React)

local elevation = require(script.Parent.elevation)

local ElevationLayer = require(Foundation.Enums.ElevationLayer)

local context = React.createContext(nil)
local context2 = React.createContext(nil)

return {
    ElevationProvider = function(tbl1)
        local var1 = React.useRef({
            [ElevationLayer.Popover] = 0,
            [ElevationLayer.Floating] = 0,
            [ElevationLayer.Drawer] = 0,
            [ElevationLayer.Sheet] = 0,
            [ElevationLayer.Dialog] = 0,
            [ElevationLayer.Notification] = 0
        })

        local value = React.useMemo(function()
            return {
                acquire = function(layer, tbl2)
                    local var2 = elevation.ELEVATION_LAYERS[layer]
                    local num1 = -1

                    local bool1 = true
                    local var3

                    if tbl2.owner then
                        var3 = tbl2.owner.zIndex + 1
                        bool1 = tbl2.owner.zIndex <= var2.finish
                    elseif tbl2.reserve then
                        num1 = var1.current[layer] or 0
                        var3 = var2.start + (num1 + 1) * var2.step
                        var1.current[layer] = num1 + 1
                    else
                        var3 = var2.start
                    end

                    if bool1 and var2.finish < var3 then
                        warn(
                            string.format(
                                "Layer '%s' capacity exceeded (%d/%d). Capping zIndex at %d.",
                                tostring(layer),
                                var3,
                                var2.finish,
                                var2.finish
                            )
                        )
                        var3 = var2.finish
                    end

                    return { layer = layer, index = num1, zIndex = var3 }
                end,
                peek = function(arg1)
                    return var1.current[arg1] or 0
                end,
                releaseIfTop = function(arg1, num1: number)
                    local var2 = var1.current[arg1] or 0

                    if num1 ~= nil and num1 >= 0 and num1 == var2 - 1 then
                        var1.current[arg1] = var2 - 1
                    end
                end
            }
        end, {})

        return React.createElement(context.Provider, { value = value }, tbl1.children)
    end,
    ElevationOwnerScope = function(arg1)
        return React.createElement(context2.Provider, { value = arg1.owner }, arg1.children)
    end,
    useElevationManager = function()
        local var1 = React.useContext(context)

        if not var1 then
            error("useElevationManager must be used under <ElevationProvider>")
        end

        return var1
    end,
    useOwnerToken = function()
        return (React.useContext(context2))
    end
}
