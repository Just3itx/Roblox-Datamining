-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T16:00:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RoactPaginator = script:FindFirstAncestor("RoactPaginator")
local fetchInitSymbol = require(RoactPaginator.fetchInitSymbol)
local fetchWithCursorSymbol = require(RoactPaginator.fetchWithCursorSymbol)
local loadNextSymbol = require(RoactPaginator.loadNextSymbol)
local loadPreviousSymbol = require(RoactPaginator.loadPreviousSymbol)
local Logger = require(RoactPaginator.Logger)

local dependencies = require(RoactPaginator.Parent.dependencies)
local Roact = dependencies.Roact
local Cryo = dependencies.Cryo
local GenericPagination = dependencies.GenericPagination

local function formatMessage(tbl1: {string}, tbl2: {any}): string -- Luacid: Inlined by compiler; 1 call site recovered
    return table.concat(tbl1, "\n"):format(unpack(tbl2 or {}))
end

local function connect(arg1)
    assert(arg1 and type(arg1) == "function", "RoactPaginator.connect: parameters expected to be a function")
    local var1 = debug.traceback()

    return function(arg2)
        if arg2 == nil then
            local str1 = formatMessage(
                { "connect returns a function that must be passed a component.", "Check the connection at:", "%s" },
                { var1 }
            )

            error(str1, 2)
        end

        local str1 = ("PaginatorConnection(%s)"):format(tostring(arg2))

        local var2 = Roact.Component:extend(str1)

        function var2.init(arg3)
            local var3 = arg1()
            assert(var3, "RoactPaginator.connect: Expected parameters to return an object")

            arg3.paginator = GenericPagination.new({
                pageSize = var3.pageSize,
                fetchInit = arg3.props[fetchInitSymbol],
                fetchWithCursor = arg3.props[fetchWithCursorSymbol]
            })
        end

        function var2.render(arg3)
            local var3 = Cryo.Dictionary.join(arg3.props, {
                [loadNextSymbol] = function()
                    if arg3.paginator:isFetching() then
                        return
                    end

                    arg3.paginator:getNext():catch(function(arg4)
                        Logger:error("Could not getNext. Got error: {}", arg4)
                    end)
                end,
                [loadPreviousSymbol] = function()
                    if arg3.paginator:isFetching() then
                        return
                    end

                    arg3.paginator:getPrevious():catch(function(arg4)
                        Logger:error("Could not getPrevious. Got error: {}", arg4)
                    end)
                end
            })

            return Roact.createElement(arg2, var3)
        end

        return var2
    end
end

return connect
