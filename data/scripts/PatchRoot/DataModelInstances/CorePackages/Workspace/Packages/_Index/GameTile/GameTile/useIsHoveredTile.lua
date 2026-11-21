-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T22:31:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameTile = script:FindFirstAncestor("GameTile")
local GameTileParent = GameTile.Parent
local React = require(GameTileParent.React)
local _AppCommonLib = require(GameTileParent.AppCommonLib)
local HoverTileCoordinator = require(GameTile.HoverTileCoordinator)

local function useIsHoveredTile(tbl1, str1: string, bool1: boolean, arg1)
    local var1 = arg1 or HoverTileCoordinator.default

    local var2, var3 = React.useState(false)

    React.useEffect(function()
        if not bool1 then
            return
        end

        local function checkAndUpdateState(str2: string?) -- Luacid: Inlined by compiler; 2 call sites recovered
            local bool2 = not (str2 == nil) and str2 == str1
            var3(bool2)
        end

        checkAndUpdateState(var1.hoveredKey)

        local connection = var1.changed:connect(function(arg2)
            checkAndUpdateState(arg2)
        end)

        return function()
            if connection ~= nil then
                connection:disconnect()
                connection = nil
            end
        end
    end, { bool1, str1, var1 })

    React.useEffect(function()
        if not bool1 then
            return
        end

        local tbl2 = {}
        if tbl1.current ~= nil then
            local mouseLeave = tbl1.current.MouseLeave

            table.insert(tbl2, mouseLeave:Connect(function()
                var1:cancelHover(str1)
            end))

            local mouseEnter = tbl1.current.MouseEnter

            table.insert(tbl2, mouseEnter:Connect(function()
                var1:requestHover(str1)
            end))
        end

        return function()
            for _, value in tbl2 do
                value:Disconnect()
            end
        end
    end, {
        str1,
        tbl1,
        bool1,
        var1
    })

    React.useEffect(function()
        return function()
            if str1 then
                var1:cancelHover(str1)
            end
        end
    end, { str1, var1 })

    return bool1 and var2
end

return useIsHoveredTile
