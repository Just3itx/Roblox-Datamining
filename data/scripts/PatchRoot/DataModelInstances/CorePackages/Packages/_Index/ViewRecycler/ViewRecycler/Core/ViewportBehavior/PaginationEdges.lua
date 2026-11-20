-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:21:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FFlagViewRecyclerReact084 = require(script:FindFirstAncestor("ViewRecycler").Flags).FFlagViewRecyclerReact084
local FFlagViewRecyclerReact08 = require(script:FindFirstAncestor("ViewRecycler").Flags).FFlagViewRecyclerReact08
local ViewRecycler = script:FindFirstAncestor("ViewRecycler")

local DataSourceChangeType = require(ViewRecycler.Core.Enums.DataSourceChangeType)
local ReachedThreshold = require(ViewRecycler.Core.ViewportBehavior.ReachedThreshold)
local _Types = require(ViewRecycler.Core.Types)

local module = {}
local var1

if FFlagViewRecyclerReact084 then
    var1 = function(tbl1) -- name: validate
        if tbl1.startReachedThreshold ~= nil then
            ReachedThreshold.validate(tbl1.startReachedThreshold, "Virtualizer: startReachedThreshold")
        end
    end
else
    var1 = nil
    var1 = FFlagViewRecyclerReact08 and function(tbl1) -- name: validate
        if tbl1.startReachedThreshold ~= nil then
            ReachedThreshold.validate(tbl1.startReachedThreshold, "Virtualizer: startReachedThreshold")
        end
    end or var1
end

function module.hasStructuralChange(arg1)
    for _, value in arg1.changes do
        if value.type ~= DataSourceChangeType.Update then
            return true
        end
    end
    return false
end

if FFlagViewRecyclerReact084 then
    function module.create(tbl1)
        var1(tbl1)
        local tbl2 = tbl1
        local bool1 = true
        local bool2 = true

        return {
            configure = function(arg1)
                var1(arg1)
                tbl2 = arg1
            end,
            isEnabled = function()
                return tbl2.startReachedEnabled or tbl2.endReachedEnabled
            end,
            check = function(arg1, arg2)
                if arg2 then
                    bool1 = true
                    bool2 = true
                end

                local bool3 = ReachedThreshold.resolve(tbl2.startReachedThreshold, arg1.viewportLength, 0) >= arg1.scrollOffset
                local atEnd = arg1.atEnd
                local startReachedEnabled = bool3 and bool1 and tbl2.startReachedEnabled
                local endReachedEnabled = atEnd and bool2 and tbl2.endReachedEnabled

                if startReachedEnabled then
                    bool1 = false
                elseif not bool3 then
                    bool1 = true
                end
                if endReachedEnabled then
                    bool2 = false
                    return startReachedEnabled, endReachedEnabled
                end

                if not atEnd then
                    bool2 = true
                end

                return startReachedEnabled, endReachedEnabled
            end
        }
    end
elseif FFlagViewRecyclerReact08 then
    function module.create(tbl1)
        var1(tbl1)
        local tbl2 = tbl1
        local bool1 = true
        local bool2 = true

        return {
            configure = function(arg1)
                var1(arg1)
                tbl2 = arg1
            end,
            isEnabled = function()
                return tbl2.startReachedEnabled or tbl2.endReachedEnabled
            end,
            check = function(arg1, arg2)
                if arg2 then
                    bool1 = true
                    bool2 = true
                end

                local bool3 = ReachedThreshold.resolve(tbl2.startReachedThreshold, arg1.viewportLength, 0) >= arg1.scrollOffset
                local atEnd = arg1.atEnd
                local startReachedEnabled = bool3 and bool1 and tbl2.startReachedEnabled
                local endReachedEnabled = atEnd and bool2 and tbl2.endReachedEnabled

                if startReachedEnabled then
                    bool1 = false
                elseif not bool3 then
                    bool1 = true
                end
                if endReachedEnabled then
                    bool2 = false
                    return startReachedEnabled, endReachedEnabled
                end

                if not atEnd then
                    bool2 = true
                end

                return startReachedEnabled, endReachedEnabled
            end
        }
    end
else
    function module.create(_)
        local bool1 = true
        local bool2 = true

        return {
            check = function(tbl1)
                if tbl1.rearmAfterStructureChange then
                    bool1 = true
                    bool2 = true
                end

                local bool3 = tbl1.scrollOffset <= tbl1.startThreshold
                local atEnd = tbl1.atEnd
                local canReachStart = bool3 and bool1 and tbl1.canReachStart
                local canReachEnd = atEnd and bool2 and tbl1.canReachEnd

                if canReachStart then
                    bool1 = false
                elseif not bool3 then
                    bool1 = true
                end
                if canReachEnd then
                    bool2 = false
                elseif not atEnd then
                    bool2 = true
                end

                return { startReached = canReachStart, endReached = canReachEnd }
            end
        }
    end
end

return module
